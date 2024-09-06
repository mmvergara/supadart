import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../utils.dart';

Future<void> performDateArrayTest(SupabaseClient supabase) async {
  // json
  List<DateTime> insertDate = [DateTime(2021, 10, 10)];
  List<DateTime> updatedDate = [DateTime.now(), DateTime(2021, 10, 10)];

  test('Testing Date Array Create', () async {
    await cleanup(supabase, supabase.datetime_types);
    var createResult = await createDateArray(supabase, insertDate);
    expect(createResult, null);
  });

  test('Testing Date Array Update', () async {
    var updateResult = await updateDateArray(supabase, insertDate, updatedDate);
    expect(updateResult, null);
  });

  test('Testing Date Array Read', () async {
    var readResult = await readDateArray(supabase);
    assert(readResult is List<DatetimeTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colDateArray, isA<List<DateTime>>());
    for (int i = 0; i < insertDate.length; i++) {
      expect(readResult[0].colDateArray![i].year, updatedDate[i].year);
      expect(readResult[0].colDateArray![i].month, updatedDate[i].month);
      expect(readResult[0].colDateArray![i].day, updatedDate[i].day);
    }
  });

  test("Testing Date Array toJson and fromJson", () async {
    var readResult = await readDateArray(supabase);
    expect(readResult, isNotNull);
    expect(readResult!.isNotEmpty, true);

    var originalObject = readResult[0];
    var toJson = originalObject.toJson();
    var fromJson = DatetimeTypes.fromJson(toJson);

    for (int i = 0; i < insertDate.length; i++) {
      expect(
          fromJson.colDateArray![i].year, originalObject.colDateArray![i].year);
      expect(fromJson.colDateArray![i].month,
          originalObject.colDateArray![i].month);
      expect(
          fromJson.colDateArray![i].day, originalObject.colDateArray![i].day);
    }
  });
}

Future<Object?> createDateArray(
    SupabaseClient supabase, List<DateTime> insertVal) async {
  try {
    await supabase.datetime_types.insert(DatetimeTypes.insert(
      id: uuidx,
      colDateArray: insertVal,
    ));
    return null;
  } catch (error) {
    print("createDate Array error");
    return error;
  }
}

Future<List<DatetimeTypes>?> readDateArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.datetime_types
        .select()
        .withConverter(DatetimeTypes.converter);
    return res;
  } catch (error) {
    print("readDate Array error");
    print(error);
    return null;
  }
}

Future<Object?> updateDateArray(SupabaseClient supabase,
    List<DateTime> oldValue, List<DateTime> value) async {
  try {
    await supabase.datetime_types
        .update(DatetimeTypes.update(colDateArray: value))
        .eq(DatetimeTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateDate Array error");
    print(error);
    return error;
  }
}
