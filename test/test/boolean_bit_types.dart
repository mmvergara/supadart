import 'package:supabase/supabase.dart';

import 'datatypes/boolean_bit/bool.dart';
import 'datatypes/boolean_bit/bool_arr.dart';

Future<void> performBooleanBitTypesTest(SupabaseClient supabase) async {
  // Boolean Bit Types
  // STES = Supabase Table Editor Supported (PRIORITIZED)
  await performBooleanTest(supabase);
  await performBooleanArrayTest(supabase);

  // Other Boolean  BitTypes
}
