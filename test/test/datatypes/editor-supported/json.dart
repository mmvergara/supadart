import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performJsonTest(SupabaseClient supabase) async {
  // json
  Map<String, dynamic> insertJson = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
  };
  Map<String, dynamic> updatedJson = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
    "key4": "value4",
  };

  test('Testing Json Create', () async {
    await cleanup(supabase);
    var createResult = await createJson(supabase, insertJson);
    expect(createResult, null);
  });

  test('Testing Json Update', () async {
    var updateResult = await updateJson(supabase, insertJson, updatedJson);
    expect(updateResult, null);
  });

  test('Testing Json Read', () async {
    var readResult = await readJson(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].jsonx, updatedJson);
    expect(readResult[0].jsonx, isA<Map<String, dynamic>>());
  });
}

Future<Object?> createJson(
    SupabaseClient supabase, Map<String, dynamic> insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      integerx: 360360,
      jsonx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readJson(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readJson error");
    print(error);
    return null;
  }
}

Future<Object?> updateJson(SupabaseClient supabase,
    Map<String, dynamic> oldValue, Map<String, dynamic> value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(jsonx: value))
        .eq(Test_table.c_integerx, 360360);
    return null;
  } catch (error) {
    print("updateJson error");
    print(error);
    return error;
  }
}
