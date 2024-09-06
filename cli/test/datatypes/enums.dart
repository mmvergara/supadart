import 'package:supabase/supabase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../models/generated_classes.dart';
import '../utils.dart';

Future<void> performEnumTypesTest(SupabaseClient supabase) async {
  // Test values for enum
  MOOD insertEnum = MOOD.angry;
  MOOD updatedEnum = MOOD.excited;

  // Tests for enum
  test('Testing Enum Create', () async {
    await cleanup(supabase, supabase.enum_types);
    var createResult = await createEnum(supabase, insertEnum);
    expect(createResult, null);
  });

  test('Testing Enum Update', () async {
    var updateResult = await updateEnum(supabase, insertEnum, updatedEnum);
    expect(updateResult, null);
  });

  test('Testing Enum Read', () async {
    var readResult = await readEnum(supabase);
    assert(readResult is List<EnumTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colMood, isA<MOOD>());
    expect(readResult[0].colMood, updatedEnum);
  });

  test("Testing Enum serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readEnum(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = EnumTypes.fromJson(toJson);
    expect(fromJson.colMood, originalObject.colMood);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = EnumTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colMood, originalObject.colMood);
  });
}

Future<Object?> createEnum(SupabaseClient supabase, MOOD insertVal) async {
  try {
    await supabase.enum_types.insert(EnumTypes.insert(
      colMood: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateEnum(
    SupabaseClient supabase, MOOD oldValue, MOOD value) async {
  try {
    await supabase.enum_types
        .update(EnumTypes.update(colMood: value))
        .eq(EnumTypes.c_colMood, oldValue.toString().split(".").last);
    return null;
  } catch (error) {
    print("updateEnum error");
    print(error);
    return error;
  }
}

Future<List<EnumTypes>?> readEnum(SupabaseClient supabase) async {
  try {
    var res =
        await supabase.enum_types.select().withConverter(EnumTypes.converter);
    return res;
  } catch (error) {
    print("readEnum error");
    print(error);
    return null;
  }
}
