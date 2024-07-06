import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'dart:mirrors';
import 'utils.dart';

Future<void> performTypeDefaultValuesTest<T extends SupadartClass<T>>(
  SupabaseClient supabase,
  SupabaseQueryBuilder supabaseQuery,
  T Function(Map<String, dynamic> data) fromJson,
) async {
  test('Testing Create Empty Numeric Row', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createRow(supabase.numeric_types);
    expect(createResult, null);
  });

  test("Testing Select Column Default Values", () async {
    var selectResult = await readRow<T>(supabase.numeric_types, fromJson);
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
        expect(getDefaultValue(type), propertyValue);
        print("✅ $name: $type = $propertyValue");
      }
    });
  });
}

dynamic getDefaultValue(
  String dartType,
) {
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
      return ""; // Empty string as default
    case "DateTime":
      return DateTime.fromMillisecondsSinceEpoch(
          0); // Using Unix epoch as default
    case "Duration":
      return Duration(); // Assuming duration in milliseconds
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
    await supabaseQuery.insert({
      "id": uuidx,
    });
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
        .select("id")
        .eq("id", uuidx)
        .withConverter((data) => data.map((e) => fromJson(e)).toList());
    return selectResult;
  } catch (error) {
    print(error);
    print(error);
    print(error);
    print(error);
    return null;
  }
}
