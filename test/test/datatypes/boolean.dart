// Functions for boolean
import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performBooleanTest(SupabaseClient supabase) async {
// Test values for boolean
  bool insertBoolean = true;
  bool updatedBoolean = false;

// Tests for boolean
  test('Testing Boolean Create', () async {
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].booleanx, updatedBoolean);
  });
}

Future<Object?> createBoolean(SupabaseClient supabase, bool insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      booleanx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBoolean(
    SupabaseClient supabase, bool oldValue, bool value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(booleanx: value))
        .eq(Test_table.c_booleanx, oldValue);
    return null;
  } catch (error) {
    print("updateBoolean error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readBoolean(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readBoolean error");
    print(error);
    return null;
  }
}
