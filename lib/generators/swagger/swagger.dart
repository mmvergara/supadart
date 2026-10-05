import 'column.dart';
import 'table.dart';

class DatabaseSwagger {
  final Map<String, Table> definitions;

  /// Values of each enum in the public schema, keyed by type name and sorted
  /// by it. Values read from the schema take precedence over the config.
  final Map<String, List<String>> enums;

  /// Problems with the enum config worth telling the user about.
  final List<String> warnings;

  DatabaseSwagger(this.definitions,
      {this.enums = const {}, this.warnings = const []});

  /// Parses the PostgREST schema. [configEnums] are the enums from
  /// supadart.yaml, keyed by type name with or without a `public.` prefix.
  factory DatabaseSwagger.fromJson(Map<String, dynamic> json,
      Map<String, List<String>> configEnums, bool jsonbToDynamic,
      {Map<String, JsonbModelConfig>? jsonbModels}) {
    final definitions = json['definitions'] as Map<String, dynamic>;

    final configured = {
      for (final e in configEnums.entries)
        if (e.value.isNotEmpty) publicTypeName(_qualify(e.key))!: e.value
    };
    // PostgREST includes the values of enum columns, but not enum arrays.
    final fromSchema = <String, List<String>>{};
    for (final table in definitions.values) {
      for (final column in (table['properties'] as Map).values) {
        final typeName = publicTypeName(column['format']);
        if (typeName != null && column['enum'] != null) {
          fromSchema[typeName] = List<String>.from(column['enum']);
        }
      }
    }
    final merged = {...configured, ...fromSchema};
    final enums = {
      for (final name in merged.keys.toList()..sort()) name: merged[name]!
    };

    final tables = definitions.map((key, value) => MapEntry(
        key,
        Table.fromJson(key, value, enums, jsonbToDynamic,
            jsonbModels: jsonbModels)));

    return DatabaseSwagger(tables, enums: enums, warnings: [
      ..._configMismatches(configured, fromSchema),
      ..._unresolvedTypes(tables),
    ]);
  }
}

String _qualify(String typeName) =>
    typeName.startsWith('public.') ? typeName : 'public.$typeName';

Iterable<String> _configMismatches(Map<String, List<String>> configured,
    Map<String, List<String>> fromSchema) sync* {
  for (final name in configured.keys) {
    final schemaValues = fromSchema[name];
    if (schemaValues != null &&
        schemaValues.join('\u0000') != configured[name]!.join('\u0000')) {
      yield 'supadart.yaml lists $name as ${configured[name]}, but the '
          'database has $schemaValues. Using the database values.';
    }
  }
}

Iterable<String> _unresolvedTypes(Map<String, Table> tables) sync* {
  final usages = <String, List<String>>{};
  tables.forEach((tableName, table) {
    for (final column in table.columns.values) {
      if (column.isUnresolvedUserType) {
        usages
            .putIfAbsent(publicTypeName(column.postgresFormat)!, () => [])
            .add('$tableName.${column.dbColName}');
      }
    }
  });
  for (final MapEntry(key: name, value: columns) in usages.entries) {
    yield 'No values found for type $name (used by ${columns.join(', ')}), '
        'so it is generated as String. The schema only lists enum values for '
        'non-array columns. If $name is an enum, add it to supadart.yaml:\n'
        '  enums:\n'
        '    $name: [...]\n'
        'You can list its values with: '
        'SELECT unnest(enum_range(NULL::public."$name"));';
  }
}
