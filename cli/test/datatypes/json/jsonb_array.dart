import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    assert(readResult is List<JsonTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colJsonbArray, updatedJsonArray);
    expect(readResult[0].colJsonbArray, isA<List<Map<String, dynamic>>>());
  });

  test(
      "Testing JsonB Array serialization roundtrip maintains data integrity and object equivalence",
      () async {
    var readResult = await readJsonBArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];

    // Test toJson() followed by fromJson()
    var toJson = originalObject.toJson();
    var fromJson = JsonTypes.fromJson(toJson);
    expect(fromJson.colJsonbArray, originalObject.colJsonbArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = JsonTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colJsonbArray, originalObject.colJsonbArray);
  });
}

Future<Object?> createJsonBArray(
    SupabaseClient supabase, List<Map<String, dynamic>> insertVal) async {
  try {
    await supabase.json_types.insert(JsonTypes.insert(
      id: uuidx,
      colJsonbArray: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<JsonTypes>?> readJsonBArray(SupabaseClient supabase) async {
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

Future<Object?> updateJsonBArray(
    SupabaseClient supabase,
    List<Map<String, dynamic>> oldValue,
    List<Map<String, dynamic>> value) async {
  try {
    await supabase.json_types
        .update(JsonTypes.update(colJsonbArray: value))
        .eq(JsonTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJsonArray error");
    print(error);
    return error;
  }
}
