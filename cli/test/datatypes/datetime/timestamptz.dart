import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimestamptzTest(SupabaseClient supabase) async {
  DateTime insertTimestamptz = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTimestamptz = DateTime.now();

  test('Testing Timestamptz Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimestamptz(supabase, insertTimestamptz);
    expect(createResult, null);
  });

  test('Testing Timestamptz Update', () async {
    var updateResult = await updateTimestamptz(
        supabase, insertTimestamptz, updatedTimestamptz);
    expect(updateResult, null);
  });
  test('Testing Timestamptz Read', () async {
    var readResult = await readTimestamptz(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);

    var storedTimestamp = readResult[0].colTimestamptz;
    expect(storedTimestamp, isA<DateTime>());

    // Convert both timestamps to UTC for comparison
    var updatedTimestamptzUtc = updatedTimestamptz.toUtc();
    var storedTimestampUtc = storedTimestamp!.toUtc();

    // Compare the UTC timestamps
    expect(storedTimestampUtc.year, updatedTimestamptzUtc.year);
    expect(storedTimestampUtc.month, updatedTimestamptzUtc.month);
    expect(storedTimestampUtc.day, updatedTimestamptzUtc.day);
    expect(storedTimestampUtc.hour, updatedTimestamptzUtc.hour);
    expect(storedTimestampUtc.minute, updatedTimestamptzUtc.minute);
    expect(storedTimestampUtc.second, updatedTimestamptzUtc.second);
    expect(storedTimestampUtc.millisecond, updatedTimestamptzUtc.millisecond);

    // Check if both timestamps are in UTC
    expect(storedTimestampUtc.isUtc, true);
    expect(updatedTimestamptzUtc.isUtc, true);

    // Compare the full DateTime objects
    expect(storedTimestampUtc, updatedTimestamptzUtc);
  });

  test("Testing Timestamptz serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTimestamptz(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colTimestamptz, originalObject.colTimestamptz);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colTimestamptz, originalObject.colTimestamptz);
  });
}

Future<Object?> createTimestamptz(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      id: uuidx,
      colTimestamptz: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimestamptz(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTimestamptz error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimestamptz(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimestamptz: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimestamptz error");
    print(error);
    return error;
  }
}
