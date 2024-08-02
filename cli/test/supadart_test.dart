import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'package:supadart/generator/generator.dart';
import 'package:supadart/generator/swagger.dart';

import '../bin/supadart.dart';
import 'boolean_bit_types.dart';
import 'datetime_types.dart';
import 'json_types.dart';
import 'numeric_types.dart';
import 'string_types.dart';
import 'default_values.dart';

void main() async {
  print("Running Supadart Tests");
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }

  final databaseSwagger = await fetchDatabaseSwagger(url, anonKey);
  if (databaseSwagger == null) {
    print("Failed to fetch database swagger");
    return;
  }
  final files = generateModelFiles(databaseSwagger, false, false);
  await generateAndFormatFiles(files, './test/models/');
  print("\nGenerated Fresh Models from DB");

  final supabase = SupabaseClient(url, anonKey);
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
}
