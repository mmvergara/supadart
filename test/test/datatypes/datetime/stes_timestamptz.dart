import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
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
    assert(readResult is List<Datetime_types>);
    expect(readResult!.length, 1);

    var storedTimestamp = readResult[0].col_timestamptz;
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
}

Future<Object?> createTimestamptz(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(Datetime_types.insert(
      id: uuidx,
      col_timestamptz: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Datetime_types>?> readTimestamptz(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter((data) => data.map(Datetime_types.fromJson).toList());
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
        .update(Datetime_types.update(col_timestamptz: value))
        .eq(Datetime_types.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimestamptz error");
    print(error);
    return error;
  }
}
