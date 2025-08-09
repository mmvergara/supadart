import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'package:supadart/generators/index.dart';
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:supadart/generators/utils/fetch_swagger.dart';
import '../bin/supadart.dart';
import 'boolean_bit_types.dart';
import 'datatypes/enums.dart';
import 'datetime_types.dart';
import 'json_types.dart';
import 'numeric_types.dart';
import 'string_types.dart';
import 'default_values.dart';

void main() async {
  print("Running Supadart Tests");

  var env = DotEnv(includePlatformEnvironment: true)..load();
  // Test configs
  // Test configs
  final url = env['SUPABASE_URL'];
  final anonKey = env['SUPABASE_ANON_KEY'];
  final isDart = true;
  final isSeperated = false;
  final mappings = null;
  final mapOfEnums = {
    'mood': ["happy", "sad", "neutral", "excited", "angry"],
    'usergroup': ["USERS", "ADMIN", "MODERATOR"]
  };

  if (url == null || anonKey == null) {
    print("Please Provide the url and key for your supabase instance");
    return;
  }

  final databaseSwagger = await fetchDatabaseSwagger(
    url,
    anonKey,
    mapOfEnums,
    false,
    schema: 'public',
  );
  if (databaseSwagger == null) {
    print("Failed to fetch database swagger");
    return;
  }

  final storageList = await fetchStorageList(url, anonKey);
  if (storageList == null) {
    print("Failed to fetch storage list");
    return;
  }

  // Test config, isDart: true, isSeperated:false, mappings:null
  final files = supadartRun(databaseSwagger, storageList, isDart, isSeperated,
      mappings, [], mapOfEnums, false, false);
  await generateAndFormatFiles(files, './test/models/');
  print("\nGenerated Fresh Models from DB");

  final supabase = SupabaseClient(
    url,
    anonKey,
  );
  // ========================================
  // STES = Supabase Table Editor Supported (PRIORITIZED)

  // Numeric Types
  await performNumericTypesTest(supabase);

  // JSON Types
  await performJsonTypesTest(supabase);

  // String Types
  await performStringTypesTest(supabase);

  // Date Time Types
  await performDatetimeTypesTest(supabase);

  // Boolean Bit Types
  await performBooleanBitTypesTest(supabase);

  // Test Type Default Values
  await performDefaultValuesTest(supabase);

  // Test Enum Types
  await performEnumTypesTest(supabase);
}
