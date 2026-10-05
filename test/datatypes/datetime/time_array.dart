import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeArrayTest(SupabaseClient supabase) async {
  // json
  List<DateTime> insertTime = [DateTime(2021, 10, 10, 10, 10, 10)];

  List<DateTime> updatedTime = [DateTime.now()];

  test('Testing Time Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTimeArray(supabase, insertTime);
    expect(createResult, null);
  });

  test('Testing Time Update', () async {
    var updateResult = await updateTimeArray(supabase, insertTime, updatedTime);
    expect(updateResult, null);
  });

  test('Testing Time Read', () async {
    var readResult = await readTimeArray(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colTimeArray, isA<List<DateTime>>());
    for (int i = 0; i < insertTime.length; i++) {
      expect(readResult[0].colTimeArray![i].hour, updatedTime[i].hour);
      expect(readResult[0].colTimeArray![i].minute, updatedTime[i].minute);
      expect(readResult[0].colTimeArray![i].second, updatedTime[i].second);
    }
  });

  test("Testing Time serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTimeArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colTimeArray, originalObject.colTimeArray);

    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colTimeArray, originalObject.colTimeArray);
  });
}

Future<Object?> createTimeArray(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types
        .insert(DatetimeTypes.insert(colTimeArray: insertVal, id: uuidx));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTimeArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readTime error");
    print(error);
    return null;
  }
}

Future<Object?> updateTimeArray(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTimeArray: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateTime error");
    print(error);
    return error;
  }
}
