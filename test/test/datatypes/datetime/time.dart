import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeTest(SupabaseClient supabase) async {
  // json
  DateTime insertTime = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTime = DateTime.now();

  test('Testing Time Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTime(supabase, insertTime);
    expect(createResult, null);
  });

  test('Testing Time Update', () async {
    var updateResult = await updateTime(supabase, insertTime, updatedTime);
    expect(updateResult, null);
  });

  test('Testing Time Read', () async {
    var readResult = await readTime(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_time?.hour, updatedTime.hour);
    expect(readResult[0].col_time?.minute, updatedTime.minute);
    expect(readResult[0].col_time?.second, updatedTime.second);
    expect(readResult[0].col_time, isA<DateTime>());
  });
}

Future<Object?> createTime(SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      col_time: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTime(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTime error");
    print(error);
    return null;
  }
}

Future<Object?> updateTime(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(col_time: value))
        .eq(DatetimeTypes.c_col_time, oldValue);
    return null;
  } catch (error) {
    print("updateTime error");
    print(error);
    return error;
  }
}
