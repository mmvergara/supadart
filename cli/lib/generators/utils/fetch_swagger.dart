import 'dart:convert';
import 'package:http/http.dart' as http;
import '../swagger/column.dart';
import '../swagger/swagger.dart';
import '../../key_check.dart';
import 'supabase_request.dart';

Future<DatabaseSwagger?> fetchDatabaseSwagger(String url, String apiKey,
    Map<String, List<String>> mapOfEnums, bool jsonbToDynamic,
    {Map<String, JsonbModelConfig>? jsonbModels, http.Client? client}) async {
  url = withScheme(url);

  try {
    // First attempt with API key
    final response =
        await supabaseGet('$url/rest/v1/', apiKey: apiKey, client: client);
    if (response.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response.body), mapOfEnums, jsonbToDynamic,
          jsonbModels: jsonbModels);
    }

    // Second attempt without API key (for open/public APIs)
    print("Trying without the API key...");
    final response2 = await supabaseGet('$url/rest/v1/', client: client);
    if (response2.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response2.body), mapOfEnums, jsonbToDynamic,
          jsonbModels: jsonbModels);
    }

    print(
        "Failed to fetch Supabase Swagger. Status code: ${response2.statusCode}");
    print("Response body: ${response2.body}");
    if ([401, 403].contains(response.statusCode) ||
        [401, 403].contains(response2.statusCode)) {
      print(schemaForbiddenMessage());
    }
  } catch (e) {
    print("Error fetching Supabase Swagger: $e");
  }

  return null;
}
