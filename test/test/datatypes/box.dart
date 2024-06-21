import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performBoxTest(SupabaseClient supabase) async {
  // Test values for box
  String insertBox = '(1,2),(3,4)';
  String updatedBox = '(3,7),(1,2)';

  // Tests for box
  test('Testing Box Create', () async {
    await cleanup(supabase);
    var createResult = await createBox(supabase, insertBox);
    expect(createResult, null);
  });

  test('Testing Box Update', () async {
    var updateResult = await updateBox(supabase, insertBox, updatedBox);
    expect(updateResult, null);
  });

  test('Testing Box Read', () async {
    var readResult = await readBox(supabase);
    assert(readResult is List<All_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].boxx, updatedBox);
  });
}

Future<Object?> createBox(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.all_types.insert(All_types.insert(
      boxx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBox(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.all_types
        .update(All_types.update(boxx: value))
        .eq(All_types.c_boxx, oldValue);
    return null;
  } catch (error) {
    print("updateBox error");
    print(error);
    return error;
  }
}

Future<List<All_types>?> readBox(SupabaseClient supabase) async {
  try {
    var res = await supabase.all_types
        .select()
        .withConverter((data) => data.map(All_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readBox error");
    print(error);
    return null;
  }
}
