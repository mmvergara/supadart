import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeTzTest(SupabaseClient supabase) async {
  // json
  DateTime insertTimeTz = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTimeTz = DateTime.now();

  test('Testing TimeTz Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    // print("Inserting: $insertTimeTz");
    var createResult = await createTimeTz(supabase, insertTimeTz);
    expect(createResult, null);
  });

  test('Testing TimeTz Update', () async {
    var updateResult =
        await updateTimeTz(supabase, insertTimeTz, updatedTimeTz);
    // print("Updating: $updatedTimeTz");
    expect(updateResult, null);
  });

  test('Testing TimeTz Read', () async {
    var readResult = await readTimeTz(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);

    // Convert to UTC for comparison
    // var insertTimeUtc = insertTimeTz.toUtc();
    var updatedTimeUtc = updatedTimeTz.toUtc();
    var readTimeUtc = readResult[0].colTimetz?.toUtc();

    // print("original: $insertTimeUtc");
    // print("updated: $updatedTimeUtc");
    // print("read: $readTimeUtc");

    // Compare times with tolerance
    expect(readTimeUtc?.difference(updatedTimeUtc).inMilliseconds,
        lessThan(1000)); // 1 second tolerance
  });

  test("Testing TimeTz serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTimeTz(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    final originalTimeUtc = originalObject.colTimetz?.toUtc();
    final fromJsonTimeUtc = fromJson.colTimetz?.toUtc();
    expect(fromJsonTimeUtc?.difference(originalTimeUtc!).inMilliseconds,
        lessThan(1000));

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    final roundTripTimeUtc = roundTripFromJson.colTimetz?.toUtc();
    expect(roundTripTimeUtc?.difference(originalTimeUtc!).inMilliseconds,
        lessThan(1000));
  });
}

Future<Object?> createTimeTz(
    SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      colTimetz: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimeTz(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTimeTz error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimeTz(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimetz: value))
        .eq(DatetimeTypes.c_colTimetz, oldValue);
    return null;
  } catch (error) {
    print("updateTimeTz error");
    print(error);
    return error;
  }
}
