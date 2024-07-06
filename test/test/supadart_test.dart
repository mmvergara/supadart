import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

import 'boolean_bit_types.dart';
import 'datetime_types.dart';
import 'json_types.dart';
import 'numeric_types.dart';
import 'string_types.dart';
import 'default_values.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }

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
