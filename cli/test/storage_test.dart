import 'package:dotenv/dotenv.dart';
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:test/test.dart';

void main() {
  test('Fetch Supabase storage information', () async {
    var env = DotEnv(includePlatformEnvironment: true)..load();

    Map<String, dynamic> options = {
      'url': env['SUPABASE_URL'],
      'anonKey': env['SUPABASE_ANON_KEY'],
    };

    if (options['url'] == null || options['anonKey'] == null) {
      print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
      return;
    }

    final storageJson = await fetchStorageList(
      options['url'],
      options['anonKey'],
    );
    if (storageJson == null) {
      print("Failed to fetch storage list");
      return;
    } else {
      expect(storageJson, isNotNull);
    }
  });
}
