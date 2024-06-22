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
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].timestampx?.year, updatedTimestamp.year);
    expect(readResult[0].timestampx?.month, updatedTimestamp.month);
    expect(readResult[0].timestampx?.day, updatedTimestamp.day);
    expect(readResult[0].timestampx?.hour, updatedTimestamp.hour);
    expect(readResult[0].timestampx?.minute, updatedTimestamp.minute);
    expect(readResult[0].timestampx?.second, updatedTimestamp.second);
    expect(readResult[0].timestampx?.millisecond, updatedTimestamp.millisecond);
    expect(readResult[0].timestampx, isA<DateTime>());
  });
}

Future<Object?> createTimestamp(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      timestampx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readTimestamp(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
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
    await supabase.test_table
        .update(Test_table.update(timestampx: value))
        .eq(Test_table.c_timestampx, oldValue);
    return null;
  } catch (error) {
    print("updateTimestamp error");
    print(error);
    return error;
  }
}

