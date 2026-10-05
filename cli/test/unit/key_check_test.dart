import 'dart:convert';

import 'package:supadart/key_check.dart';
import 'package:test/test.dart';

String _jwt(Map<String, dynamic> payload) {
  String part(Object o) =>
      base64Url.encode(utf8.encode(jsonEncode(o))).replaceAll('=', '');
  return '${part({'alg': 'HS256', 'typ': 'JWT'})}.${part(payload)}.signature';
}

void main() {
  group('isPublicApiKey', () {
    test('flags publishable keys', () {
      expect(isPublicApiKey('sb_publishable_abc123'), isTrue);
    });

    test('flags legacy anon JWTs', () {
      expect(isPublicApiKey(_jwt({'iss': 'supabase', 'role': 'anon'})), isTrue);
    });

    test('accepts secret keys', () {
      expect(isPublicApiKey('sb_secret_abc123'), isFalse);
    });

    test('accepts legacy service_role JWTs', () {
      expect(isPublicApiKey(_jwt({'role': 'service_role'})), isFalse);
    });

    test('does not throw on malformed tokens', () {
      expect(isPublicApiKey('not.a.jwt'), isFalse);
      expect(isPublicApiKey('a.b'), isFalse);
      expect(isPublicApiKey(''), isFalse);
      expect(isPublicApiKey('${_jwt({'role': 'anon'})}.extra'), isFalse);
    });

    test('ignores JWTs whose payload is not an object', () {
      final payload = base64Url.encode(utf8.encode('"anon"'));
      expect(isPublicApiKey('h.$payload.s'), isFalse);
    });
  });

  group('maskApiKey', () {
    test('keeps the sb_ prefix and last 4 characters', () {
      expect(maskApiKey('sb_secret_abcdefghijklWXYZ'), 'sb_secret_…WXYZ');
      expect(maskApiKey('sb_publishable_abcdefghijklWXYZ'),
          'sb_publishable_…WXYZ');
    });

    test('shows only the last 4 characters of legacy JWTs', () {
      final jwt = _jwt({'role': 'service_role'});
      expect(maskApiKey(jwt), '…${jwt.substring(jwt.length - 4)}');
    });

    test('hides short keys entirely instead of throwing', () {
      expect(maskApiKey('short'), '…');
      expect(maskApiKey('sb_secret_abc'), 'sb_secret_…');
      expect(maskApiKey(''), '…');
    });
  });

  test('messages link to the Supabase changelog', () {
    expect(publicKeyWarning(), contains(openApiChangelogUrl));
    expect(schemaForbiddenMessage(), contains(openApiChangelogUrl));
  });
}
