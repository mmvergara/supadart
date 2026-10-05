// Class to represent a database column
import '../standalone/enums.dart';
import '../utils/string_formatters.dart';
import 'schemas.dart';
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

  /// `schema.type` when the column holds a user-defined type, else null.
  final String? userType;

  /// The Dart name of [userType], e.g. `MOOD` or `INVENTORY_MOOD`.
  final String? userTypeDartName;
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
    required this.jsonbToDynamic,
    this.userType,
    this.userTypeDartName,
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

  bool get isEnum => enumValues.isNotEmpty;

  bool get isArray => postgresFormat.endsWith('[]');

  /// The Dart enum this column holds, or its element type for an array.
  String get enumDartType => userTypeDartName!;

  bool get _isVector =>
      postgresFormat.contains("vector") || postgresFormat.contains("VECTOR");

  bool get _isPostGIS =>
      postgresFormat.contains("geometry") ||
      postgresFormat.contains("geography");

  /// True for a user-defined type in a generated schema with no known enum
  /// values (an enum used only in array columns, a domain, a composite type,
  /// or an extension type such as citext). These are mapped to String.
  bool get isUnresolvedUserType =>
      userType != null && !isEnum && !_isVector && !_isPostGIS;

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

    if (isEnum) {
      return isArray ? 'List<$enumDartType>' : enumDartType;
    }
    if (postgresFormat.contains("public.") && _isVector) {
      return "String";
    }
    return postgresFormatToDartType(postgresFormat, jsonbToDynamic);
  }

  /// [dartType] made nullable. `dynamic` already admits null, so it is left
  /// as is rather than emitting the redundant `dynamic?`.
  String get nullableDartType =>
      dartType == 'dynamic' ? dartType : '$dartType?';

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

  factory Column.fromJson(String colName, Map<String, dynamic> json,
      List<String> parentTableRequiredFields, Map<String, List<String>> enums,
      {bool jsonbToDynamic = false,
      Schemas schemas = Schemas.defaults,
      String? schema,
      String? tableName,
      Map<String, JsonbModelConfig>? jsonbModels}) {
    // PostgREST lists enum values on single-value columns only; array
    // columns rely on [enums], keyed by `schema.type`.
    final typeName = schemas.userTypeName(json['format']);
    final enumValues = typeName == null
        ? <String>[]
        : json['enum'] != null
            ? List<String>.from(json['enum'])
            : enums[typeName] ?? <String>[];

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
      userType: typeName,
      userTypeDartName:
          typeName == null ? null : enumDartName(schemas.localNameOf(typeName)),
      hasDefaultValue: json['description']?.contains('[supadart:serial]') ??
          json['default'] != null,
      description: json['description'],
      maxLength: json['maxLength'],
      isPrimaryKey: json['description']?.contains('<pk/>') ?? false,
      isSerialType: json['description']?.contains('[supadart:serial]') ?? false,
      isInRequiredColumn: parentTableRequiredFields.contains(colName),
      jsonbToDynamic: jsonbToDynamic,
      jsonbModelConfig: jsonbConfig,
    );
  }
}
