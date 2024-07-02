import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performDoublePrecisionArrayTest(SupabaseClient supabase) async {
  // double precision floating point number array
  List<double> insertDoublePrecisionArray = [
    double.infinity,
    0.0,
    -double.infinity
  ];
  List<double> updatedDoublePrecisionArray = [
    -double.infinity,
    0.0,
    double.infinity
  ];

  test('Testing Double Precision Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult =
        await createDoublePrecisionArray(supabase, insertDoublePrecisionArray);
    expect(createResult, null);
  });

  test('Testing Double Precision Array Update', () async {
    var updateResult = await updateDoublePrecisionArray(
        supabase, insertDoublePrecisionArray, updatedDoublePrecisionArray);
    expect(updateResult, null);
  });

  test('Testing Double Precision Array Read', () async {
    var readResult = await readDoublePrecisionArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_double_array, isA<List<double>>());
    expect(readResult[0].col_double_array, updatedDoublePrecisionArray);
  });
}

Future<Object?> createDoublePrecisionArray(
    SupabaseClient supabase, List<double> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_double_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateDoublePrecisionArray(
    SupabaseClient supabase, List<double> oldValue, List<double> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_double_array: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateDoublePrecisionArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readDoublePrecisionArray(
    SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(NumericTypes.fromJson).toList());
  } catch (error) {
    print("readDoublePrecisionArray error");
    print(error);
    return null;
  }
}
