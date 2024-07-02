import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeArrayTest(SupabaseClient supabase) async {
  // json
  List<DateTime> insertTime = [DateTime(2021, 10, 10, 10, 10, 10)];

  List<DateTime> updatedTime = [DateTime.now()];

  test('Testing Time Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimeArray(supabase, insertTime);
    expect(createResult, null);
  });

  test('Testing Time Update', () async {
    var updateResult = await updateTimeArray(supabase, insertTime, updatedTime);
    expect(updateResult, null);
  });

  test('Testing Time Read', () async {
    var readResult = await readTimeArray(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_time_array, isA<List<DateTime>>());
    for (int i = 0; i < insertTime.length; i++) {
      expect(readResult[0].col_time_array![i].hour, updatedTime[i].hour);
      expect(readResult[0].col_time_array![i].minute, updatedTime[i].minute);
      expect(readResult[0].col_time_array![i].second, updatedTime[i].second);
    }
  });
}

Future<Object?> createTimeArray(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types
        .insert(DatetimeTypes.insert(col_time_array: insertVal, id: uuidx));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimeArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter((data) => data.map(DatetimeTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readTime error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimeArray(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(col_time_array: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTime error");
    print(error);
    return error;
  }
}
