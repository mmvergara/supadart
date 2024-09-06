import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performBigSerialArrayTests(SupabaseClient supabase) async {
  List<BigInt> insertBigSerialArray = [
    BigInt.from(4221312931259329921),
    BigInt.from(4221312931259329922),
    BigInt.from(4221312931259329923)
  ];
  List<BigInt> updatedBigSerialArray = [
    BigInt.from(4221312931259329924),
    BigInt.from(4221312931259329925),
    BigInt.from(4221312931259329926)
  ];

  test('Testing BigSerial Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult =
        await createBigSerialArray(supabase, insertBigSerialArray);
    expect(createResult, null);
  });

  test('Testing BigSerial Array Update', () async {
    var updateResult = await updateBigSerialArray(
        supabase, insertBigSerialArray, updatedBigSerialArray);
    expect(updateResult, null);
  });

  test('Testing BigSerial Array Read', () async {
    var readResult = await readBigSerialArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colBigserialArray, isA<List<BigInt>>());
    expect(
        readResult[0].colBigserialArray!.length, updatedBigSerialArray.length);
    expect(readResult[0].colBigserialArray, updatedBigSerialArray);
  });

  test(
      "Testing BigSerial Array serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readBigSerialArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);
    expect(fromJson.colBigserialArray, originalObject.colBigserialArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = NumericTypes.fromJson(roundTripToJson);
    expect(
        roundTripFromJson.colBigserialArray, originalObject.colBigserialArray);
  });
}

Future<Object?> createBigSerialArray(
    SupabaseClient supabase, List<BigInt> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colBigserialArray: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBigSerialArray(
    SupabaseClient supabase, List<BigInt> oldValue, List<BigInt> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(colBigserialArray: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateBigSerialArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readBigSerialArray(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readBigSerialArray error");
    print(error);
    return null;
  }
}
