import 'package:supabase/supabase.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../models/generated_classes.dart';
import '../utils.dart';

Future<void> performEnumTypesTest(SupabaseClient supabase) async {
  // Test values for enum
  MOOD insertEnum = MOOD.angry;
  MOOD updatedEnum = MOOD.excited;
  List<MOOD> insertedEnumArray = [MOOD.excited, MOOD.happy];
  List<MOOD> updatedEnumArray = [MOOD.excited, MOOD.sad];

  // Tests for enum
  test('Testing Enum Create', () async {
    await cleanup(supabase, supabase.enum_types);
    var createResult =
        await createEnum(supabase, insertEnum, insertedEnumArray);

    expect(createResult, null);
  });

  test('Testing Enum Update', () async {
    var updateResult =
        await updateEnum(supabase, insertEnum, updatedEnum, updatedEnumArray);
    expect(updateResult, null);
  });

  test('Testing Enum Read', () async {
    var readResult = await readEnum(supabase);
    print(readResult);
    assert(readResult is List<EnumTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colMood, isA<MOOD>());
    expect(readResult[0].colMood, updatedEnum);

    // New test for mood array
    expect(readResult[0].colMoodArray, isA<List<MOOD>>());
    expect(readResult[0].colMoodArray, updatedEnumArray);
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
    expect(fromJson.colMoodArray, originalObject.colMoodArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = EnumTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colMood, originalObject.colMood);
    expect(roundTripFromJson.colMoodArray, originalObject.colMoodArray);
  });
}

/// Labels that are not Dart identifiers must round-trip through the database.
Future<void> performEnumLabelTypesTest(SupabaseClient supabase) async {
  final row = EnumLabelTypes.insert(
    colStatus: TASK_STATUS.inProgress,
    colStatusArray: TASK_STATUS.values,
  );

  test('Testing Enum labels round-trip', () async {
    await cleanup(supabase, supabase.enum_label_types);
    await supabase.enum_label_types.insert(row);

    final read = await supabase.enum_label_types
        .select()
        .eq(EnumLabelTypes.c_colStatus, TASK_STATUS.inProgress.value)
        .withConverter(EnumLabelTypes.converter);
    expect(read, hasLength(1));
    expect(read.single.colStatus, TASK_STATUS.inProgress);
    expect(read.single.colStatusNullable, isNull);
    expect(read.single.colStatusArray, TASK_STATUS.values);
  });

  test('Testing Enum labels update', () async {
    await supabase.enum_label_types
        .update(EnumLabelTypes.update(
            colStatus: TASK_STATUS.itS1, colStatusNullable: TASK_STATUS.v2fa))
        .eq(EnumLabelTypes.c_colStatus, TASK_STATUS.inProgress.value);

    final read = await supabase.enum_label_types
        .select()
        .withConverter(EnumLabelTypes.converter);
    expect(read.single.colStatus, TASK_STATUS.itS1);
    expect(read.single.colStatusNullable, TASK_STATUS.v2fa);
  });
}

Future<Object?> createEnum(
    SupabaseClient supabase, MOOD insertVal, List<MOOD> insertArray) async {
  try {
    await supabase.enum_types.insert(
        EnumTypes.insert(colMood: insertVal, colMoodArray: insertArray));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateEnum(SupabaseClient supabase, MOOD oldValue,
    MOOD newValue, List<MOOD> newArray) async {
  try {
    await supabase.enum_types
        .update(EnumTypes.update(colMood: newValue, colMoodArray: newArray))
        .eq(EnumTypes.c_colMood, oldValue.value);
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
