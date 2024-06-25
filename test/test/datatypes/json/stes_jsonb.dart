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
    await cleanup(supabase, supabase.json_types);
    var createResult = await createJsonb(supabase, insertJsonb);
    expect(createResult, null);
  });

  test('Testing Jsonb Update', () async {
    var updateResult = await updateJsonb(supabase, insertJsonb, updatedJsonb);
    expect(updateResult, null);
  });

  test('Testing Jsonb Read', () async {
    var readResult = await readJsonb(supabase);
    assert(readResult is List<Json_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_jsonb, updatedJsonb);
    expect(readResult[0].col_jsonb, isA<Map<String, dynamic>>());
  });
}

Future<Object?> createJsonb(
    SupabaseClient supabase, Map<String, dynamic> insertVal) async {
  try {
    await supabase.json_types.insert(Json_types.insert(
      id: uuidx,
      col_jsonb: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Json_types>?> readJsonb(SupabaseClient supabase) async {
  try {
    var res = await supabase.json_types
        .select()
        .withConverter((data) => data.map(Json_types.fromJson).toList());
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
    await supabase.json_types
        .update(Json_types.update(col_jsonb: value))
        .eq(Json_types.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJsonb error");
    print(error);
    return error;
  }
}
