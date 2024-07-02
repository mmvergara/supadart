import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performCharacterArrayTest(SupabaseClient supabase) async {
  // Test values for character array
  List<String> insertCharacters = ["a"];
  List<String> updatedCharacters = ["b", "c"];

  // Tests for character array
  test('Testing Character Array Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createCharacterArr(supabase, insertCharacters);
    expect(createResult, null);
  });

  test('Testing Character Array Update', () async {
    var updateResult =
        await updateCharacterArr(supabase, insertCharacters, updatedCharacters);
    expect(updateResult, null);
  });

  test('Testing Character Array Read', () async {
    var readResult = await readCharacterArr(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_character_array, isA<List<String>>());
    expect(readResult[0].col_character_array, updatedCharacters);
  });
}

Future<Object?> createCharacterArr(
    SupabaseClient supabase, List<String> insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      id: uuidx,
      col_character_array: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharacterArr(
    SupabaseClient supabase, List<String> oldValue, List<String> value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(col_character_array: value))
        .eq(StringTypes.c_id, uuidx); // Assuming ID on col_character
    return null;
  } catch (error) {
    print("updateCharacterArr error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readCharacterArr(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter((data) => data.map(StringTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readCharacterArr error");
    print(error);
    return null;
  }
}
