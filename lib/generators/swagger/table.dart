// Class to represent a database table
import 'column.dart';
import 'schemas.dart';
import '../utils/string_formatters.dart';

class Table {
  final String schema;
  final String name;
  final List<String> requiredFields;
  final Map<String, Column> columns;

  Table({
    this.schema = 'public',
    required this.name,
    required this.requiredFields,
    required this.columns,
  });

  /// `schema.name`.
  String get qualifiedName => '$schema.$name';

  factory Table.fromJson(String name, Map<String, dynamic> json,
      Map<String, List<String>> mapOfEnums, bool jsonbToDynamic,
      {String schema = 'public',
      Schemas schemas = Schemas.defaults,
      Map<String, JsonbModelConfig>? jsonbModels}) {
    final properties = json['properties'] as Map<String, dynamic>;
    final requiredFields = json['required'] != null
        ? List<String>.from(json['required'])
        : <String>[];

    return Table(
      schema: schema,
      name: name,
      requiredFields: requiredFields,
      columns: properties.map((key, value) => MapEntry(
          snakeCasingToCamelCasing(key),
          Column.fromJson(key, value, requiredFields, mapOfEnums,
              jsonbToDynamic: jsonbToDynamic,
              schemas: schemas,
              schema: schema,
              tableName: name,
              jsonbModels: jsonbModels))),
    );
  }
}
