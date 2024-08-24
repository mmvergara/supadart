// Class to represent a database column
import '../utils/string_formatters.dart';

import 'utils.dart';

class Column {
  final String postgresFormat;
  final String dbColName;
  final String camelColName;
  final List<String> enumValues;
  final dynamic defaultValue;
  final String? description;
  final int? maxLength;
  final bool isPrimaryKey;
  final bool isSerialType;

  Column({
    required this.postgresFormat,
    required this.dbColName,
    required this.camelColName,
    this.enumValues = const [],
    this.defaultValue,
    this.description,
    this.maxLength,
    this.isPrimaryKey = false,
    this.isSerialType = false,
  });

  String get dartType {
    if (enumValues.isNotEmpty) {
      return postgresFormat.split(".").last.toUpperCase().replaceAll('"', "");
    }
    return postgresFormatToDartType(postgresFormat).type.replaceAll('"', "");
  }

  bool get hasDefaultValue => defaultValue != null;

  factory Column.fromJson(Map<String, dynamic> json, String colName) {
    return Column(
      postgresFormat: json['format'],
      dbColName: colName,
      camelColName: snakeCasingToCamelCasing(colName),
      enumValues:
          json['enum'] != null ? List<String>.from(json['enum']) : <String>[],
      defaultValue: json['default'],
      description: json['description'],
      maxLength: json['maxLength'],
      isPrimaryKey: json['description']?.contains('<pk/>') ?? false,
      isSerialType: json['description']?.contains('[supadart:serial]') ?? false,
    );
  }
}
