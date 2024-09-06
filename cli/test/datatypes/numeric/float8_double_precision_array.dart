import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    expect(readResult[0].colDoubleArray, isA<List<double>>());
    expect(readResult[0].colDoubleArray, updatedDoublePrecisionArray);
  });

  test("Testing Double Precision Array toJson and fromJson", () async {
    var readResult = await readDoublePrecisionArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = NumericTypes.fromJson(toJson);

    expect(fromJson.colDoubleArray, originalObject.colDoubleArray);
  });
}

Future<Object?> createDoublePrecisionArray(
    SupabaseClient supabase, List<double> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colDoubleArray: insertVal,
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
        .update(NumericTypes.update(colDoubleArray: value))
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
        .withConverter(NumericTypes.converter);
  } catch (error) {
    print("readDoublePrecisionArray error");
    print(error);
    return null;
  }
}
