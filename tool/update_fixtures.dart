// Refreshes the test fixtures and goldens from a running Supabase instance.
//
// Usage (from the repo root): tool/test_integration.sh --update
// or with SUPABASE_URL / SUPABASE_API_KEY set: dart run tool/update_fixtures.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../test/support/env.dart';
import '../test/support/generate.dart';

const _encoder = JsonEncoder.withIndent('  ');

Future<void> main() async {
  final env = TestEnv.load();
  if (env == null) {
    stderr.writeln(missingEnvReason);
    exit(1);
  }

  final swagger = await _getJson('${env.url}/rest/v1/', env.apiKey);
  File(swaggerFixturePath).writeAsStringSync('${_encoder.convert(swagger)}\n');

  // Timestamps change on every reset; pin them so the fixture stays stable.
  final buckets = (await _getJson('${env.url}/storage/v1/bucket/', env.apiKey)
          as List<dynamic>)
      .cast<Map<String, dynamic>>()
      .map((b) => {
            ...b,
            'created_at': '1970-01-01T00:00:00.000Z',
            'updated_at': '1970-01-01T00:00:00.000Z',
          })
      .toList()
    ..sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
  File(storageFixturePath).writeAsStringSync('${_encoder.convert(buckets)}\n');
  print('Updated $swaggerFixturePath and $storageFixturePath');

  for (final config in goldenConfigs) {
    final dir = Directory(config.goldenDir);
    if (config.isSeparated && dir.existsSync()) dir.deleteSync(recursive: true);
    final files = await generateFromFixtures(config);
    for (final entry in files.entries) {
      File('${config.goldenDir}${entry.key}')
        ..createSync(recursive: true)
        ..writeAsStringSync(entry.value);
    }
    print('Updated goldens for ${config.name} in ${config.goldenDir}');
  }
}

Future<Object?> _getJson(String url, String apiKey) async {
  final response = await http.get(Uri.parse(url),
      headers: {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'});
  if (response.statusCode != 200) {
    stderr.writeln('GET $url failed: ${response.statusCode} ${response.body}');
    exit(1);
  }
  return jsonDecode(response.body);
}
