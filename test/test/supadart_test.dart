import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/boolean_bit/stes_bool_arr.dart';
import 'datatypes/datetime/stes_date.dart';
import 'datatypes/datetime/stes_date_array.dart';
import 'datatypes/datetime/stes_time_array.dart';
import 'datatypes/numeric/numeric_array.dart';
import 'datatypes/numeric/stes_float4_real_array.dart';
import 'datatypes/numeric/stes_float8_double_precision_array.dart';
import 'datatypes/numeric/stes_int2_small_int_array.dart';
import 'datatypes/numeric/stes_int4_int_array.dart';
import 'datatypes/numeric/stes_int8_big_int.dart';

import 'datatypes/numeric/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';
import 'datatypes/bytea.dart';
import 'datatypes/numeric/stes_int8_big_int_array.dart';
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
import 'datatypes/string/text.dart';
import 'datatypes/string/text_array.dart';

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
  // await performSmallIntTest(supabase);
  // await performSmallIntArrayTest(supabase);

  // await performIntegerTest(supabase);
  // await performIntegerArrayTest(supabase);

  // await performBigIntTest(supabase);
  // await performBigIntArrayTest(supabase);

  // await performRealTest(supabase);
  // await performRealArrayTest(supabase);

  // await performDoublePrecisionTest(supabase);
  // await performDoublePrecisionArrayTest(supabase);

  // await performNumericTest(supabase);
  // await performNumericArrayTest(supabase);

  // JSON Types
  // await performJsonTest(supabase);
  // todo: performJsonArrayTest(supabase);

  // await performJsonbTest(supabase);
  // todo: performJsonbArrayTest(supabase);

  // String Types
  // await performTextTest(supabase);
  await performTextArrayTest(supabase);

  // await performCharacterVaryingTest(supabase);
  // todo: performCharacterVaryingArrayTest(supabase);

  // await performUuidTest(supabase);
  // todo: performUuidArrayTest(supabase);

  // Date Time Types
  // await performDateTest(supabase);
  // await performDateArrayTest(supabase);

  // await performTimeTest(supabase);
  // await performTimeArrayTest(supabase);

  // await performTimeTzTest(supabase);
  // todo: performTimeTzArrayTest(supabase);

  // await performTimestampTest(supabase);
  // todo: performTimestampArrayTest(supabase);

  // await performTimestamptzTest(supabase);
  // todo: performTimestamptzArrayTest(supabase);

  // Boolean Bit Types
  // await performBooleanTest(supabase);
  // await performBooleanArrayTest(supabase);

  // // ========================================
  // // Not STES - see on repositoryroot/other-types.md

  // // Numeric Types
  // await performBigSerialTests(supabase);

  // // String Types
  // await performCharacterTest(supabase);

  // Boolean Bit Types

  // Geometry Types

  // Network Address Types

  // Binary Data and XML Types

  // Misc Types
}
