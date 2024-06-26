import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
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
    expect(readResult[0].col_character, isA<String>());
    expect(readResult[0].col_character, updatedCharacter);
  });
}

Future<Object?> createCharacter(
    SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      col_character: insertVal,
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
        .update(StringTypes.update(col_character: value))
        .eq(StringTypes.c_col_character, oldValue);
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
        .withConverter((data) => data.map(StringTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readCharacter error");
    print(error);
    return null;
  }
}
