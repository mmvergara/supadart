import 'column.dart';
import 'schemas.dart';
import 'table.dart';

class DatabaseSwagger {
  /// Tables and views of every schema, in schema order.
  final List<Table> tables;

  final Schemas schemas;

  /// Values of each enum, keyed by `schema.type` and sorted by it. Values
  /// read from the schema take precedence over the config.
  final Map<String, List<String>> enums;

  /// Problems with the enum config worth telling the user about.
  final List<String> warnings;

  DatabaseSwagger(this.tables,
      {this.schemas = Schemas.defaults,
      this.enums = const {},
      this.warnings = const []});

  /// Parses the PostgREST schema of `public`. See [DatabaseSwagger.fromSchemas].
  factory DatabaseSwagger.fromJson(Map<String, dynamic> json,
          Map<String, List<String>> configEnums, bool jsonbToDynamic,
          {Map<String, JsonbModelConfig>? jsonbModels}) =>
      DatabaseSwagger.fromSchemas({'public': json}, configEnums, jsonbToDynamic,
          jsonbModels: jsonbModels);

  /// Parses the PostgREST schema of each database schema in [specs], keyed by
  /// schema name. The first is the primary schema. [configEnums] are the
  /// enums from supadart.yaml, keyed by type name, which is taken to be in the
  /// primary schema unless qualified (`inventory.status`).
  factory DatabaseSwagger.fromSchemas(Map<String, Map<String, dynamic>> specs,
      Map<String, List<String>> configEnums, bool jsonbToDynamic,
      {Map<String, JsonbModelConfig>? jsonbModels}) {
    final schemas = Schemas(specs.keys.toList());

    final configured = {
      for (final e in configEnums.entries)
        if (e.value.isNotEmpty) schemas.qualify(e.key): e.value
    };
    // PostgREST includes the values of enum columns, but not enum arrays.
    final fromSchema = <String, List<String>>{};
    for (final spec in specs.values) {
      for (final table in (spec['definitions'] as Map).values) {
        for (final column in (table['properties'] as Map).values) {
          final typeName = schemas.userTypeName(column['format']);
          if (typeName != null && column['enum'] != null) {
            fromSchema[typeName] = List<String>.from(column['enum']);
          }
        }
      }
    }
    final merged = {...configured, ...fromSchema};
    final enums = {
      for (final name in merged.keys.toList()..sort()) name: merged[name]!
    };

    final tables = [
      for (final MapEntry(key: schema, value: spec) in specs.entries)
        for (final MapEntry(key: name, value: json)
            in (spec['definitions'] as Map<String, dynamic>).entries)
          Table.fromJson(name, json, enums, jsonbToDynamic,
              schema: schema, schemas: schemas, jsonbModels: jsonbModels),
    ];

    return DatabaseSwagger(tables, schemas: schemas, enums: enums, warnings: [
      ..._configMismatches(configured, fromSchema, schemas),
      ..._unresolvedTypes(tables, schemas),
    ]);
  }
}

Iterable<String> _configMismatches(Map<String, List<String>> configured,
    Map<String, List<String>> fromSchema, Schemas schemas) sync* {
  for (final name in configured.keys) {
    final schemaValues = fromSchema[name];
    if (schemaValues != null &&
        schemaValues.join('\u0000') != configured[name]!.join('\u0000')) {
      yield 'supadart.yaml lists ${schemas.configName(name)} as ${configured[name]}, but the '
          'database has $schemaValues. Using the database values.';
    }
  }
}

Iterable<String> _unresolvedTypes(List<Table> tables, Schemas schemas) sync* {
  final usages = <String, List<String>>{};
  for (final table in tables) {
    for (final column in table.columns.values) {
      if (column.isUnresolvedUserType) {
        usages
            .putIfAbsent(column.userType!, () => [])
            .add('${table.qualifiedName}.${column.dbColName}');
      }
    }
  }
  for (final MapEntry(key: name, value: columns) in usages.entries) {
    final (schema, type) = Schemas.split(name);
    yield 'No values found for type $name (used by ${columns.join(', ')}), '
        'so it is generated as String. The schema only lists enum values for '
        'non-array columns. If $name is an enum, add it to supadart.yaml:\n'
        '  enums:\n'
        '    ${schemas.configName(name)}: [...]\n'
        'You can list its values with: '
        'SELECT unnest(enum_range(NULL::$schema."$type"));';
  }
}
