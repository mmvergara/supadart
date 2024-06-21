import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/test.dart';

import '../../cleanup.dart';

// https://dart.dev/guides/language/numbers
// For other cases where precision matters, consider other numeric types. The BigInt type provides arbitrary-precision integers on both native and web. The fixnum package provides strict 64-bit signed numbers, even on the web. Use these types with care, though: they often result in significantly bigger and slower code.

Future<void> performNumericTest(SupabaseClient supabase) async {
  num insertNumeric = double.infinity;
  num updatedNumeric = -double.infinity;

  // Tests for double precision
  test('Testing Numeric Create', () async {
    await cleanup(supabase);
    var createResult = await createNumeric(supabase, insertNumeric);
    expect(createResult, null);
  });

  test('Testing Numeric Update', () async {
    var updateResult =
        await updateNumeric(supabase, insertNumeric, updatedNumeric);
    expect(updateResult, null);
  });

  test('Testing Numeric Read', () async {
    var readResult = await readNumeric(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].numericx, isA<num>());
    expect(readResult[0].numericx, updatedNumeric);
  });
}

Future<Object?> createNumeric(SupabaseClient supabase, num insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      numericx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateNumeric(
    SupabaseClient supabase, num oldValue, num value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(numericx: value))
        .eq(Test_table.c_numericx, oldValue);
    return null;
  } catch (error) {
    print("updateNumeric error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readNumeric(SupabaseClient supabase) async {
  try {
    return await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
  } catch (error) {
    print("readNumeric error");
    print(error);
    return null;
  }
}
