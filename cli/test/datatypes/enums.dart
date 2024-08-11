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
    expect(readResult[0].col_mood, isA<MOOD>());
    expect(readResult[0].col_mood, updatedEnum);
  });
}

Future<Object?> createEnum(SupabaseClient supabase, MOOD insertVal) async {
  try {
    await supabase.enum_types.insert(EnumTypes.insert(
      col_mood: insertVal,
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
        .update(EnumTypes.update(col_mood: value))
        .eq(EnumTypes.c_col_mood, oldValue.toString().split(".").last);
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
