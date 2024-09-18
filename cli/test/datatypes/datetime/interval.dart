import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performIntervalTest(SupabaseClient supabase) async {
  Duration insertInterval = Duration(days: 1, hours: 1, minutes: 1, seconds: 1);
  Duration updatedInterval =
      Duration(days: 2, hours: 2, minutes: 2, seconds: 2);

  await cleanup(supabase, supabase.datetime_types);

  test('Testing Interval Create', () async {
    var createResult = await createInterval(supabase, insertInterval);
    expect(createResult, null);
  });

  test('Testing Interval Update', () async {
    var updateResult =
        await updateInterval(supabase, insertInterval, updatedInterval);
    expect(updateResult, null);
  });

  test('Testing Interval Read', () async {
    var readResult = await readInterval(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colInterval, updatedInterval);
    expect(readResult[0].colInterval, isA<Duration>());
  });

  test("Testing Interval serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readInterval(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colInterval, originalObject.colInterval);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colInterval, originalObject.colInterval);
  });

  
}

Future<Object?> createInterval(
    SupabaseClient supabase, Duration insertVal) async {
  try {
    await supabase.datetime_types
        .insert(DatetimeTypes.insert(colInterval: insertVal, id: uuidx));
    return null;
  } catch (error) {
    print("createInterval error");
    print(error);
    return error;
  }
}

Future<Object?> updateInterval(
    SupabaseClient supabase, Duration insertVal, Duration updatedVal) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colInterval: updatedVal))
        .eq("col_interval", insertVal);
    return null;
  } catch (error) {
    print("updateInterval error");
    print(error);
    return error;
  }
}

Future<List<DatetimeTypes>?> readInterval(SupabaseClient supabase) async {
  try {
    var result = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return result;
  } catch (error) {
    print("readInterval error");
    print(error);
    return null;
  }
}
