import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performRealTest(SupabaseClient supabase) async {
  // real = single precision floating point number

  double insertReal = 1.0E+10;
  double updatedReal = -1.0E+10;

  // Tests for real
  test('Testing Real Create', () async {
    await cleanup(supabase);
    var createResult = await createReal(supabase, insertReal);
    expect(createResult, null);
  });

  test('Testing Real Update', () async {
    var updateResult = await updateReal(supabase, insertReal, updatedReal);
    expect(updateResult, null);
  });

  test('Testing Real Read', () async {
    var readResult = await readReal(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].realx, isA<double>());
    expect(readResult[0].realx, closeTo(updatedReal, 1e-6));
  });
}

Future<Object?> createReal(SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      realx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateReal(
    SupabaseClient supabase, double oldValue, double value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(realx: value))
        .eq(Test_table.c_realx, oldValue);
    return null;
  } catch (error) {
    print("updateReal error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readReal(SupabaseClient supabase) async {
  try {
    return await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
  } catch (error) {
    print("readReal error");
    print(error);
    return null;
  }
}
