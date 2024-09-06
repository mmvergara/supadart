import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performBigSerialTests(SupabaseClient supabase) async {
  BigInt insertBigSerial = BigInt.from(4221312931259329921);
  BigInt updatedBigSerial = BigInt.from(4221312931259329821);
  test('Testing BigSerial Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createBigSerial(supabase, insertBigSerial);
    expect(createResult, null);
  });

  test('Testing BigSerial Update', () async {
    var updateResult =
        await updateBigSerial(supabase, insertBigSerial, updatedBigSerial);
    expect(updateResult, null);
  });

  test('Testing BigSerial Read', () async {
    var readResult = await readBigSerial(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colBigserial, isA<BigInt>());
    expect(readResult[0].colBigserial, updatedBigSerial);
  });

  test("Testing BigSerial toJson and fromJson", () async {
    var readResult = await readBigSerial(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);

    expect(fromJson.colBigserial, originalObject.colBigserial);
  });
}

Future<Object?> createBigSerial(
    SupabaseClient supabase, BigInt insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colBigserial: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<NumericTypes>?> readBigSerial(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
    return res;
  } catch (error) {
    print("readBigSerial error");
    print(error);
    return null;
  }
}

Future<Object?> updateBigSerial(
    SupabaseClient supabase, BigInt oldValue, BigInt value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(colBigserial: value))
        .eq(NumericTypes.c_colBigserial, oldValue);
    return null;
  } catch (error) {
    print("updateBigSerial error");
    print(error);
    return error;
  }
}
