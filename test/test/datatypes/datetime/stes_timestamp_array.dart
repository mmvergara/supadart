import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimestampArrayTest(SupabaseClient supabase) async {
  // json
  List<DateTime> insertTimestamp = [DateTime(2021, 10, 10, 10, 10, 10)];

  List<DateTime> updatedTimestamp = [DateTime.now()];

  test('Testing Timestamp Array Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimestampArray(supabase, insertTimestamp);
    expect(createResult, null);
  });

  test('Testing Timestamp Array Update', () async {
    var updateResult =
        await updateTimestampArray(supabase, insertTimestamp, updatedTimestamp);
    expect(updateResult, null);
  });

  test('Testing Timestamp Array Read', () async {
    var readResult = await readTimestampArray(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(
        readResult[0].col_timestamp_array![0].year, updatedTimestamp[0].year);
    expect(
        readResult[0].col_timestamp_array![0].month, updatedTimestamp[0].month);
    expect(readResult[0].col_timestamp_array![0].day, updatedTimestamp[0].day);
    expect(
        readResult[0].col_timestamp_array![0].hour, updatedTimestamp[0].hour);
    expect(readResult[0].col_timestamp_array![0].minute,
        updatedTimestamp[0].minute);
    expect(readResult[0].col_timestamp_array![0].second,
        updatedTimestamp[0].second);
    expect(readResult[0].col_timestamp_array![0].millisecond,
        updatedTimestamp[0].millisecond);
    expect(readResult[0].col_timestamp_array, isA<List<DateTime>>());
  });
}

Future<Object?> createTimestampArray(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      col_timestamp_array: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimestampArray(SupabaseClient supabase) async {
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

Future<Object?> updateTimestampArray(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(col_timestamp_array: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimestamp error");
    print(error);
    return error;
  }
}
