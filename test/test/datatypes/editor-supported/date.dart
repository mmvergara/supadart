import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performDateTest(SupabaseClient supabase) async {
  // json
  DateTime insertDate = DateTime(2021, 10, 10);

  DateTime updatedDate = DateTime.now();

  test('Testing Date Create', () async {
    await cleanup(supabase);
    var createResult = await createDate(supabase, insertDate);
    expect(createResult, null);
  });

  test('Testing Date Update', () async {
    var updateResult = await updateDate(supabase, insertDate, updatedDate);
    expect(updateResult, null);
  });

  test('Testing Date Read', () async {
    var readResult = await readDate(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].datex?.year, updatedDate.year);
    expect(readResult[0].datex?.month, updatedDate.month);
    expect(readResult[0].datex?.day, updatedDate.day);
    expect(readResult[0].datex, isA<DateTime>());
  });
}

Future<Object?> createDate(SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      datex: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readDate(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
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
    await supabase.test_table
        .update(Test_table.update(datex: value))
        .eq(Test_table.c_datex, oldValue);
    return null;
  } catch (error) {
    print("updateDate error");
    print(error);
    return error;
  }
}

