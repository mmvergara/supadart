import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performUUIDArrayTest(SupabaseClient supabase) async {
  // List of UUIDs
  List<String> insertUuids = [uuidx, uuidy];
  List<String> updatedUuids = [uuidz, uuidx];

  // Tests for UUID array
  test('Testing UUID Array Create', () async {
    await cleanup(supabase, supabase.string_types);
    var createResult = await createUUIDArr(supabase, insertUuids);
    expect(createResult, null);
  });

  test('Testing UUID Array Update', () async {
    var updateResult = await updateUUIDArr(supabase, insertUuids, updatedUuids);
    expect(updateResult, null);
  });

  test('Testing UUID Array Read', () async {
    var readResult = await readUUIDArr(supabase);
    assert(readResult is List<StringTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].col_uuid_array, isA<List<String>>());
    expect(readResult[0].col_uuid_array!.length,
        updatedUuids.length); // Check array length
    expect(readResult[0].col_uuid_array,
        updatedUuids); // Assuming order is preserved
  });
}

Future<Object?> createUUIDArr(
    SupabaseClient supabase, List<String> insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      id: uuidx,
      col_uuid_array: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateUUIDArr(
    SupabaseClient supabase, List<String> oldValue, List<String> value) async {
  try {
    // Assuming the ID field for update is `col_uuid` (modify if different)
    await supabase.string_types
        .update(StringTypes.update(col_uuid_array: value))
        .eq(StringTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateUuidArr error");
    print(error);
    return error;
  }
}

Future<List<StringTypes>?> readUUIDArr(SupabaseClient supabase) async {
  try {
    var res = await supabase.string_types
        .select()
        .withConverter(StringTypes.converter);
    return res;
  } catch (error) {
    print("readUuidArr error");
    print(error);
    return null;
  }
}
