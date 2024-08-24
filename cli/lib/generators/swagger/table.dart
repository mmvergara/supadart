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

  factory Table.fromJson(String name, Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;
    return Table(
      name: name,
      requiredFields: json['required'] != null
          ? List<String>.from(json['required'])
          : <String>[],
      columns: properties.map((key, value) =>
          MapEntry(snakeCasingToCamelCasing(key), Column.fromJson(value, key))),
    );
  }
}
