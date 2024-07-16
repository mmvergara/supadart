import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performDoublePrecisionTest(SupabaseClient supabase) async {
  // double precision floating point number
  double insertDoublePrecision = double.infinity;
  double updatedDoublePrecision = -double.infinity;

  // Tests for double precision
  test('Testing Double Precision Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult =
        await createDoublePrecision(supabase, insertDoublePrecision);
    expect(createResult, null);
  });

  test('Testing Double Precision Update', () async {
    var updateResult = await updateDoublePrecision(
        supabase, insertDoublePrecision, updatedDoublePrecision);
    expect(updateResult, null);
  });

  test('Testing Double Precision Read', () async {
    var readResult = await readDoublePrecision(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_double, isA<double>());
    expect(readResult[0].col_double, updatedDoublePrecision);
  });
}

Future<Object?> createDoublePrecision(
    SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_double: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateDoublePrecision(
    SupabaseClient supabase, double oldValue, double value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_double: value))
        .eq(NumericTypes.c_col_double, oldValue);
    return null;
  } catch (error) {
    print("updateDoublePrecision error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readDoublePrecision(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readDoublePrecision error");
    print(error);
    return null;
  }
}
