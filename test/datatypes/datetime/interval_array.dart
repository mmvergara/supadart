import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performIntervalArrayTest(SupabaseClient supabase) async {
  // json
  List<Duration> insertInterval = [
    Duration(days: 1, hours: 1, minutes: 1, seconds: 1)
  ];

  List<Duration> updatedInterval = [
    Duration(days: 2, hours: 2, minutes: 2, seconds: 2)
  ];

  test('Testing Interval Array Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createIntervalArray(supabase, insertInterval);
    expect(createResult, null);
  });

  test('Testing Interval Array Update', () async {
    var updateResult =
        await updateIntervalArray(supabase, insertInterval, updatedInterval);
    expect(updateResult, null);
  });

  test('Testing Interval Array Read', () async {
    var readResult = await readIntervalArray(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colIntervalArray, isA<List<Duration>>());
    for (int i = 0; i < insertInterval.length; i++) {
      expect(readResult[0].colIntervalArray![i], updatedInterval[i]);
    }
  });

  test(
      "Testing Interval Array serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readIntervalArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colIntervalArray, originalObject.colIntervalArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colIntervalArray, originalObject.colIntervalArray);
  });
}

Future<Object?> createIntervalArray(
    SupabaseClient supabase, List<Duration> insertVal) async {
  try {
    await supabase.datetime_types
        .insert(DatetimeTypes.insert(colIntervalArray: insertVal, id: uuidx));
    return null;
  } catch (e) {
    print("createIntervalArray error");
    print(e);
    return e;
  }
}

Future<Object?> updateIntervalArray(SupabaseClient supabase,
    List<Duration> insertVal, List<Duration> updateVal) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colIntervalArray: updateVal))
        .eq('id', uuidx);
    return null;
  } catch (e) {
    print("updateIntervalArray error");
    print(e);
    return e;
  }
}

Future<List<DatetimeTypes>?> readIntervalArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (e) {
    print("readIntervalArray error");
    print(e);
    return null;
  }
}
