import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart'; // Assuming this contains your cleanup function

Future<void> performSmallintTest(SupabaseClient supabase) async {
  // int2
  int insertSmallint = 32767; // max value for smallint
  int updatedSmallint = -32768; // min value for smallint

  // Tests for smallint
  test('Testing Smallint Create', () async {
    await cleanup(
        supabase,
        supabase
            .numeric_types); // Assuming cleanup function clears existing data
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
    assert(readResult is List<Numeric_types>);
    expect(readResult!.length, 1); // Assuming only one row is inserted
    expect(readResult[0].col_smallint, updatedSmallint);
  });
}

Future<Object?> createSmallint(SupabaseClient supabase, int insertVal) async {
  try {
    await supabase.numeric_types.insert(Numeric_types.insert(
      col_smallint: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateSmallint(
    SupabaseClient supabase, int oldValue, int value) async {
  try {
    await supabase.numeric_types
        .update(Numeric_types.update(col_smallint: value))
        .eq(Numeric_types.c_col_smallint, oldValue);
    return null;
  } catch (error) {
    print("updateSmallint error");
    print(error);
    return error;
  }
}

Future<List<Numeric_types>?> readSmallint(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(Numeric_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readSmallint error");
    print(error);
    return null;
  }
}
