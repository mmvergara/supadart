import 'dart:convert';

const String openApiChangelogUrl =
    'https://supabase.com/changelog/42949-breaking-change-removing-access-to-openapi-spec-via-the-anon-key';

/// Returns true when [apiKey] is a client-side key (publishable or legacy anon
/// JWT) that hosted Supabase projects no longer accept for the OpenAPI schema.
bool isPublicApiKey(String apiKey) {
  if (apiKey.startsWith('sb_publishable_')) return true;

  final parts = apiKey.split('.');
  if (parts.length != 3) return false;
  try {
    final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    return payload is Map && payload['role'] == 'anon';
  } catch (_) {
    return false;
  }
}

String publicKeyWarning() => '''
Warning: this looks like a publishable/anon key.
Hosted Supabase projects no longer return the database schema for these keys,
so generation will likely fail with a 401/403. Use a secret key (sb_secret_...)
or the legacy service_role key instead. Local Supabase stacks still accept it.
Keep the secret key out of your app and out of git, e.g. in a gitignored .env.
See: $openApiChangelogUrl''';

String schemaForbiddenMessage() => '''
Supabase no longer exposes the OpenAPI schema (/rest/v1/) to anon or
publishable keys on hosted projects (since April 8, 2026).
Use a secret key (sb_secret_...) or the legacy service_role key, and keep it
out of your app and out of git, e.g. in a gitignored .env.
See: $openApiChangelogUrl''';

/// Masks [apiKey] for display, keeping only a known `sb_*_` prefix and the
/// last 4 characters, e.g. `sb_secret_…AbCd`.
String maskApiKey(String apiKey) {
  final prefix =
      RegExp(r'^sb_(secret|publishable)_').firstMatch(apiKey)?.group(0) ?? '';
  final rest = apiKey.substring(prefix.length);
  if (rest.length <= 8) return '$prefix…';
  return '$prefix…${rest.substring(rest.length - 4)}';
}
