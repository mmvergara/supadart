import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performTextTest(SupabaseClient supabase) async {
  // Test values for text
  String insertText =
      "Once upon a time in a dsistant land called Database Kingdom, there lived a brave little PostgreSQL. This PostgreSQL was not like any other database; it could store vast amounts of data and perform complex queries with ease. The villagers relied on PostgreSQL to keep their records safe and sound.";
  String updatedText =
      "The Saga of PostgreSQL the Great', 'In a realm known as the Land of Data, there was a powerful ruler named PostgreSQL the Great. With his mighty powers, he could store vast amounts of information and wield complex queries effortlessly.";

  // Tests for text
  test('Testing Text Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createText(supabase, insertText);
    expect(createResult, null);
  });

  test('Testing Text Update', () async {
    var updateResult = await updateText(supabase, insertText, updatedText);
    expect(updateResult, null);
  });

  test('Testing Text Read', () async {
    var readResult = await readText(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colText, isA<String>());
    expect(readResult[0].colText, updatedText);
  });


  test("Testing Text serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readText(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);
    expect(fromJson.colText, originalObject.colText);

    // Test full roundtrip and object equivalence
    var roundTripJson = fromJson.toJson();
    expect(roundTripJson, originalObject.toJson());
  });
}

Future<Object?> createText(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colText: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateText(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(colText: value))
        .eq(StringTypes.c_colText, oldValue);
    return null;
  } catch (error) {
    print("updateText error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readText(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readText error");
    print(error);
    return null;
  }
}
