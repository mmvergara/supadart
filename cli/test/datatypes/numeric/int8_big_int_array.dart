import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performBigIntArrayTest(SupabaseClient supabase) async {
  // int8[]
  List<BigInt> insertBigIntArray = [
    BigInt.parse("9223372036854775807"), // max value for int8
    BigInt.zero,
    BigInt.parse("-9223372036854775808"), // min value for int8
  ];
  List<BigInt> updatedBigIntArray = [
    BigInt.parse("-9223372036854775808"), // min value for int8
    BigInt.zero,
    BigInt.parse("9223372036854775807"), // max value for int8
  ];

  test('Testing BigInt Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createBigIntArray(supabase, insertBigIntArray);
    expect(createResult, null);
  });

  test('Testing BigInt Array Update', () async {
    var updateResult = await updateBigIntArray(
        supabase, insertBigIntArray, updatedBigIntArray);
    expect(updateResult, null);
  });

  test('Testing BigInt Array Read', () async {
    var readResult = await readBigIntArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_bigint_array, updatedBigIntArray);
    expect(readResult[0].col_bigint_array, isA<List<BigInt>>());
  });
}

Future<Object?> createBigIntArray(
    SupabaseClient supabase, List<BigInt> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_bigint_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<NumericTypes>?> readBigIntArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
    return res;
  } catch (error) {
    print("readBigIntArray error");
    print(error);
    return null;
  }
}

Future<Object?> updateBigIntArray(
    SupabaseClient supabase, List<BigInt> oldValue, List<BigInt> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_bigint_array: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateBigIntArray error");
    print(error);
    return error;
  }
}
