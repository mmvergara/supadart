import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performBooleanArrayTest(SupabaseClient supabase) async {
  List<bool> insertBooleanArray = [true, false, true];
  List<bool> updatedBooleanArray = [false, true, false];

  test('Testing Boolean Array Create', () async {
    await cleanup(supabase, supabase.boolean_bit_types);
    var createResult = await createBooleanArray(supabase, insertBooleanArray);
    expect(createResult, null);
  });

  test('Testing Boolean Array Update', () async {
    var updateResult = await updateBooleanArray(supabase, updatedBooleanArray);
    expect(updateResult, null);
  });

  test('Testing Boolean Array Read', () async {
    var readResult = await readBooleanArray(supabase);
    assert(readResult is List<BooleanBitTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colBooleanArray, isA<List<bool>>());
    expect(readResult[0].colBooleanArray![0], updatedBooleanArray[0]);
  });
}

Future<Object?> createBooleanArray(
    SupabaseClient supabase, List<bool> insertVal) async {
  try {
    await supabase.boolean_bit_types.insert(BooleanBitTypes.insert(
      id: uuidx,
      colBooleanArray: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBooleanArray(
    SupabaseClient supabase, List<bool> value) async {
  try {
    await supabase.boolean_bit_types
        .update(BooleanBitTypes.update(
          colBooleanArray: value,
        ))
        .eq(BooleanBitTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateBooleanArray error");
    print(error);
    return error;
  }
}

Future<List<BooleanBitTypes>?> readBooleanArray(SupabaseClient supabase) async {
  try {
    return await supabase.boolean_bit_types
        .select()
        .withConverter(BooleanBitTypes.converter);
  } catch (error) {
    print("readBooleanArray error");
    print(error);
    return null;
  }
}
