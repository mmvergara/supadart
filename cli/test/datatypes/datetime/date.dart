import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performDateTest(SupabaseClient supabase) async {
  // json
  DateTime insertDate = DateTime(2021, 10, 10);

  DateTime updatedDate = DateTime.now();

  test('Testing Date Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createDate(supabase, insertDate);
    expect(createResult, null);
  });

  test('Testing Date Update', () async {
    var updateResult = await updateDate(supabase, insertDate, updatedDate);
    expect(updateResult, null);
  });

  test('Testing Date Read', () async {
    var readResult = await readDate(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_date?.year, updatedDate.year);
    expect(readResult[0].col_date?.month, updatedDate.month);
    expect(readResult[0].col_date?.day, updatedDate.day);
    expect(readResult[0].col_date, isA<DateTime>());
  });
}

Future<Object?> createDate(SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      col_date: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readDate(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readDate error");
    print(error);
    return null;
  }
}

Future<Object?> updateDate(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(col_date: value))
        .eq(DatetimeTypes.c_col_date, oldValue);
    return null;
  } catch (error) {
    print("updateDate error");
    print(error);
    return error;
  }
}
