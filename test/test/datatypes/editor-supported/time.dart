import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performTimeTest(SupabaseClient supabase) async {
  // json
  DateTime insertTime = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTime = DateTime.now();

  test('Testing Time Create', () async {
    await cleanup(supabase);
    var createResult = await createTime(supabase, insertTime);
    expect(createResult, null);
  });

  test('Testing Time Update', () async {
    var updateResult = await updateTime(supabase, insertTime, updatedTime);
    expect(updateResult, null);
  });

  test('Testing Time Read', () async {
    var readResult = await readTime(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].timex?.hour, updatedTime.hour);
    expect(readResult[0].timex?.minute, updatedTime.minute);
    expect(readResult[0].timex?.second, updatedTime.second);
    expect(readResult[0].timex, isA<DateTime>());
  });
}

Future<Object?> createTime(SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      timex: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readTime(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
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
    await supabase.test_table
        .update(Test_table.update(timex: value))
        .eq(Test_table.c_timex, oldValue);
    return null;
  } catch (error) {
    print("updateTime error");
    print(error);
    return error;
  }
}
