import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colBigint, updatedBigInt);
    expect(readResult[0].colBigint, isA<BigInt>());
  });

  test("Testing BigInt toJson and fromJson", () async {
    var readResult = await readBigInt(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);

    expect(fromJson.colBigint, originalObject.colBigint);
  });
}

Future<Object?> createBigInt(SupabaseClient supabase, BigInt insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colBigint: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<NumericTypes>?> readBigInt(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
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
        .update(NumericTypes.update(colBigint: value))
        .eq(NumericTypes.c_colBigint, oldValue);
    return null;
  } catch (error) {
    print("updateBigInt error");
    print(error);
    return error;
  }
}
