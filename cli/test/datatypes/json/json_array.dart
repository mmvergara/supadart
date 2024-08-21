import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performJsonArrayTest(SupabaseClient supabase) async {
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

  test('Testing Json Array Create', () async {
    await cleanup(supabase, supabase.json_types);
    var createResult = await createJsonArray(supabase, insertJsonArray);
    expect(createResult, null);
  });

  test('Testing Json Array Update', () async {
    var updateResult =
        await updateJsonArray(supabase, insertJsonArray, updatedJsonArray);
    expect(updateResult, null);
  });

  test('Testing Json Array Read', () async {
    var readResult = await readJsonArray(supabase);
    assert(readResult is List<JsonTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colJsonArray, updatedJsonArray);
    expect(readResult[0].colJsonArray, isA<List<Map<String, dynamic>>>());
  });
}

Future<Object?> createJsonArray(
    SupabaseClient supabase, List<Map<String, dynamic>> insertVal) async {
  try {
    await supabase.json_types.insert(JsonTypes.insert(
      id: uuidx,
      colJsonArray: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<JsonTypes>?> readJsonArray(SupabaseClient supabase) async {
  try {
    var res =
        await supabase.json_types.select().withConverter(JsonTypes.converter);
    return res;
  } catch (error) {
    print("readJsonArray error");
    print(error);
    return null;
  }
}

Future<Object?> updateJsonArray(
    SupabaseClient supabase,
    List<Map<String, dynamic>> oldValue,
    List<Map<String, dynamic>> value) async {
  try {
    await supabase.json_types
        .update(JsonTypes.update(colJsonArray: value))
        .eq(JsonTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJsonArray error");
    print(error);
    return error;
  }
}
