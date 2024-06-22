import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performJsonbTest(SupabaseClient supabase) async {
  // jsonb
  Map<String, dynamic> insertJsonb = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
  };
  Map<String, dynamic> updatedJsonb = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
    "key4": "value4",
  };

  test('Testing Jsonb Create', () async {
    await cleanup(supabase);
    var createResult = await createJsonb(supabase, insertJsonb);
    expect(createResult, null);
  });

  test('Testing Jsonb Update', () async {
    var updateResult = await updateJsonb(supabase, insertJsonb, updatedJsonb);
    expect(updateResult, null);
  });

  test('Testing Jsonb Read', () async {
    var readResult = await readJsonb(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].jsonbx, updatedJsonb);
    expect(readResult[0].jsonbx, isA<Map<String, dynamic>>());
  });
}

Future<Object?> createJsonb(
    SupabaseClient supabase, Map<String, dynamic> insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      integerx: 360360,
      jsonbx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readJsonb(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readJsonb error");
    print(error);
    return null;
  }
}

Future<Object?> updateJsonb(SupabaseClient supabase,
    Map<String, dynamic> oldValue, Map<String, dynamic> value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(jsonbx: value))
        .eq(Test_table.c_integerx, 360360);
    return null;
  } catch (error) {
    print("updateJsonb error");
    print(error);
    return error;
  }
}
