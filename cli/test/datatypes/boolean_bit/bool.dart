import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performBooleanTest(SupabaseClient supabase) async {
  bool insertBoolean = true;
  bool updatedBoolean = false;

  test('Testing Boolean Create', () async {
    await cleanup(supabase, supabase.boolean_bit_types);
    var createResult = await createBoolean(supabase, insertBoolean);
    expect(createResult, null);
  });

  test('Testing Boolean Update', () async {
    var updateResult =
        await updateBoolean(supabase, insertBoolean, updatedBoolean);
    expect(updateResult, null);
  });

  test('Testing Boolean Read', () async {
    var readResult = await readBoolean(supabase);
    assert(readResult is List<BooleanBitTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colBoolean, isA<bool>());
    expect(readResult[0].colBoolean, updatedBoolean);
  });

  test(
      "Testing Boolean serialization roundtrip maintains data integrity and object equivalence",
      () async {
    var readResult = await readBoolean(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = BooleanBitTypes.fromJson(toJson);
    expect(fromJson.colBoolean, originalObject.colBoolean);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = BooleanBitTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colBoolean, originalObject.colBoolean);
  });
}

Future<Object?> createBoolean(SupabaseClient supabase, bool insertVal) async {
  try {
    await supabase.boolean_bit_types.insert(BooleanBitTypes.insert(
      colBoolean: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBoolean(
    SupabaseClient supabase, bool oldValue, bool value) async {
  try {
    await supabase.boolean_bit_types
        .update(BooleanBitTypes.update(
          colBoolean: value,
        ))
        .eq(BooleanBitTypes.c_colBoolean, oldValue);
    return null;
  } catch (error) {
    print("updateBoolean error");
    print(error);
    return error;
  }
}

Future<List<BooleanBitTypes>?> readBoolean(SupabaseClient supabase) async {
  try {
    return await supabase.boolean_bit_types
        .select()
        .withConverter(BooleanBitTypes.converter);
  } catch (error) {
    print("readBoolean error");
    print(error);
    return null;
  }
}
