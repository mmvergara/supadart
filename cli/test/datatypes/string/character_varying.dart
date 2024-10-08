import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performCharacterVaryingTest(SupabaseClient supabase) async {
  // Test values for character varying
  String insertCharVar = "It's 11pm, Goodnight!";
  String updatedCharVar = "No, im not sleeping yet!, im finishing this test!";

  // Tests for character varying
  test('Testing Character Varying Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createCharVar(supabase, insertCharVar);
    expect(createResult, null);
  });

  test('Testing Character Varying Update', () async {
    var updateResult =
        await updateCharVar(supabase, insertCharVar, updatedCharVar);
    expect(updateResult, null);
  });

  test('Testing Character Varying Read', () async {
    var readResult = await readCharVar(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colCharactervarying, isA<String>());
    expect(readResult[0].colCharactervarying, updatedCharVar);
  });

  test(
      "Testing Character Varying serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readCharVar(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);
    expect(fromJson.colCharactervarying, originalObject.colCharactervarying);

    // Test full roundtrip and object equivalence
    var roundTripJson = fromJson.toJson();
    expect(roundTripJson, originalObject.toJson());
  });
}

Future<Object?> createCharVar(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colCharactervarying: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharVar(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(colCharactervarying: value))
        .eq(StringTypes.c_colCharactervarying, oldValue);
    return null;
  } catch (error) {
    print("updateCharVar error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readCharVar(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readCharVar error");
    print(error);
    return null;
  }
}
