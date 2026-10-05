import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/test.dart';

import '../../utils.dart';

// https://dart.dev/guides/language/numbers
// For other cases where precision matters, consider other numeric types. The BigInt type provides arbitrary-precision integers on both native and web. The fixnum package provides strict 64-bit signed numbers, even on the web. Use these types with care, though: they often result in significantly bigger and slower code.

Future<void> performNumericTest(SupabaseClient supabase) async {
  num insertNumeric = double.maxFinite;
  num updatedNumeric = -double.maxFinite;

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
    expect(readResult[0].colNumeric, isA<num>());
    expect(readResult[0].colNumeric, updatedNumeric);
  });

  test("Testing Numeric serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readNumeric(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);
    expect(fromJson.colNumeric, originalObject.colNumeric);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = NumericTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colNumeric, originalObject.colNumeric);
  });
}

Future<Object?> createNumeric(SupabaseClient supabase, num insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colNumeric: insertVal,
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
        .update(NumericTypes.update(colNumeric: value))
        .eq(NumericTypes.c_colNumeric, oldValue);
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
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readNumeric error");
    print(error);
    return null;
  }
}
