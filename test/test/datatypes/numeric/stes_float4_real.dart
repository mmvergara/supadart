import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performRealTest(SupabaseClient supabase) async {
  // real = single precision floating point number
  double insertReal = 1.0E+10;
  double updatedReal = -1.0E+10;

  // Tests for real
  test('Testing Real Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createReal(supabase, insertReal);
    expect(createResult, null);
  });

  test('Testing Real Update', () async {
    var updateResult = await updateReal(supabase, insertReal, updatedReal);
    expect(updateResult, null);
  });

  test('Testing Real Read', () async {
    var readResult = await readReal(supabase);
    assert(readResult is List<Numeric_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_real, isA<double>());
    expect(readResult[0].col_real, closeTo(updatedReal, 1e-6));
  });
}

Future<Object?> createReal(SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.numeric_types.insert(Numeric_types.insert(
      col_real: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateReal(
    SupabaseClient supabase, double oldValue, double value) async {
  try {
    await supabase.numeric_types
        .update(Numeric_types.update(col_real: value))
        .eq(Numeric_types.c_col_real, oldValue);
    return null;
  } catch (error) {
    print("updateReal error");
    print(error);
    return error;
  }
}

Future<List<Numeric_types>?> readReal(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(Numeric_types.fromJson).toList());
  } catch (error) {
    print("readReal error");
    print(error);
    return null;
  }
}
