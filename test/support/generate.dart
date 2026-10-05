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

const testEnums = {
  'mood': ['happy', 'sad', 'neutral', 'excited', 'angry'],
  'usergroup': ['USERS', 'ADMIN', 'MODERATOR'],
};

/// A generator configuration whose output is checked in as a golden.
class GoldenConfig {
  final String name;
  final String goldenDir;
  final bool isDart;
  final bool isSeparated;

  const GoldenConfig(this.name, this.goldenDir,
      {required this.isDart, required this.isSeparated});
}

const goldenConfigs = [
  // Also the models the integration round-trip tests compile against.
  GoldenConfig('dart single file', 'test/models/',
      isDart: true, isSeparated: false),
  GoldenConfig('flutter separated', 'test/goldens/flutter_separated/',
      isDart: false, isSeparated: true),
];

Map<String, dynamic> readJsonFixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

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

/// Runs the generator on [swaggerJson] (the swagger fixture by default) with
/// the given options, keyed by file name. Output is not formatted.
Map<String, String> generateWith({
  Map<String, dynamic>? swaggerJson,
  bool isDart = true,
  bool isSeparated = false,
  String? mappings,
  List<String> exclude = const [],
  bool isPostGIS = false,
  bool jsonbToDynamic = false,
  Map<String, JsonbModelConfig>? jsonbModels,
}) {
  final swagger = DatabaseSwagger.fromJson(
      swaggerJson ?? readJsonFixture(swaggerFixturePath),
      testEnums,
      jsonbToDynamic,
      jsonbModels: jsonbModels);
  final files = supadartRun(
      swagger,
      readStorageFixture(),
      isDart,
      isSeparated,
      mappings == null ? null : loadYaml(mappings) as YamlMap,
      exclude,
      testEnums,
      isPostGIS,
      jsonbToDynamic,
      jsonbModels: jsonbModels);
  return {for (final f in files) f.fileName: f.fileContent};
}

/// Runs the generator on the fixtures and returns formatted output keyed by
/// file name. Output is written under .dart_tool so `dart format` uses this
/// package's language version, matching the checked-in goldens.
Future<Map<String, String>> generateFromFixtures(GoldenConfig config) async {
  final swagger = DatabaseSwagger.fromJson(
      readJsonFixture(swaggerFixturePath), testEnums, false);
  final files = supadartRun(swagger, readStorageFixture(), config.isDart,
      config.isSeparated, null, [], testEnums, false, false);

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
