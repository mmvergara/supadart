import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeTzTest(SupabaseClient supabase) async {
  // json
  DateTime insertTimeTz = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTimeTz = DateTime.now();

  test('Testing TimeTz Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimeTz(supabase, insertTimeTz);
    expect(createResult, null);
  });

  test('Testing TimeTz Update', () async {
    var updateResult =
        await updateTimeTz(supabase, insertTimeTz, updatedTimeTz);
    expect(updateResult, null);
  });

  test('Testing TimeTz Read', () async {
    var readResult = await readTimeTz(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    // Compare time with timezone

    expect(readResult[0].col_timetz?.hour, updatedTimeTz.hour);
    expect(readResult[0].col_timetz?.minute, updatedTimeTz.minute);
    expect(readResult[0].col_timetz?.second, updatedTimeTz.second);

    expect(readResult[0].col_timetz, isA<DateTime>());
  });
}

Future<Object?> createTimeTz(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      col_timetz: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimeTz(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter((data) => data.map(DatetimeTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readTimeTz error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimeTz(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(col_timetz: value))
        .eq(DatetimeTypes.c_col_timetz, oldValue);
    return null;
  } catch (error) {
    print("updateTimeTz error");
    print(error);
    return error;
  }
}
