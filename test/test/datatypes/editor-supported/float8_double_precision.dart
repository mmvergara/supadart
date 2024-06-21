import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performDoublePrecisionTest(SupabaseClient supabase) async {
  // double precision floating point number
  double insertDoublePrecision = double.infinity;
  double updatedDoublePrecision = -double.infinity;

  // Tests for double precision
  test('Testing Double Precision Create', () async {
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].doublex, isA<double>());
    expect(readResult[0].doublex, updatedDoublePrecision);
  });
}

Future<Object?> createDoublePrecision(
    SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      doublex: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateDoublePrecision(
    SupabaseClient supabase, double oldValue, double value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(doublex: value))
        .eq(Test_table.c_doublex, oldValue);
    return null;
  } catch (error) {
    print("updateDoublePrecision error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readDoublePrecision(SupabaseClient supabase) async {
  try {
    return await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
  } catch (error) {
    print("readDoublePrecision error");
    print(error);
    return null;
  }
}

