import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performJsonBTest(SupabaseClient supabase) async {
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
    var createResult = await createJsonB(supabase, insertJsonb);
    expect(createResult, null);
  });

  test('Testing Jsonb Update', () async {
    var updateResult = await updateJsonB(supabase, insertJsonb, updatedJsonb);
    expect(updateResult, null);
  });

  test('Testing Jsonb Read', () async {
    var readResult = await readJsonB(supabase);
    assert(readResult is List<JsonTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colJsonb, updatedJsonb);
    expect(readResult[0].colJsonb, isA<Map<String, dynamic>>());
  });

  test(
      "Testing Jsonb serialization roundtrip maintains data integrity and object equivalence",
      () async {
    var readResult = await readJsonB(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];

    // Test toJson() followed by fromJson()
    var toJson = originalObject.toJson();
    var fromJson = JsonTypes.fromJson(toJson);
    expect(fromJson.colJsonb, originalObject.colJsonb);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = JsonTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colJsonb, originalObject.colJsonb);
  });
}

Future<Object?> createJsonB(
    SupabaseClient supabase, Map<String, dynamic> insertVal) async {
  try {
    await supabase.json_types.insert(JsonTypes.insert(
      id: uuidx,
      colJsonb: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<JsonTypes>?> readJsonB(SupabaseClient supabase) async {
  try {
    var res =
        await supabase.json_types.select().withConverter(JsonTypes.converter);
    return res;
  } catch (error) {
    print("readJsonb error");
    print(error);
    return null;
  }
}

Future<Object?> updateJsonB(SupabaseClient supabase,
    Map<String, dynamic> oldValue, Map<String, dynamic> value) async {
  try {
    await supabase.json_types
        .update(JsonTypes.update(colJsonb: value))
        .eq(JsonTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateJsonb error");
    print(error);
    return error;
  }
}
