import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:supadart/generators/utils/fetch_swagger.dart';
import 'package:supadart/key_check.dart';
import 'package:test/test.dart';

import '../support/generate.dart';

const _url = 'https://example.supabase.co';
const _key = 'sb_secret_test';

/// Runs [body], capturing everything it prints.
Future<(T, String)> _capturePrints<T>(Future<T> Function() body) async {
  final out = StringBuffer();
  final result = await runZoned(body,
      zoneSpecification:
          ZoneSpecification(print: (_, __, ___, line) => out.writeln(line)));
  return (result, out.toString());
}

void main() {
  final swaggerBody = File(swaggerFixturePath).readAsStringSync();

  group('fetchDatabaseSwagger', () {
    test('sends the key in both apikey and Authorization headers', () async {
      late http.Request seen;
      final client = MockClient((req) async {
        seen = req;
        return http.Response(swaggerBody, 200);
      });

      final swagger = await fetchDatabaseSwagger(_url, _key, testEnums, false,
          client: client);

      expect(swagger, isNotNull);
      expect(seen.url.toString(), '$_url/rest/v1/');
      expect(seen.headers['apikey'], _key);
      expect(seen.headers['Authorization'], 'Bearer $_key');
    });

    test('defaults to https when the scheme is missing', () async {
      late Uri seen;
      final client = MockClient((req) async {
        seen = req.url;
        return http.Response(swaggerBody, 200);
      });

      await fetchDatabaseSwagger('example.supabase.co', _key, testEnums, false,
          client: client);

      expect(seen.scheme, 'https');
    });

    test('retries without auth after a failed authenticated request', () async {
      final requests = <http.Request>[];
      final client = MockClient((req) async {
        requests.add(req);
        return requests.length == 1
            ? http.Response('{}', 500)
            : http.Response(swaggerBody, 200);
      });

      final swagger = await fetchDatabaseSwagger(_url, _key, testEnums, false,
          client: client);

      expect(swagger, isNotNull);
      expect(requests, hasLength(2));
      expect(requests[1].headers.containsKey('apikey'), isFalse);
    });

    for (final status in [401, 403]) {
      test('explains the anon key restriction on $status', () async {
        final client = MockClient((_) async => http.Response(
            '{"message":"Access to schema is forbidden"}', status));

        final (result, output) = await _capturePrints(() =>
            fetchDatabaseSwagger(_url, _key, testEnums, false, client: client));

        expect(result, isNull);
        expect(output, contains(schemaForbiddenMessage()));
      });
    }

    test('does not blame the key on other failures', () async {
      final client = MockClient((_) async => http.Response('oops', 500));

      final (_, output) = await _capturePrints(() =>
          fetchDatabaseSwagger(_url, _key, testEnums, false, client: client));

      expect(output, isNot(contains(openApiChangelogUrl)));
      expect(output, contains('Status code: 500'));
    });

    test('returns null on malformed JSON', () async {
      final client = MockClient((_) async => http.Response('not json', 200));

      final (swagger, _) = await _capturePrints(() =>
          fetchDatabaseSwagger(_url, _key, testEnums, false, client: client));

      expect(swagger, isNull);
    });
  });

  group('fetchStorageList', () {
    final storageBody = File(storageFixturePath).readAsStringSync();

    test('parses buckets', () async {
      late http.Request seen;
      final client = MockClient((req) async {
        seen = req;
        return http.Response(storageBody, 200);
      });

      final storage = await fetchStorageList(_url, _key, client: client);

      expect(seen.url.toString(), '$_url/storage/v1/bucket/');
      expect(seen.headers['apikey'], _key);
      expect(storage!.buckets.map((b) => b.name),
          (jsonDecode(storageBody) as List).map((b) => b['name']));
    });

    test('returns null on error status', () async {
      final client = MockClient((_) async => http.Response('nope', 403));

      final (storage, _) = await _capturePrints(
          () => fetchStorageList(_url, _key, client: client));

      expect(storage, isNull);
    });
  });
}
