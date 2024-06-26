import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
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
    assert(readResult is List<String_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_charactervarying, isA<String>());
    expect(readResult[0].col_charactervarying, updatedCharVar);
  });
}

Future<Object?> createCharVar(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(String_types.insert(
      col_charactervarying: insertVal,
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
        .update(String_types.update(col_charactervarying: value))
        .eq(String_types.c_col_charactervarying, oldValue);
    return null;
  } catch (error) {
    print("updateCharVar error");
    print(error);
    return error;
  }
}

Future<List<String_types>?> readCharVar(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter((data) => data.map(String_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readCharVar error");
    print(error);
    return null;
  }
}