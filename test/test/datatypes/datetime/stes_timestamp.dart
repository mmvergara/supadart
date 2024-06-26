import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
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
    expect(readResult[0].col_timestamp?.year, updatedTimestamp.year);
    expect(readResult[0].col_timestamp?.month, updatedTimestamp.month);
    expect(readResult[0].col_timestamp?.day, updatedTimestamp.day);
    expect(readResult[0].col_timestamp?.hour, updatedTimestamp.hour);
    expect(readResult[0].col_timestamp?.minute, updatedTimestamp.minute);
    expect(readResult[0].col_timestamp?.second, updatedTimestamp.second);
    expect(
        readResult[0].col_timestamp?.millisecond, updatedTimestamp.millisecond);
    expect(readResult[0].col_timestamp, isA<DateTime>());
  });
}

Future<Object?> createTimestamp(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      col_timestamp: insertVal,
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
        .withConverter((data) => data.map(DatetimeTypes.fromJson).toList());
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
        .update(DatetimeTypes.update(col_timestamp: value))
        .eq(DatetimeTypes.c_col_timestamp, oldValue);
    return null;
  } catch (error) {
    print("updateTimestamp error");
    print(error);
    return error;
  }
}
