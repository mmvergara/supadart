import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    expect(readResult[0].colDouble, isA<double>());
    expect(readResult[0].colDouble, updatedDoublePrecision);
  });

  test(
      "Testing Double Precision serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readDoublePrecision(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);
    expect(fromJson.colDouble, originalObject.colDouble);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = NumericTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colDouble, originalObject.colDouble);
  });
}

Future<Object?> createDoublePrecision(
    SupabaseClient supabase, double insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colDouble: insertVal,
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
        .update(NumericTypes.update(colDouble: value))
        .eq(NumericTypes.c_colDouble, oldValue);
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
