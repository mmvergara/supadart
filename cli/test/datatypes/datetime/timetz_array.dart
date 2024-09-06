import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeTzArrayTest(SupabaseClient supabase) async {
  // List of DateTimes with assumed timezones
  List<DateTime> insertTimeTzs = [
    DateTime(2021, 10, 10, 10, 10, 10),
    DateTime.utc(2022, 11, 11, 11, 11, 11),
  ];

  List<DateTime> updatedTimeTzs = [
    DateTime.now().toUtc(),
    DateTime(2023, 12, 12, 12, 12, 12),
  ];

  // Tests for TimeTz array
  test('Testing TimeTz Array Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimeTzArr(supabase, insertTimeTzs);
    expect(createResult, null);
  });

  test('Testing TimeTz Array Update', () async {
    var updateResult =
        await updateTimeTzArr(supabase, insertTimeTzs, updatedTimeTzs);
    expect(updateResult, null);
  });

  test('Testing TimeTz Array Read', () async {
    var readResult = await readTimeTzArr(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);

    var colTimetzArray = readResult[0].colTimetzArray!;

    for (int i = 0; i < insertTimeTzs.length; i++) {
      // var insertTimeUtc = insertTimeTzs[i].toUtc();
      var updatedTimeUtc = updatedTimeTzs[i].toUtc();
      var readTimeUtc = colTimetzArray[i].toUtc();

      // print("insert: $insertTimeUtc");
      // print("updated: $updatedTimeUtc");
      // print("read: $readTimeUtc");

      expect(readTimeUtc.difference(updatedTimeUtc).inMilliseconds,
          lessThan(1000)); // 1 second tolerance
    }

    expect(colTimetzArray, isA<List<DateTime>>());
  });
  test("Testing TimeTz Array toJson and fromJson", () async {
    var readResult = await readTimeTzArr(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);

    var colTimetzArrayOriginal = originalObject.colTimetzArray!;
    var colTimetzArrayFromJson = fromJson.colTimetzArray!;

    for (int i = 0; i < insertTimeTzs.length; i++) {
      var originalTimeUtc = colTimetzArrayOriginal[i].toUtc();
      var fromJsonTimeUtc = colTimetzArrayFromJson[i].toUtc();

      expect(fromJsonTimeUtc.difference(originalTimeUtc).inMilliseconds,
          lessThan(1000)); // 1 second tolerance
    }
  });
}

Future<Object?> createTimeTzArr(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      id: uuidx,
      colTimetzArray: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimeTzArr(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTimeTzArr error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimeTzArr(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    // Assuming the ID field for update is `colTimetz` (modify if different)
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimetzArray: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTimeTzArr error");
    print(error);
    return error;
  }
}
