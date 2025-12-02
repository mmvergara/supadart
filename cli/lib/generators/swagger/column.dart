// Class to represent a database column
import '../utils/string_formatters.dart';
import 'utils.dart';

/// Configuration for mapping a JSONB column to a custom Dart model
class JsonbModelConfig {
  final String schema;
  final String tableName;
  final String columnName;
  final String dartType;
  final String importPath;
  final bool isArray;

  JsonbModelConfig({
    required this.schema,
    required this.tableName,
    required this.columnName,
    required this.dartType,
    required this.importPath,
    this.isArray = false,
  });

  /// Returns the lookup key for this config (schema.table.column)
  String get lookupKey => '$schema.$tableName.$columnName';
}

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
  final JsonbModelConfig? jsonbModelConfig;

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
    this.jsonbModelConfig,
  });

  /// Returns true if this column is a JSONB with a custom typed model
  bool get isTypedJsonb => jsonbModelConfig != null;

  String get dartType {
    // Check for typed JSONB model first
    if (isTypedJsonb) {
      final isArrayType =
          jsonbModelConfig!.isArray || postgresFormat.contains('[]');
      if (isArrayType) {
        return 'List<${jsonbModelConfig!.dartType}>';
      }
      return jsonbModelConfig!.dartType;
    }

    if (postgresFormat.contains("public.")) {
      if (postgresFormat.contains("vector") ||
          postgresFormat.contains("VECTOR")) {
        return "String";
      }
      if (postgresFormat.contains("geometry") ||
          postgresFormat.contains("geography")) {
        return postgresFormatToDartType(postgresFormat, jsonbToDynamic);
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
      {bool jsonbToDynamic = false,
      String? schema,
      String? tableName,
      Map<String, JsonbModelConfig>? jsonbModels}) {
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

    // Look up JSONB model config if available
    JsonbModelConfig? jsonbConfig;
    if (jsonbModels != null && schema != null && tableName != null) {
      final lookupKey = '$schema.$tableName.$colName';
      jsonbConfig = jsonbModels[lookupKey];
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
      jsonbModelConfig: jsonbConfig,
    );
  }
}
