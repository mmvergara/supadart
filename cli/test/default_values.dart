import 'package:supabase/supabase.dart';
import 'dart:mirrors';
import 'models/generated_classes.dart';
import 'utils.dart';

import 'package:test/test.dart';

Future<void> performDefaultValuesTest(SupabaseClient supabase) async {
  await performTypeDefaultValuesTest(
      supabase, supabase.string_types, StringTypes.fromJson, "string_types");

  await performTypeDefaultValuesTest(supabase, supabase.boolean_bit_types,
      BooleanBitTypes.fromJson, "boolean_bit_types");

  await performTypeDefaultValuesTest(
      supabase, supabase.numeric_types, NumericTypes.fromJson, "numeric_types");

  await performTypeDefaultValuesTest(supabase, supabase.datetime_types,
      DatetimeTypes.fromJson, "datetime_types");

  await performTypeDefaultValuesTest(
      supabase, supabase.json_types, JsonTypes.fromJson, "json_types");
}

Future<void> performTypeDefaultValuesTest<T extends SupadartClass<T>>(
  SupabaseClient supabase,
  SupabaseQueryBuilder supabaseQuery,
  T Function(Map<String, dynamic> data) fromJson,
  String tableName,
) async {
  test('Testing Create Empty $tableName Row', () async {
    await cleanup(supabase, supabaseQuery);
    var createResult = await createRow(supabaseQuery);
    expect(createResult, null);
  });

  test("Testing Select Column Default Values for $tableName", () async {
    var selectResult = await readRow<T>(supabaseQuery, fromJson);

    expect(selectResult, isA<List<T>>());
    expect(selectResult!.length, 1);
    T selectedResult = selectResult[0];
    expect(selectedResult, isA<T>());

    InstanceMirror instanceMirror = reflect(selectedResult);
    ClassMirror classMirror = instanceMirror.type;

    classMirror.declarations.forEach((Symbol key, DeclarationMirror value) {
      if (value is VariableMirror && !value.isPrivate) {
        var name = MirrorSystem.getName(key);
        if (name == "id") return;

        var type = MirrorSystem.getName(value.type.simpleName);
        var propertyValue = instanceMirror.getField(key).reflectee;
        final expectThis = getDefaultValue(type);
        expect(propertyValue, expectThis,
            reason: "Default value mismatch for $name");
        print("✅ $name: $type = $propertyValue");
      }
    });
  });
}

dynamic getDefaultValue(String dartType) {
  switch (dartType) {
    case "int":
      return 0;
    case "BigInt":
      return BigInt.from(0);
    case "double":
      return 0.0;
    case "num":
      return 0;
    case "bool":
      return false;
    case "String":
      return "";
    case "DateTime":
      return DateTime.fromMillisecondsSinceEpoch(0);
    case "Duration":
      return Duration.zero;
    case "Map<String, dynamic>":
    case "Map":
      return {};
    case "List":
      return [];
    default:
      return null;
  }
}

Future<Object?> createRow(SupabaseQueryBuilder supabaseQuery) async {
  try {
    await supabaseQuery.insert({"id": uuidx});
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<T>?> readRow<T extends SupadartClass<T>>(
  SupabaseQueryBuilder supabaseQuery,
  T Function(Map<String, dynamic> data) fromJson,
) async {
  try {
    var selectResult = await supabaseQuery
        .select()
        .eq("id", uuidx)
        .withConverter((data) => data.map((e) => fromJson(e)).toList());
    return selectResult;
  } catch (error) {
    print("Error in readRow: $error");
    return null;
  }
}
