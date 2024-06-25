import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/datetime/stes_date.dart';
import 'datatypes/numeric/stes_int8_big_int.dart';

import 'datatypes/numeric/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';
import 'datatypes/bytea.dart';
import 'datatypes/string/character.dart';
import 'datatypes/string/character_varying.dart';
import 'datatypes/boolean_bit/stes_bool.dart';
import 'datatypes/numeric/stes_int4_int.dart';
import 'datatypes/numeric/stes_float4_real.dart';
import 'datatypes/numeric/stes_int2_small_int.dart';
import 'datatypes/numeric/stes_float8_double_precision.dart';
import 'datatypes/json/stes_json.dart';
import 'datatypes/json/stes_jsonb.dart';
import 'datatypes/numeric/numeric.dart';
import 'datatypes/datetime/stes_time.dart';
import 'datatypes/datetime/stes_timestamp.dart';
import 'datatypes/datetime/stes_timestamptz.dart';
import 'datatypes/datetime/stes_timetz.dart';
import 'datatypes/string/stes_uuid.dart';
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
  // ========================================
  // STES = Supported Table Editor Supported (PRIORITIZED)
  // Numeric Types
  await performSmallintTest(supabase);
  await performIntegerTest(supabase);
  await performBigIntTest(supabase);
  await performRealTest(supabase);
  await performDoublePrecisionTest(supabase);
  await performNumericTest(supabase);
  // JSON Types
  await performJsonTest(supabase);
  await performJsonbTest(supabase);
  // String Types
  await performTextTest(supabase);
  await performCharacterVaryingTest(supabase);
  await performUuidTest(supabase);
  // Date Time Types
  await performDateTest(supabase);
  await performTimeTest(supabase);
  await performTimeTzTest(supabase);
  await performTimestampTest(supabase);
  await performTimestamptzTest(supabase);
  // Boolean Bit Types
  await performBooleanTest(supabase);

  // ========================================
  // Not STES
  await performCharacterTest(supabase);
  await performBigSerialTests(supabase);
  // await performBitTest(supabase);

  // todo

  // Bit Varying = no "isA" test
  // await performBitVaryingTest(supabase);

  // Box = no "isA" test
  // await performBoxTest(supabase);

  // Not Supported Yet
  // await performByteaTest(supabase);
}
