import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performCharacterTest(SupabaseClient supabase) async {
  // Test values for character
  String insertCharacter = "a";
  String updatedCharacter = "b";

  // Tests for character
  test('Testing Character Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createCharacter(supabase, insertCharacter);
    expect(createResult, null);
  });

  test('Testing Character Update', () async {
    var updateResult =
        await updateCharacter(supabase, insertCharacter, updatedCharacter);
    expect(updateResult, null);
  });

  test('Testing Character Read', () async {
    var readResult = await readCharacter(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colCharacter, isA<String>());
    expect(readResult[0].colCharacter, updatedCharacter);
  });

  test("Testing Character toJson and fromJson", () async {
    var readResult = await readCharacter(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);

    expect(fromJson.colCharacter, originalObject.colCharacter);
  });
}

Future<Object?> createCharacter(
    SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colCharacter: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharacter(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(colCharacter: value))
        .eq(StringTypes.c_colCharacter, oldValue);
    return null;
  } catch (error) {
    print("updateCharacter error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readCharacter(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readCharacter error");
    print(error);
    return null;
  }
}
