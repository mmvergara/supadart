import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performBooleanTest(SupabaseClient supabase) async {
  bool insertBoolean = true;
  bool updatedBoolean = false;

  test('Testing Boolean Create', () async {
    await cleanup(supabase, supabase.boolean_bit_types);
    var createResult = await createBoolean(supabase, insertBoolean);
    expect(createResult, null);
  });

  test('Testing Boolean Update', () async {
    var updateResult =
        await updateBoolean(supabase, insertBoolean, updatedBoolean);
    expect(updateResult, null);
  });

  test('Testing Boolean Read', () async {
    var readResult = await readBoolean(supabase);
    assert(readResult is List<BooleanBitTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_boolean, isA<bool>());
    expect(readResult[0].col_boolean, updatedBoolean);
  });
}

Future<Object?> createBoolean(SupabaseClient supabase, bool insertVal) async {
  try {
    await supabase.boolean_bit_types.insert(BooleanBitTypes.insert(
      col_boolean: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBoolean(
    SupabaseClient supabase, bool oldValue, bool value) async {
  try {
    await supabase.boolean_bit_types
        .update(BooleanBitTypes.update(
          col_boolean: value,
        ))
        .eq(BooleanBitTypes.c_col_boolean, oldValue);
    return null;
  } catch (error) {
    print("updateBoolean error");
    print(error);
    return error;
  }
}

Future<List<BooleanBitTypes>?> readBoolean(SupabaseClient supabase) async {
  try {
    return await supabase.boolean_bit_types
        .select()
        .withConverter((data) => data.map(BooleanBitTypes.fromJson).toList());
  } catch (error) {
    print("readBoolean error");
    print(error);
    return null;
  }
}
