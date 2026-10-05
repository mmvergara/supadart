import 'package:supabase/supabase.dart';

import 'datatypes/string/character.dart';
import 'datatypes/string/character_array.dart';
import 'datatypes/string/character_varying.dart';
import 'datatypes/string/character_varying_array.dart';
import 'datatypes/string/text.dart';
import 'datatypes/string/text_array.dart';
import 'datatypes/string/uuid.dart';
import 'datatypes/string/uuid_array.dart';

Future<void> performStringTypesTest(SupabaseClient supabase) async {
  // String Types
  // STES = Supabase Table Editor Supported (PRIORITIZED)
  await performTextTest(supabase);
  await performTextArrayTest(supabase);

  await performCharacterVaryingTest(supabase);
  await performCharacterVaryingArrayTest(supabase);

  await performUUIDTest(supabase);
  await performUUIDArrayTest(supabase);

  // Other String Types
  await performCharacterTest(supabase);
  await performCharacterArrayTest(supabase);
}
