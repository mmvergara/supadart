import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performSmallIntArrayTest(SupabaseClient supabase) async {
  // int2[]
  List<int> insertSmallintArray = [
    32767,
    0,
    -32768
  ]; // max, 0, and min values for smallint
  List<int> updatedSmallintArray = [-32768, 0, 32767]; // reversed order

  test('Testing Smallint Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createSmallintArray(supabase, insertSmallintArray);
    expect(createResult, null);
  });

  test('Testing Smallint Array Update', () async {
    var updateResult = await updateSmallintArray(
        supabase, insertSmallintArray, updatedSmallintArray);
    expect(updateResult, null);
  });

  test('Testing Smallint Array Read', () async {
    var readResult = await readSmallintArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_smallint_array, updatedSmallintArray);
  });
}

Future<Object?> createSmallintArray(
    SupabaseClient supabase, List<int> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_smallint_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateSmallintArray(
    SupabaseClient supabase, List<int> oldValue, List<int> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_smallint_array: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateSmallintArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readSmallintArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
    return res;
  } catch (error) {
    print("readSmallintArray error");
    print(error);
    return null;
  }
}
