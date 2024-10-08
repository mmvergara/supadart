import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colReal, isA<double>());
    expect(readResult[0].colReal, closeTo(updatedReal, 1e-6));
  });

  test("Testing Real serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readReal(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);
    expect(fromJson.colReal, originalObject.colReal);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = NumericTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colReal, originalObject.colReal);
  });
}

Future<Object?> createReal(SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colReal: insertVal,
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
        .update(NumericTypes.update(colReal: value))
        .eq(NumericTypes.c_colReal, oldValue);
    return null;
  } catch (error) {
    print("updateReal error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readReal(SupabaseClient supabase) async {
  try {
    return await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readReal error");
    print(error);
    return null;
  }
}
