// Class to represent a database table
import 'column.dart';
import '../utils/string_formatters.dart';

class Table {
  final String name;
  final List<String> requiredFields;
  final Map<String, Column> columns;

  Table({
    required this.name,
    required this.requiredFields,
    required this.columns,
  });

  factory Table.fromJson(
      String name,
      Map<String, dynamic> json,
      Map<String, List<String>> mapOfEnums,
      bool jsonbToDynamic,
      {Map<String, JsonbModelConfig>? jsonbModels}) {
    final properties = json['properties'] as Map<String, dynamic>;
    final requiredFields = json['required'] != null
        ? List<String>.from(json['required'])
        : <String>[];

    return Table(
      name: name,
      requiredFields: requiredFields,
      columns: properties.map((key, value) => MapEntry(
          snakeCasingToCamelCasing(key),
          Column.fromJson(key, value, requiredFields, mapOfEnums,
              jsonbToDynamic: jsonbToDynamic,
              schema: 'public',
              tableName: name,
              jsonbModels: jsonbModels))),
    );
  }
}
