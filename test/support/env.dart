import 'package:dotenv/dotenv.dart';

/// Connection details for the Supabase instance used by integration tests.
class TestEnv {
  final String url;
  final String apiKey;

  const TestEnv(this.url, this.apiKey);

  /// Reads SUPABASE_URL and SUPABASE_API_KEY (or the legacy SUPABASE_ANON_KEY)
  /// from the environment or a .env file. Returns null when either is missing.
  static TestEnv? load() {
    final env = DotEnv(includePlatformEnvironment: true, quiet: true)..load();
    final url = env['SUPABASE_URL'];
    final key = env['SUPABASE_API_KEY'] ?? env['SUPABASE_ANON_KEY'];
    if (url == null || url.isEmpty || key == null || key.isEmpty) return null;
    return TestEnv(url, key);
  }
}

const String missingEnvReason =
    'SUPABASE_URL / SUPABASE_API_KEY not set. Run tool/test_integration.sh '
    'to start a local Supabase instance and run these tests.';
