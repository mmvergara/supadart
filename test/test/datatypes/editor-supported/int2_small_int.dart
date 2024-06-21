import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../cleanup.dart'; // Assuming this contains your cleanup function

Future<void> performSmallintTest(SupabaseClient supabase) async {
  // int2
  int insertSmallint = 32767; // max value for smallint
  int updatedSmallint = -32768; // min value for smallint

  // Tests for smallint
  test('Testing Smallint Create', () async {
    await cleanup(supabase); // Assuming cleanup function clears existing data
    var createResult = await createSmallint(supabase, insertSmallint);
    expect(createResult, null);
  });

  test('Testing Smallint Update', () async {
    var updateResult =
        await updateSmallint(supabase, insertSmallint, updatedSmallint);
    expect(updateResult, null);
  });

  test('Testing Smallint Read', () async {
    var readResult = await readSmallint(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1); // Assuming only one row is inserted
    expect(readResult[0].smallintx, updatedSmallint);
  });
}

Future<Object?> createSmallint(SupabaseClient supabase, int insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      smallintx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateSmallint(
    SupabaseClient supabase, int oldValue, int value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(smallintx: value))
        .eq(Test_table.c_smallintx, oldValue);
    return null;
  } catch (error) {
    print("updateSmallint error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readSmallint(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readSmallint error");
    print(error);
    return null;
  }
}
