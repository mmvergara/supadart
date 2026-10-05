import 'package:supabase/supabase.dart';

// import 'datatypes/numeric/big_serial.dart';
// import 'datatypes/numeric/big_serial_array.dart';
import 'datatypes/numeric/int2_small_int.dart';
import 'datatypes/numeric/int2_small_int_array.dart';
import 'datatypes/numeric/int4_int.dart';
import 'datatypes/numeric/int4_int_array.dart';
import 'datatypes/numeric/int8_big_int.dart';
import 'datatypes/numeric/int8_big_int_array.dart';
import 'datatypes/numeric/float4_real.dart';
import 'datatypes/numeric/float4_real_array.dart';
import 'datatypes/numeric/float8_double_precision.dart';
import 'datatypes/numeric/float8_double_precision_array.dart';
import 'datatypes/numeric/numeric.dart';
import 'datatypes/numeric/numeric_array.dart';

Future<void> performNumericTypesTest(SupabaseClient supabase) async {
  // Numeric Types
  // STES = Supabase Table Editor Supported (PRIORITIZED)
  await performSmallIntTest(supabase);
  await performSmallIntArrayTest(supabase);

  await performIntegerTest(supabase);
  await performIntegerArrayTest(supabase);

  await performBigIntTest(supabase);
  await performBigIntArrayTest(supabase);

  // await performBigSerialTests(supabase);
  // await performBigSerialArrayTests(supabase);

  await performRealTest(supabase);
  await performRealArrayTest(supabase);

  await performDoublePrecisionTest(supabase);
  await performDoublePrecisionArrayTest(supabase);

  await performNumericTest(supabase);
  await performNumericArrayTest(supabase);

  // Other Numeric Types
}
