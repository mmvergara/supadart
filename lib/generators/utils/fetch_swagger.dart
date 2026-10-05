import 'dart:convert';
import 'package:http/http.dart' as http;
import '../swagger/column.dart';
import '../swagger/swagger.dart';
import '../../key_check.dart';
import 'supabase_request.dart';

/// Fetches the PostgREST schema of each of [schemas] (the first is the
/// primary, see [DatabaseSwagger.fromSchemas]), or null if any fails.
Future<DatabaseSwagger?> fetchDatabaseSwagger(String url, String apiKey,
    Map<String, List<String>> mapOfEnums, bool jsonbToDynamic,
    {List<String> schemas = const ['public'],
    Map<String, JsonbModelConfig>? jsonbModels,
    http.Client? client}) async {
  url = withScheme(url);

  try {
    final specs = <String, Map<String, dynamic>>{};
    for (final schema in schemas) {
      final spec = await _fetchSchema(url, apiKey, schema, client);
      if (spec == null) return null;
      specs[schema] = spec;
    }
    return DatabaseSwagger.fromSchemas(specs, mapOfEnums, jsonbToDynamic,
        jsonbModels: jsonbModels);
  } catch (e) {
    print("Error fetching Supabase Swagger: $e");
  }

  return null;
}

Future<Map<String, dynamic>?> _fetchSchema(
    String url, String apiKey, String schema, http.Client? client) async {
  // PostgREST serves the schema named here, if it is exposed.
  final headers = {'Accept-Profile': schema};

  // First attempt with API key
  final response = await supabaseGet('$url/rest/v1/',
      apiKey: apiKey, headers: headers, client: client);
  if (response.statusCode == 200) return jsonDecode(response.body);
  if (response.body.contains('PGRST106')) {
    print("Failed to fetch Supabase Swagger: ${response.body}");
    print(schemaNotExposedMessage(schema));
    return null;
  }

  // Second attempt without API key (for open/public APIs)
  print("Trying without the API key...");
  final response2 =
      await supabaseGet('$url/rest/v1/', headers: headers, client: client);
  if (response2.statusCode == 200) return jsonDecode(response2.body);

  print("Failed to fetch Supabase Swagger for schema '$schema'. "
      "Status code: ${response2.statusCode}");
  print("Response body: ${response2.body}");
  if ([401, 403].contains(response.statusCode) ||
      [401, 403].contains(response2.statusCode)) {
    print(schemaForbiddenMessage());
  }
  return null;
}

String schemaNotExposedMessage(String schema) => '''
The schema "$schema" is not exposed through the Supabase API. Add it under
Project Settings > Data API > Exposed schemas (hosted projects), or to
schemas under [api] in supabase/config.toml (local), then try again.''';
