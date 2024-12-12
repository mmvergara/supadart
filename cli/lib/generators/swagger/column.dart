// Class to represent a database column
import '../utils/string_formatters.dart';
import 'utils.dart';

class Column {
  final String postgresFormat;
  final String dbColName;
  final String camelColName;
  final List<String> enumValues;
  final dynamic hasDefaultValue;
  final String? description;
  final int? maxLength;
  final bool isPrimaryKey;
  final bool isSerialType;
  final bool isInRequiredColumn;

  Column({
    required this.postgresFormat,
    required this.dbColName,
    required this.camelColName,
    required this.enumValues,
    this.hasDefaultValue,
    this.description,
    this.maxLength,
    this.isPrimaryKey = false,
    this.isSerialType = false,
    this.isInRequiredColumn = false,
  });

  String get dartType {
    if (enumValues.isNotEmpty) {
      if (postgresFormat.contains("[]")) {
        return "List<${postgresFormat.split(".").last.toUpperCase().replaceAll('"', "").replaceAll("[]", "")}>";
      } else {
        return postgresFormat.split(".").last.toUpperCase().replaceAll('"', "");
      }
    }
    return postgresFormatToDartType(postgresFormat).type.replaceAll('"', "");
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

  factory Column.fromJson(
    String colName,
    Map<String, dynamic> json,
    List<String> parentTableRequiredFields,
    Map<String, List<String>> mapOfEnums,
  ) {
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
    );
  }
}
