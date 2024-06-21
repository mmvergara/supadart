import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performTimestamptzTest(SupabaseClient supabase) async {
  DateTime insertTimestamptz = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTimestamptz = DateTime.now();

  test('Testing Timestamptz Create', () async {
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);

    var storedTimestamp = readResult[0].timestamptzx;
    expect(storedTimestamp, isA<DateTime>());

    // Convert both timestamps to UTC for comparison
    var updatedTimestamptzUtc = updatedTimestamptz.toUtc();
    var storedTimestampUtc = storedTimestamp!.toUtc();

    // Compare the UTC timestamps
    expect(storedTimestampUtc.year, updatedTimestamptzUtc.year);
    print("Done comparing year");
    expect(storedTimestampUtc.month, updatedTimestamptzUtc.month);
    print("Done comparing month");
    expect(storedTimestampUtc.day, updatedTimestamptzUtc.day);
    print("Done comparing day");
    expect(storedTimestampUtc.hour, updatedTimestamptzUtc.hour);
    print("Done comparing hour");
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
    await supabase.test_table.insert(Test_table.insert(
      timestamptzx: insertVal,
      integerx: 361361,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readTimestamptz(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
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
    await supabase.test_table
        .update(Test_table.update(timestamptzx: value))
        .eq(Test_table.c_integerx, 361361);
    return null;
  } catch (error) {
    print("updateTimestamptz error");
    print(error);
    return error;
  }
}
