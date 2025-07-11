// Class to represent a database column
import '../utils/string_formatters.dart';
import 'utils.dart';

class Column {
  final String postgresFormat;
  final String dbColName;
  final String camelColName;
  final List<String> enumValues;
  final bool isEnum;
  final dynamic hasDefaultValue;
  final String? description;
  final int? maxLength;
  final bool isPrimaryKey;
  final bool isSerialType;
  final bool isInRequiredColumn;
  final bool jsonbToDynamic;

  Column({
    required this.postgresFormat,
    required this.dbColName,
    required this.camelColName,
    required this.enumValues,
    required this.isEnum,
    required this.jsonbToDynamic,
    this.hasDefaultValue,
    this.description,
    this.maxLength,
    this.isPrimaryKey = false,
    this.isSerialType = false,
    this.isInRequiredColumn = false,
  });

  String get dartType {
    if (postgresFormat.contains("public.")) {
      if (postgresFormat.contains("vector") ||
          postgresFormat.contains("VECTOR")) {
        return "String";
      }
      if (postgresFormat.contains("[]")) {
        return "List<${postgresFormat.split(".").last.toUpperCase().replaceAll('"', "").replaceAll("[]", "")}>";
      } else {
        return postgresFormat.split(".").last.toUpperCase().replaceAll('"', "");
      }
    }
    return postgresFormatToDartType(postgresFormat, jsonbToDynamic);
  }

  bool get isRequiredInInsert {
    return isInRequiredColumn && !hasDefaultValue;
  }

  bool get isRequired {
    return isInRequiredColumn &&
        !!!hasDefaultValue &&
        !isPrimaryKey &&
        !isSerialType;
  }

  bool get isNullable {
    return !isInRequiredColumn;
  }

  factory Column.fromJson(
      String colName,
      Map<String, dynamic> json,
      List<String> parentTableRequiredFields,
      Map<String, List<String>> mapOfEnums,
      {bool jsonbToDynamic = false}) {
    List<String> enumValues =
        json['enum'] != null ? List<String>.from(json['enum']) : <String>[];
    if (json['format'].toString().contains("public.")) {
      for (var enumName in mapOfEnums.keys) {
        if (json['format'].toString().contains(enumName)) {
          enumValues = mapOfEnums[enumName]!;
          // print("enumValues set for ${json['format']} to $enumValues");
        }
      }
    }

    return Column(
      postgresFormat: json['format'],
      dbColName: colName,
      camelColName: snakeCasingToCamelCasing(colName),
      enumValues: enumValues,
      hasDefaultValue: json['description']?.contains('[supadart:serial]') ??
          json['default'] != null,
      description: json['description'],
      maxLength: json['maxLength'],
      isPrimaryKey: json['description']?.contains('<pk/>') ?? false,
      isSerialType: json['description']?.contains('[supadart:serial]') ?? false,
      isInRequiredColumn: parentTableRequiredFields.contains(colName),
      isEnum: json['enum'] != null || enumValues.isNotEmpty,
      jsonbToDynamic: jsonbToDynamic,
    );
  }
}
