@Tags(['integration'])
library;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:test/test.dart';

import '../support/env.dart';
import '../support/generate.dart';

/// Checks that the offline fixtures still describe what a live instance
/// returns, so the golden tests stay meaningful.
void main() {
  final env = TestEnv.load();

  group('live schema', () {
    for (final MapEntry(key: schema, value: path)
        in swaggerFixturePaths.entries) {
      test('matches the $schema swagger fixture', () async {
        final response =
            await http.get(Uri.parse('${env!.url}/rest/v1/'), headers: {
          'apikey': env.apiKey,
          'Authorization': 'Bearer ${env.apiKey}',
          'Accept-Profile': schema,
        });
        expect(response.statusCode, 200, reason: response.body);

        final live = jsonDecode(response.body) as Map<String, dynamic>;
        final fixture = readJsonFixture(path);
        expect(live['definitions'], equals(fixture['definitions']),
            reason: 'schema drifted from $path; '
                'run tool/test_integration.sh --update and review the diff');
      });
    }

    test('matches the storage fixture', () async {
      final live = await fetchStorageList(env!.url, env.apiKey);
      expect(live, isNotNull, reason: 'could not fetch /storage/v1/bucket/');
      expect(live!.buckets.map((b) => b.name).toSet(),
          readStorageFixture().buckets.map((b) => b.name).toSet());
    });
  }, skip: env == null ? missingEnvReason : false);
}
