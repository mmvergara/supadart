import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performRealArrayTest(SupabaseClient supabase) async {
  // real[] = array of single precision floating point numbers
  List<double> insertRealArray = [1.0E+10, 0.0, -1.0E+10];
  List<double> updatedRealArray = [-1.0E+10, 0.0, 1.0E+10];

  test('Testing Real Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createRealArray(supabase, insertRealArray);
    expect(createResult, null);
  });

  test('Testing Real Array Update', () async {
    var updateResult =
        await updateRealArray(supabase, insertRealArray, updatedRealArray);
    expect(updateResult, null);
  });

  test('Testing Real Array Read', () async {
    var readResult = await readRealArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_real_array, isA<List<double>>());
    expect(readResult[0].col_real_array!.length, updatedRealArray.length);
    expect(readResult[0].col_real_array, updatedRealArray);
  });
}

Future<Object?> createRealArray(
    SupabaseClient supabase, List<double> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_real_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateRealArray(
    SupabaseClient supabase, List<double> oldValue, List<double> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_real_array: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateRealArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readRealArray(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(NumericTypes.fromJson).toList());
  } catch (error) {
    print("readRealArray error");
    print(error);
    return null;
  }
}
