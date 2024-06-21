import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../cleanup.dart';

Future<void> performUuidTest(SupabaseClient supabase) async {
  // json
  String insertUuid = "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11";
  String updatedUuid = "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12";

  test('Testing UUID Create', () async {
    await cleanup(supabase);
    var createResult = await createUuid(supabase, insertUuid);
    expect(createResult, null);
  });

  test('Testing UUID Update', () async {
    var updateResult = await updateUuid(supabase, insertUuid, updatedUuid);
    expect(updateResult, null);
  });

  test('Testing UUID Read', () async {
    var readResult = await readUuid(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].uuidx, updatedUuid);
    expect(readResult[0].uuidx, isA<String>());
  });
}

Future<Object?> createUuid(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      uuidx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readUuid(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readUuid error");
    print(error);
    return null;
  }
}

Future<Object?> updateUuid(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(uuidx: value))
        .eq(Test_table.c_uuidx, oldValue);
    return null;
  } catch (error) {
    print("updateUuid error");
    print(error);
    return error;
  }
}

