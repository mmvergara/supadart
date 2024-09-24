import 'package:dotenv/dotenv.dart';
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:test/test.dart';

void main() {
  test('Fetch Supabase storage information', () async {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    String? url = env['SUPABASE_URL'];
    String? anonKey = env['SUPABASE_ANON_KEY'];

    if (url == null || anonKey == null) {
      print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
      return;
    }

    final storageJson = await fetchStorageList(url, anonKey);
    if (storageJson == null) {
      print("Failed to fetch storage list");
      return;
    } else {
      expect(storageJson, isNotNull);
    }
  });
}
