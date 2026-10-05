import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTextArrayTest(SupabaseClient supabase) async {
  // Test values for text array
  List<String> insertTextArray = [
    "Once upon a time in a distant land called Database Kingdom there lived a brave little PostgreSQL.",
    "This PostgreSQL was not like any other database it could store vast amounts of data and perform complex queries with ease.",
    "The villagers relied on PostgreSQL to keep their records safe and sound."
  ];
  List<String> updatedTextArray = [
    "With his mighty powers he could store vast amounts of information and wield complex queries effortlessly.",
    "With his lol mighty powers he could store vast amounts of information and wield complex queries effortlessly.",
    "With his lol xd mighty powers he could store vast amounts of information and wield complex queries effortlessly."
  ];

  // Tests for text array
  test('Testing Text Array Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createTextArray(supabase, insertTextArray);
    expect(createResult, null);
  });

  test('Testing Text Array Update', () async {
    var updateResult =
        await updateTextArray(supabase, insertTextArray, updatedTextArray);
    expect(updateResult, null);
  });

  test('Testing Text Array Read', () async {
    var readResult = await readTextArray(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colTextArray, isA<List<String>>());
    expect(readResult[0].colTextArray, updatedTextArray);
  });

  test("Testing Text Array serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTextArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);
    expect(fromJson.colTextArray, originalObject.colTextArray);

    // Test full roundtrip and object equivalence
    var roundTripJson = fromJson.toJson();
    expect(roundTripJson, originalObject.toJson());
  });
}

Future<Object?> createTextArray(
    SupabaseClient supabase, List<String> insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colTextArray: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateTextArray(
    SupabaseClient supabase, List<String> oldValue, List<String> value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(colTextArray: value))
        .eq(StringTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTextArray error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readTextArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readTextArray error");
    print(error);
    return null;
  }
}
