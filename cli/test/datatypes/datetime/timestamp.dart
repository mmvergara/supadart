import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimestampTest(SupabaseClient supabase) async {
  // json
  DateTime insertTimestamp = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTimestamp = DateTime.now();

  test('Testing Timestamp Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimestamp(supabase, insertTimestamp);
    expect(createResult, null);
  });

  test('Testing Timestamp Update', () async {
    var updateResult =
        await updateTimestamp(supabase, insertTimestamp, updatedTimestamp);
    expect(updateResult, null);
  });

  test('Testing Timestamp Read', () async {
    var readResult = await readTimestamp(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colTimestamp?.year, updatedTimestamp.year);
    expect(readResult[0].colTimestamp?.month, updatedTimestamp.month);
    expect(readResult[0].colTimestamp?.day, updatedTimestamp.day);
    expect(readResult[0].colTimestamp?.hour, updatedTimestamp.hour);
    expect(readResult[0].colTimestamp?.minute, updatedTimestamp.minute);
    expect(readResult[0].colTimestamp?.second, updatedTimestamp.second);
    expect(
        readResult[0].colTimestamp?.millisecond, updatedTimestamp.millisecond);
    expect(readResult[0].colTimestamp, isA<DateTime>());
  });

  test("Testing Timestamp serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTimestamp(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colTimestamp, originalObject.colTimestamp);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colTimestamp, originalObject.colTimestamp);
  });
}

Future<Object?> createTimestamp(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      id: uuidx,
      colTimestamp: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimestamp(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTimestamp error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimestamp(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimestamp: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimestamp error");
    print(error);
    return error;
  }
}
