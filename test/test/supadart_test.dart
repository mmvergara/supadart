import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/editor-supported/date.dart';
import 'datatypes/editor-supported/int8_big_int.dart';

import 'datatypes/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';
import 'datatypes/bytea.dart';
import 'datatypes/character.dart';
import 'datatypes/character_varying.dart';
import 'datatypes/editor-supported/bool.dart';
import 'datatypes/editor-supported/int4_int.dart';
import 'datatypes/editor-supported/float4_real.dart';
import 'datatypes/editor-supported/int2_small_int.dart';
import 'datatypes/editor-supported/float8_double_precision.dart';
import 'datatypes/editor-supported/json.dart';
import 'datatypes/editor-supported/jsonb.dart';
import 'datatypes/editor-supported/numeric.dart';
import 'datatypes/editor-supported/time.dart';
import 'datatypes/editor-supported/timestamp.dart';
import 'datatypes/editor-supported/timestamptz.dart';
import 'datatypes/editor-supported/timetz.dart';
import 'datatypes/editor-supported/uuid.dart';
import 'datatypes/text.dart';
import 'utils.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }
  await changeSupabaseFlutterImportToSupabaseImport();
  final supabase = SupabaseClient(url, anonKey);
  await performSmallintTest(supabase);
  await performIntegerTest(supabase);
  await performBigIntTest(supabase);
  await performRealTest(supabase);
  await performDoublePrecisionTest(supabase);
  await performNumericTest(supabase);
  await performJsonTest(supabase);
  await performJsonbTest(supabase);
  await performTextTest(supabase);
  await performCharacterVaryingTest(supabase);
  await performUuidTest(supabase);
  await performDateTest(supabase);
  await performTimeTest(supabase);
  await performTimeTzTest(supabase);
  await performTimestampTest(supabase);
  await performTimestamptzTest(supabase);
  await performBooleanTest(supabase);

  await performCharacterTest(supabase);
  await performBigSerialTests(supabase);
  await performBitTest(supabase);

  // todo

  // Bit Varying = no "isA" test
  // await performBitVaryingTest(supabase);

  // Box = no "isA" test
  // await performBoxTest(supabase);

  // Not Supported Yet
  // await performByteaTest(supabase);
}
