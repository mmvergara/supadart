import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/test.dart';

import '../../utils.dart';

Future<void> performNumericArrayTest(SupabaseClient supabase) async {
  List<num> insertNumericArray = [double.infinity, 0, -double.infinity];
  List<num> updatedNumericArray = [-double.infinity, 0, double.infinity];

  test('Testing Numeric Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createNumericArray(supabase, insertNumericArray);
    expect(createResult, null);
  });

  test('Testing Numeric Array Update', () async {
    var updateResult = await updateNumericArray(
        supabase, insertNumericArray, updatedNumericArray);
    expect(updateResult, null);
  });

  test('Testing Numeric Array Read', () async {
    var readResult = await readNumericArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_numeric_array, isA<List<num>>());
    expect(readResult[0].col_numeric_array, updatedNumericArray);
  });
}

Future<Object?> createNumericArray(
    SupabaseClient supabase, List<num> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_numeric_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateNumericArray(
    SupabaseClient supabase, List<num> oldValue, List<num> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_numeric_array: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateNumericArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readNumericArray(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readNumericArray error");
    print(error);
    return null;
  }
}
