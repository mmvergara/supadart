import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performCharacterVaryingArrayTest(SupabaseClient supabase) async {
  // Test values for character varying array
  List<String> insertCharVarArray = [
    "It's 11pm Goodnight!",
    "One more episode...",
    "Just five more minutes..."
  ];
  List<String> updatedCharVarArray = [
    "No I'm not sleeping yet!",
    "I'm finishing this test!",
    "Okay now it's really time for bed."
  ];

  // Tests for character varying array
  test('Testing Character Varying Array Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createCharVarArray(supabase, insertCharVarArray);
    expect(createResult, null);
  });

  test('Testing Character Varying Array Update', () async {
    var updateResult = await updateCharVarArray(
        supabase, insertCharVarArray, updatedCharVarArray);
    expect(updateResult, null);
  });

  test('Testing Character Varying Array Read', () async {
    var readResult = await readCharVarArray(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colCharactervaryingArray, isA<List<String>>());
    expect(readResult[0].colCharactervaryingArray![0], updatedCharVarArray[0]);
    expect(readResult[0].colCharactervaryingArray![1], updatedCharVarArray[1]);
    expect(readResult[0].colCharactervaryingArray![2], updatedCharVarArray[2]);
  });

  test(
      "Testing Character Varying Array serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readCharVarArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);
    expect(fromJson.colCharactervaryingArray,
        originalObject.colCharactervaryingArray);

    // Test full roundtrip and object equivalence
    var roundTripJson = fromJson.toJson();
    expect(roundTripJson, originalObject.toJson());
  });
}

Future<Object?> createCharVarArray(
    SupabaseClient supabase, List<String> insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colCharactervaryingArray: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharVarArray(
    SupabaseClient supabase, List<String> oldValue, List<String> value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(colCharactervaryingArray: value))
        .eq(StringTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateCharVarArray error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readCharVarArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readCharVarArray error");
    print(error);
    return null;
  }
}
