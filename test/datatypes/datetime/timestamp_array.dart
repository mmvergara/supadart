import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

// Array Test for Timestamps
Future<void> performTimestampArrayTest(SupabaseClient supabase) async {
  // List of DateTimes
  List<DateTime> insertTimestamps = [
    DateTime(2021, 10, 10, 10, 10, 10),
    DateTime.now().toUtc(),
  ];

  List<DateTime> updatedTimestamps = [
    DateTime.now(),
    DateTime(2023, 12, 12, 12, 12, 12),
  ];

  // Tests for Timestamp array
  test('Testing Timestamp Array Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimestampArr(supabase, insertTimestamps);
    expect(createResult, null);
  });

  test('Testing Timestamp Array Update', () async {
    var updateResult =
        await updateTimestampArr(supabase, insertTimestamps, updatedTimestamps);
    expect(updateResult, null);
  });

  test('Testing Timestamp Array Read', () async {
    var readResult = await readTimestampArr(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);

    for (int i = 0; i < insertTimestamps.length; i++) {
      expect(
          readResult[0].colTimestampArray![i].year, updatedTimestamps[i].year);
      expect(readResult[0].colTimestampArray![i].month,
          updatedTimestamps[i].month);
      expect(readResult[0].colTimestampArray![i].day, updatedTimestamps[i].day);
      expect(
          readResult[0].colTimestampArray![i].hour, updatedTimestamps[i].hour);
      expect(readResult[0].colTimestampArray![i].minute,
          updatedTimestamps[i].minute);
      expect(readResult[0].colTimestampArray![i].second,
          updatedTimestamps[i].second);
      expect(readResult[0].colTimestampArray![i].millisecond,
          updatedTimestamps[i].millisecond);
    }

    expect(readResult[0].colTimestampArray, isA<List<DateTime>>());
  });

  test(
      "Testing Timestamp Array serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTimestampArr(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colTimestampArray, originalObject.colTimestampArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(
        roundTripFromJson.colTimestampArray, originalObject.colTimestampArray);
  });
}

Future<Object?> createTimestampArr(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      id: uuidx,
      colTimestampArray: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimestampArr(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTimestampArr error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimestampArr(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    // Assuming the ID field for update is `colTimestamp` (modify if different)
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimestampArray: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimestampArr error");
    print(error);
    return error;
  }
}
