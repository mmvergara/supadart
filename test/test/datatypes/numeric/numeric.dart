import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/test.dart';

import '../../utils.dart';

// https://dart.dev/guides/language/numbers
// For other cases where precision matters, consider other numeric types. The BigInt type provides arbitrary-precision integers on both native and web. The fixnum package provides strict 64-bit signed numbers, even on the web. Use these types with care, though: they often result in significantly bigger and slower code.

Future<void> performNumericTest(SupabaseClient supabase) async {
  num insertNumeric = double.infinity;
  num updatedNumeric = -double.infinity;

  // Tests for double precision
  test('Testing Numeric Create', () async {
    await cleanup(supabase, supabase.numeric_types);
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
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_numeric, isA<num>());
    expect(readResult[0].col_numeric, updatedNumeric);
  });
}

Future<Object?> createNumeric(SupabaseClient supabase, num insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      col_numeric: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateNumeric(
    SupabaseClient supabase, num oldValue, num value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(col_numeric: value))
        .eq(NumericTypes.c_col_numeric, oldValue);
    return null;
  } catch (error) {
    print("updateNumeric error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readNumeric(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter((data) => data.map(NumericTypes.fromJson).toList());
  } catch (error) {
    print("readNumeric error");
    print(error);
    return null;
  }
}
