import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performJsonBArrayTest(SupabaseClient supabase) async {
  // jsonb
  List<Map<String, dynamic>> insertJsonArray = [
    {
      "key1": "value1",
      "key2": "value2",
      "key3": "value3",
    },
    {
      "key1": "value1",
      "key2": "value2",
      "key3": "value3",
    },
  ];
  List<Map<String, dynamic>> updatedJsonArray = [
    {
      "key1": "value1",
      "key2": "value2",
      "key3": "value3",
      "key4": "value4",
    },
    {
      "key1": "value1",
      "key2": "value2",
      "key3": "value3",
      "key4": "value4",
    },
  ];

  test('Testing JsonB Array Create', () async {
    await cleanup(supabase, supabase.json_types);
    var createResult = await createJsonBArray(supabase, insertJsonArray);
    expect(createResult, null);
  });

  test('Testing JsonB Array Update', () async {
    var updateResult =
        await updateJsonBArray(supabase, insertJsonArray, updatedJsonArray);
    expect(updateResult, null);
  });

  test('Testing JsonB Array Read', () async {
    var readResult = await readJsonBArray(supabase);
    print(readResult);
    print(readResult);
    print(readResult);
    print(readResult);
    assert(readResult is List<JsonTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_jsonb_array, updatedJsonArray);
    expect(readResult[0].col_jsonb_array, isA<List<Map<String, dynamic>>>());
  });
}

Future<Object?> createJsonBArray(
    SupabaseClient supabase, List<Map<String, dynamic>> insertVal) async {
  try {
    await supabase.json_types.insert(JsonTypes.insert(
      id: uuidx,
      col_jsonb_array: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<JsonTypes>?> readJsonBArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.json_types
        .select()
        .withConverter((data) => data.map(JsonTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readJsonArray error");
    print(error);
    return null;
  }
}

Future<Object?> updateJsonBArray(
    SupabaseClient supabase,
    List<Map<String, dynamic>> oldValue,
    List<Map<String, dynamic>> value) async {
  try {
    await supabase.json_types
        .update(JsonTypes.update(col_jsonb_array: value))
        .eq(JsonTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJsonArray error");
    print(error);
    return error;
  }
}
