import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

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
    await cleanup(supabase, supabase.json_types);
    var createResult = await createJson(supabase, insertJson);
    expect(createResult, null);
  });

  test('Testing Json Update', () async {
    var updateResult = await updateJson(supabase, insertJson, updatedJson);
    expect(updateResult, null);
  });

  test('Testing Json Read', () async {
    var readResult = await readJson(supabase);
    assert(readResult is List<JsonTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_json, updatedJson);
    expect(readResult[0].col_json, isA<Map<String, dynamic>>());
  });
}

Future<Object?> createJson(
    SupabaseClient supabase, Map<String, dynamic> insertVal) async {
  try {
    await supabase.json_types.insert(JsonTypes.insert(
      id: uuidx,
      col_json: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<JsonTypes>?> readJson(SupabaseClient supabase) async {
  try {
    var res = await supabase.json_types
        .select()
        .withConverter((data) => data.map(JsonTypes.fromJson).toList());
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
    await supabase.json_types
        .update(JsonTypes.update(col_json: value))
        .eq(JsonTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJson error");
    print(error);
    return error;
  }
}
