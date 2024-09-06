import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
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
    expect(readResult[0].colUuid, updatedUuid);
    expect(readResult[0].colUuid, isA<String>());
  });

  test("Testing UUID toJson and fromJson", () async {
    var readResult = await readUUID(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = StringTypes.fromJson(toJson);

    expect(fromJson.colUuid, originalObject.colUuid);
  });
}

Future<Object?> createUUID(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.string_types.insert(StringTypes.insert(
      colUuid: insertVal,
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
        .withConverter(StringTypes.converter);
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
        .update(StringTypes.update(colUuid: value))
        .eq(StringTypes.c_colUuid, oldValue);
    return null;
  } catch (error) {
    print("updateUuid error");
    print(error);
    return error;
  }
}
