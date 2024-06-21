import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performCharacterTest(SupabaseClient supabase) async {
  // Test values for character
  String insertCharacter = "a";
  String updatedCharacter = "b";

  // Tests for character
  test('Testing Character Create', () async {
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].characterx, isA<String>());
    expect(readResult[0].characterx, updatedCharacter);
  });
}

Future<Object?> createCharacter(
    SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      characterx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharacter(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(characterx: value))
        .eq(Test_table.c_characterx, oldValue);
    return null;
  } catch (error) {
    print("updateCharacter error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readCharacter(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readCharacter error");
    print(error);
    return null;
  }
}
