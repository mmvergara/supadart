import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performUUIDTest(SupabaseClient supabase) async {
  // json
  String insertUuid = uuidx;
  String updatedUuid = uuidy;

  test('Testing UUID Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createUUID(supabase, insertUuid);
    expect(createResult, null);
  });

  test('Testing UUID Update', () async {
    var updateResult = await updateUUID(supabase, insertUuid, updatedUuid);
    expect(updateResult, null);
  });

  test('Testing UUID Read', () async {
    var readResult = await readUUID(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_uuid, updatedUuid);
    expect(readResult[0].col_uuid, isA<String>());
  });
}

Future<Object?> createUUID(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      col_uuid: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<StringTypes>?> readUUID(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter((data) => data.map(StringTypes.fromJson).toList());
    return res;
  } catch (error) {
    print("readUuid error");
    print(error);
    return null;
  }
}

Future<Object?> updateUUID(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.string_types
        .update(StringTypes.update(col_uuid: value))
        .eq(StringTypes.c_col_uuid, oldValue);
    return null;
  } catch (error) {
    print("updateUuid error");
    print(error);
    return error;
  }
}
