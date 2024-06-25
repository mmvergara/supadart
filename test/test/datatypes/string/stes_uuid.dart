import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performUuidTest(SupabaseClient supabase) async {
  // json
  String insertUuid = uuidx;
  String updatedUuid = uuidy;

  test('Testing UUID Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createUuid(supabase, insertUuid);
    expect(createResult, null);
  });

  test('Testing UUID Update', () async {
    var updateResult = await updateUuid(supabase, insertUuid, updatedUuid);
    expect(updateResult, null);
  });

  test('Testing UUID Read', () async {
    var readResult = await readUuid(supabase);
    assert(readResult is List<String_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_uuid, updatedUuid);
    expect(readResult[0].col_uuid, isA<String>());
  });
}

Future<Object?> createUuid(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(String_types.insert(
      col_uuid: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<String_types>?> readUuid(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter((data) => data.map(String_types.fromJson).toList());
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
    await supabase.string_types
        .update(String_types.update(col_uuid: value))
        .eq(String_types.c_col_uuid, oldValue);
    return null;
  } catch (error) {
    print("updateUuid error");
    print(error);
    return error;
  }
}
