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
    await cleanup(supabase);
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
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    // Compare time with timezone

    expect(readResult[0].timetzx?.hour, updatedTimeTz.hour);
    expect(readResult[0].timetzx?.minute, updatedTimeTz.minute);
    expect(readResult[0].timetzx?.second, updatedTimeTz.second);

    expect(readResult[0].timetzx, isA<DateTime>());
  });
}

Future<Object?> createTimeTz(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      timetzx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readTimeTz(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
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
    await supabase.test_table
        .update(Test_table.update(timetzx: value))
        .eq(Test_table.c_timetzx, oldValue);
    return null;
  } catch (error) {
    print("updateTimeTz error");
    print(error);
    return error;
  }
}
