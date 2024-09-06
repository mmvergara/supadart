import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performTimeTest(SupabaseClient supabase) async {
  // json
  DateTime insertTime = DateTime(2021, 10, 10, 10, 10, 10);

  DateTime updatedTime = DateTime.now();

  test('Testing Time Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createTime(supabase, insertTime);
    expect(createResult, null);
  });

  test('Testing Time Update', () async {
    var updateResult = await updateTime(supabase, insertTime, updatedTime);
    expect(updateResult, null);
  });

  test('Testing Time Read', () async {
    var readResult = await readTime(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colTime?.hour, updatedTime.hour);
    expect(readResult[0].colTime?.minute, updatedTime.minute);
    expect(readResult[0].colTime?.second, updatedTime.second);
    expect(readResult[0].colTime, isA<DateTime>());
  });

  test("Testing Time toJson and fromJson", () async {
    var readResult = await readTime(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);

    expect(fromJson.colTime?.hour, originalObject.colTime?.hour);
    expect(fromJson.colTime?.minute, originalObject.colTime?.minute);
    expect(fromJson.colTime?.second, originalObject.colTime?.second);
  });

  test("Testing Time serialization roundtrip maintains data integrity",
      () async {
    var readResult = await readTime(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    // Test toJson() followed by fromJson()
    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);
    expect(fromJson.colTime, originalObject.colTime);
    
    // Test full roundtrip and object equivalence
    var roundTripToJson = fromJson.toJson();
    var roundTripFromJson = DatetimeTypes.fromJson(roundTripToJson);
    expect(roundTripFromJson.colTime, originalObject.colTime);
  });
}

Future<Object?> createTime(SupabaseClient supabase, DateTime insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      colTime: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<DatetimeTypes>?> readTime(SupabaseClient supabase) async {
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

Future<Object?> updateTime(
    SupabaseClient supabase, DateTime oldValue, DateTime value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colTime: value))
        .eq(DatetimeTypes.c_colTime, oldValue);
    return null;
  } catch (error) {
    print("updateTime error");
    print(error);
    return error;
  }
}
