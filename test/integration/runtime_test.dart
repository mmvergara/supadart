@Tags(['integration'])
library;

import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import '../boolean_bit_types.dart';
import '../datatypes/enums.dart';
import '../datetime_types.dart';
import '../default_values.dart';
import '../json_types.dart';
import '../numeric_types.dart';
import '../other_tables.dart';
import '../string_types.dart';
import '../support/env.dart';
import '../text_types.dart';

/// Round-trips data through the generated models in test/models/ against a
/// live database created from supabase/migrations.
void main() async {
  final env = TestEnv.load();
  if (env == null) {
    test('runtime round-trip', () {}, skip: missingEnvReason);
    return;
  }

  final supabase = SupabaseClient(env.url, env.apiKey);

  // STES = Supabase Table Editor Supported (PRIORITIZED)
  await performNumericTypesTest(supabase);
  await performJsonTypesTest(supabase);
  await performStringTypesTest(supabase);
  await performDatetimeTypesTest(supabase);
  await performBooleanBitTypesTest(supabase);
  await performEnumTypesTest(supabase);
  await performEnumLabelTypesTest(supabase);
  await performTextTypesTest(supabase);
  await performOtherTablesTest(supabase);
  await performDefaultValuesTest(supabase);
}
