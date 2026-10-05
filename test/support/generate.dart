import 'dart:convert';
import 'dart:io';

import 'package:supadart/generators/index.dart';
import 'package:supadart/generators/storage/storage.dart';
import 'package:supadart/generators/swagger/column.dart';
import 'package:supadart/generators/swagger/swagger.dart';
import 'package:yaml/yaml.dart';

import '../../bin/supadart.dart' show generateAndFormatFiles;

const swaggerFixturePath = 'test/fixtures/swagger.json';
const storageFixturePath = 'test/fixtures/storage.json';

/// The swagger fixture of each schema in supabase/migrations.
const swaggerFixturePaths = {
  'public': swaggerFixturePath,
  'inventory': 'test/fixtures/swagger_inventory.json',
};

/// Enums the schema does not list values for: those used only in arrays.
/// Every other enum is read from the schema.
const testEnums = {
  'usergroup': ['USERS', 'ADMIN', 'MODERATOR'],
};

/// A generator configuration whose output is checked in as a golden.
class GoldenConfig {
  final String name;
  final String goldenDir;
  final bool isDart;
  final bool isSeparated;
  final List<String> schemas;

  const GoldenConfig(this.name, this.goldenDir,
      {required this.isDart,
      required this.isSeparated,
      this.schemas = const ['public']});
}

const goldenConfigs = [
  // Also the models the integration round-trip tests compile against.
  GoldenConfig('dart single file', 'test/models/',
      isDart: true, isSeparated: false, schemas: ['public', 'inventory']),
  GoldenConfig('flutter separated', 'test/goldens/flutter_separated/',
      isDart: false, isSeparated: true),
];

Map<String, dynamic> readJsonFixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

/// The swagger fixtures of [schemas], keyed by schema.
Map<String, Map<String, dynamic>> readSchemaFixtures(List<String> schemas) =>
    {for (final s in schemas) s: readJsonFixture(swaggerFixturePaths[s]!)};

Storage readStorageFixture() => Storage.fromJson(
    jsonDecode(File(storageFixturePath).readAsStringSync()) as List<dynamic>);

/// The swagger fixture plus a table of PostGIS columns, which the local test
/// schema does not have.
Map<String, dynamic> swaggerWithPostGIS() {
  final json = readJsonFixture(swaggerFixturePath);
  (json['definitions'] as Map<String, dynamic>)['places'] = {
    'required': ['id', 'location'],
    'properties': {
      'id': {
        'format': 'uuid',
        'description': 'Note:\nThis is a Primary Key.<pk/>',
      },
      'location': {'format': 'extensions.geometry(Point,4326)'},
      'area': {'format': 'extensions.geography'},
      'route': {'format': 'extensions.geometry[]'},
    },
  };
  return json;
}

/// Runs the generator on [swaggerJson] (by default the fixtures of
/// [schemas]) with the given options, keyed by file name. Output is not
/// formatted.
Map<String, String> generateWith({
  Map<String, dynamic>? swaggerJson,
  List<String> schemas = const ['public'],
  bool isDart = true,
  bool isSeparated = false,
  String? mappings,
  List<String> exclude = const [],
  bool isPostGIS = false,
  bool jsonbToDynamic = false,
  Map<String, JsonbModelConfig>? jsonbModels,
  Map<String, List<String>> enums = testEnums,
}) {
  final swagger = DatabaseSwagger.fromSchemas(
      swaggerJson == null
          ? readSchemaFixtures(schemas)
          : {'public': swaggerJson},
      enums,
      jsonbToDynamic,
      jsonbModels: jsonbModels);
  final files = supadartRun(
      swagger,
      readStorageFixture(),
      isDart,
      isSeparated,
      mappings == null ? null : loadYaml(mappings) as YamlMap,
      exclude,
      isPostGIS,
      jsonbToDynamic,
      jsonbModels: jsonbModels);
  return {for (final f in files) f.fileName: f.fileContent};
}

/// Runs the generator on the fixtures and returns formatted output keyed by
/// file name. Output is written under .dart_tool so `dart format` uses this
/// package's language version, matching the checked-in goldens.
Future<Map<String, String>> generateFromFixtures(GoldenConfig config) async {
  final swagger = DatabaseSwagger.fromSchemas(
      readSchemaFixtures(config.schemas), testEnums, false);
  final files = supadartRun(swagger, readStorageFixture(), config.isDart,
      config.isSeparated, null, [], false, false);

  final outDir = (Directory('.dart_tool/supadart_golden/')
        ..createSync(recursive: true))
      .createTempSync('${config.name.replaceAll(' ', '_')}_');
  try {
    await generateAndFormatFiles(files, '${outDir.path}/');
    return {
      for (final f in files)
        f.fileName: File('${outDir.path}/${f.fileName}').readAsStringSync(),
    };
  } finally {
    outDir.deleteSync(recursive: true);
  }
}
