import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/big_int.dart';

import 'datatypes/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';
import 'datatypes/bytea.dart';
import 'datatypes/character.dart';
import 'datatypes/character_varying.dart';
import 'datatypes/int.dart';
import 'datatypes/small_int.dart';
import 'datatypes/text.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }

  final supabase = SupabaseClient(url, anonKey);
  await performSmallintTest(supabase);
  await performIntegerTest(supabase);
  await performBigIntTest(supabase);
  // await performCharacterVaryingTest(supabase);
  // await performCharacterTest(supabase);
  // await performTextTest(supabase);
  // await performBigSerialTests(supabase);
  // await performBitTest(supabase);

  // Bit Varying = no "isA" test
  // await performBitVaryingTest(supabase);

  // Box = no "isA" test
  // await performBoxTest(supabase);

  // Not Supported Yet
  // await performByteaTest(supabase);
}
