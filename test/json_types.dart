// import 'package:supabase/supabase.dart';
// Future<void> performTypesTest(SupabaseClient supabase) async {}

import 'package:supabase/supabase.dart';

import 'datatypes/json/json.dart';
import 'datatypes/json/json_array.dart';
import 'datatypes/json/jsonb.dart';
import 'datatypes/json/jsonb_array.dart';

Future<void> performJsonTypesTest(SupabaseClient supabase) async {
  // JSON Types
  // STES = Supabase Table Editor Supported (PRIORITIZED)
  await performJsonTest(supabase);
  await performJsonArrayTest(supabase);

  await performJsonBTest(supabase);
  await performJsonBArrayTest(supabase);
}
