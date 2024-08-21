import 'package:supabase/supabase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../models/generated_classes.dart';
import '../../utils.dart'; // Assuming this contains your cleanup function

Future<void> performSmallIntTest(SupabaseClient supabase) async {
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
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1); // Assuming only one row is inserted
    expect(readResult[0].colSmallint, updatedSmallint);
  });
}

Future<Object?> createSmallint(SupabaseClient supabase, int insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colSmallint: insertVal,
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
        .update(NumericTypes.update(colSmallint: value))
        .eq(NumericTypes.c_colSmallint, oldValue);
    return null;
  } catch (error) {
    print("updateSmallint error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readSmallint(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
    return res;
  } catch (error) {
    print("readSmallint error");
    print(error);
    return null;
  }
}
