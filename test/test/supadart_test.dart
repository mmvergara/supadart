import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/boolean_bit/bool_arr.dart';
import 'datatypes/datetime/date.dart';
import 'datatypes/datetime/date_array.dart';
import 'datatypes/datetime/time_array.dart';
import 'datatypes/datetime/timestamp_array.dart';
import 'datatypes/datetime/timestamptz_array.dart';
import 'datatypes/datetime/timetz_array.dart';
import 'datatypes/numeric/numeric_array.dart';
import 'datatypes/numeric/float4_real_array.dart';
import 'datatypes/numeric/float8_double_precision_array.dart';
import 'datatypes/numeric/int2_small_int_array.dart';
import 'datatypes/numeric/int4_int_array.dart';
import 'datatypes/numeric/int8_big_int.dart';

import 'datatypes/numeric/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';
import 'datatypes/bytea.dart';
import 'datatypes/numeric/int8_big_int_array.dart';
import 'datatypes/string/character.dart';
import 'datatypes/string/character_array.dart';
import 'datatypes/string/character_varying.dart';
import 'datatypes/boolean_bit/bool.dart';
import 'datatypes/numeric/int4_int.dart';
import 'datatypes/numeric/float4_real.dart';
import 'datatypes/numeric/int2_small_int.dart';
import 'datatypes/numeric/float8_double_precision.dart';
import 'datatypes/json/json.dart';
import 'datatypes/json/jsonb.dart';
import 'datatypes/numeric/numeric.dart';
import 'datatypes/datetime/time.dart';
import 'datatypes/datetime/timestamp.dart';
import 'datatypes/datetime/timestamptz.dart';
import 'datatypes/datetime/timetz.dart';
import 'datatypes/string/character_varying_array.dart';
import 'datatypes/string/uuid.dart';
import 'datatypes/string/text.dart';
import 'datatypes/string/text_array.dart';
import 'datatypes/string/uuid_array.dart';

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
  await performSmallIntTest(supabase);
  await performSmallIntArrayTest(supabase);

  await performIntegerTest(supabase);
  await performIntegerArrayTest(supabase);

  await performBigIntTest(supabase);
  await performBigIntArrayTest(supabase);

  await performRealTest(supabase);
  await performRealArrayTest(supabase);

  await performDoublePrecisionTest(supabase);
  await performDoublePrecisionArrayTest(supabase);

  await performNumericTest(supabase);
  await performNumericArrayTest(supabase);

  // JSON Types
  await performJsonTest(supabase);
  // todo: performJsonArrayTest(supabase);

  await performJsonbTest(supabase);
  // todo: performJsonbArrayTest(supabase);

  // String Types
  await performTextTest(supabase);
  await performTextArrayTest(supabase);

  await performCharacterVaryingTest(supabase);
  await performCharacterVaryingArrayTest(supabase);

  await performUUIDTest(supabase);
  await performUUIDArrayTest(supabase);

  // Date Time Types
  await performDateTest(supabase);
  await performDateArrayTest(supabase);

  await performTimeTest(supabase);
  await performTimeArrayTest(supabase);

  await performTimeTzTest(supabase);
  await performTimeTzArrayTest(supabase);

  await performTimestampTest(supabase);
  await performTimestampArrayTest(supabase);

  await performTimestamptzTest(supabase);
  await performTimestamptzArrayTest(supabase);

  // Boolean Bit Types
  await performBooleanTest(supabase);
  await performBooleanArrayTest(supabase);

  // // ========================================
  // // Not STES - see on repositoryroot/other-types.md

  // // String Types
  await performCharacterTest(supabase);
  await performCharacterArrayTest(supabase);

  // Boolean Bit Types

  // Geometry Types

  // Network Address Types

  // Binary Data and XML Types

  // Misc Types
}
