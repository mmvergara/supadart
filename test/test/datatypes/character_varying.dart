import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performCharacterVaryingTest(SupabaseClient supabase) async {
  // Test values for character varying
  String insertCharVar = "It's 11pm, Goodnight!";
  String updatedCharVar = "No, im not sleeping yet!, im finishing this test!";

  // Tests for character varying
  test('Testing Character Varying Create', () async {
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].charactervaryingx, isA<String>());
    expect(readResult[0].charactervaryingx, updatedCharVar);
  });
}

Future<Object?> createCharVar(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      charactervaryingx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateCharVar(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(charactervaryingx: value))
        .eq(Test_table.c_charactervaryingx, oldValue);
    return null;
  } catch (error) {
    print("updateCharVar error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readCharVar(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readCharVar error");
    print(error);
    return null;
  }
}
