import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performBigIntTest(SupabaseClient supabase) async {
  // int8
  BigInt insertBigInt =
      BigInt.parse("9223372036854775807"); // max value for int8
  BigInt updatedBigInt =
      BigInt.parse("-9223372036854775808"); // min value for int8

  test('Testing BigInt Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createBigInt(supabase, insertBigInt);
    expect(createResult, null);
  });

  test('Testing BigInt Update', () async {
    var updateResult =
        await updateBigInt(supabase, insertBigInt, updatedBigInt);
    expect(updateResult, null);
  });

  test('Testing BigInt Read', () async {
    var readResult = await readBigInt(supabase);
    assert(readResult is List<Numeric_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_bigint, updatedBigInt);
    expect(readResult[0].col_bigint, isA<BigInt>());
  });
}

Future<Object?> createBigInt(SupabaseClient supabase, BigInt insertVal) async {
  try {
    await supabase.numeric_types.insert(Numeric_types.insert(
      col_bigint: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Numeric_types>?> readBigInt(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(Numeric_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readBigInt error");
    print(error);
    return null;
  }
}

Future<Object?> updateBigInt(
    SupabaseClient supabase, BigInt oldValue, BigInt value) async {
  try {
    await supabase.numeric_types
        .update(Numeric_types.update(col_bigint: value))
        .eq(Numeric_types.c_col_bigint, oldValue);
    return null;
  } catch (error) {
    print("updateBigInt error");
    print(error);
    return error;
  }
}
