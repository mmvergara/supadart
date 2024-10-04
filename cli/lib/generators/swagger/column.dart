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
    this.enumValues = const [],
    this.hasDefaultValue,
    this.description,
    this.maxLength,
    this.isPrimaryKey = false,
    this.isSerialType = false,
    this.isInRequiredColumn = false,
  });

  String get dartType {
    if (enumValues.isNotEmpty) {
      return postgresFormat.split(".").last.toUpperCase().replaceAll('"', "");
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
  ) {
    return Column(
      postgresFormat: json['format'],
      dbColName: colName,
      camelColName: snakeCasingToCamelCasing(colName),
      enumValues:
          json['enum'] != null ? List<String>.from(json['enum']) : <String>[],
      hasDefaultValue: json['default'] != null,
      description: json['description'],
      maxLength: json['maxLength'],
      isPrimaryKey: json['description']?.contains('<pk/>') ?? false,
      isSerialType: json['description']?.contains('[supadart:serial]') ?? false,
      isInRequiredColumn: parentTableRequiredFields.contains(colName),
    );
  }
}
