import 'package:yaml/yaml.dart';

import 'class/class.dart';
import 'standalone/client_extension.dart';
import 'standalone/duration_fromstring.dart';
import 'standalone/enums.dart';
import 'standalone/geometry_fromjson.dart';
import 'standalone/exports.dart';
import 'standalone/supadart_abstract_class.dart';
import 'storage/storage.dart';
import 'swagger/column.dart';
import 'swagger/swagger.dart';
import 'utils/string_formatters.dart';

List<GeneratedFile> supadartRun(
    DatabaseSwagger swagger,
    Storage storageList,
    bool isDart,
    bool isSeparated,
    YamlMap? mappings,
    List<String> exclude,
    bool isPostGIS,
    bool jsonbToDynamic,
    {Map<String, JsonbModelConfig>? jsonbModels}) {
  _checkNameClashes(swagger, mappings);

  // Collect unique JSONB model imports
  Set<String> jsonbImports = {};
  if (jsonbModels != null) {
    for (var config in jsonbModels.values) {
      jsonbImports.add(config.importPath);
    }
  }

  final dartClasses =
      generateDartClasses(swagger, mappings, exclude, jsonbToDynamic);

  final clientExtension = generateClientExtension(swagger);
  final storageClientExtension = generateStorageClientExtension(storageList);
  final modelExports = generateExports(swagger, mappings);
  final enums = generateEnums({
    for (final e in swagger.enums.entries)
      swagger.schemas.localNameOf(e.key): e.value
  });

  bool needsIntl = false;
  bool needsDartConvert = false;
  bool needsDurationFromString = false;
  bool needsGeometryFromJson = false;
  for (var dartClass in dartClasses) {
    final classCode = dartClass.classCode;
    if (classCode.contains("DateFormat")) {
      needsIntl = true;
    }
    if (classCode.contains("json.") ||
        classCode.contains("jsonDecode") ||
        classCode.contains("jsonEncode")) {
      needsDartConvert = true;
    }
    if (classCode.contains("Duration")) {
      needsDurationFromString = true;
    }
    if (classCode.contains("GeometryFromJson")) {
      needsGeometryFromJson = true;
      needsDartConvert = true;
    }
    // Exit early if all conditions are met
    if (needsIntl &&
        needsDartConvert &&
        needsDurationFromString &&
        needsGeometryFromJson) {
      break;
    }
  }

  final supadartGenerator = SupadartGenerator(
    clientExtension: clientExtension,
    storageClientExtension: storageClientExtension,
    dartClasses: dartClasses,
    modelExports: modelExports,
    enums: enums,
    isDart: isDart,
    needsIntl: needsIntl,
    needsDartConvert: needsDartConvert,
    needsDurationFromString: needsDurationFromString,
    needsGeometryFromJson: needsGeometryFromJson,
    mappings: mappings,
    isPostGIS: isPostGIS,
    jsonbImports: jsonbImports,
  );
  return isSeparated
      ? supadartGenerator.generateDartModelFilesSeparated()
      : supadartGenerator.generateClassesSingleFile();
}

/// Thrown when two tables or enums would get the same Dart name.
class NameClashException implements Exception {
  final String message;

  NameClashException(this.message);

  @override
  String toString() => message;
}

void _checkNameClashes(DatabaseSwagger swagger, YamlMap? mappings) {
  final schemas = swagger.schemas;
  final clashes = <String>[];
  // Groups each source (`schema.name`) by the Dart name it would get.
  void check(String kind, Map<String, String> dartNames) {
    final sources = <String, List<String>>{};
    dartNames.forEach((source, name) {
      sources.putIfAbsent(name, () => []).add(source);
    });
    sources.forEach((name, from) {
      if (from.length > 1) clashes.add('$kind $name: ${from.join(', ')}');
    });
  }

  check('class', {
    for (final t in swagger.tables)
      t.qualifiedName: tableNameToClassName(t.schema, t.name, mappings, schemas)
  });
  check('client getter', {
    for (final t in swagger.tables)
      t.qualifiedName: schemas.localName(t.schema, t.name).toLowerCase()
  });
  check('enum', {
    for (final name in swagger.enums.keys)
      name: enumDartName(schemas.localNameOf(name))
  });

  if (clashes.isNotEmpty) {
    throw NameClashException(
        'These would get the same Dart name:\n  ${clashes.join('\n  ')}\n'
        'Rename a table with mappings in supadart.yaml '
        '(e.g. inventory.items: inventory_item), or change the order of '
        'schemas: only the first keeps unprefixed names.');
  }
}

class GeneratedFile {
  final String fileName;
  final String fileContent;

  GeneratedFile({
    required this.fileName,
    required this.fileContent,
  });
}

class SupadartGenerator {
  final String clientExtension;
  final String storageClientExtension;
  final List<DartClass> dartClasses;
  final String modelExports;
  final String enums;

  // Package imports
  final bool isDart;
  final bool needsIntl;
  final bool needsDartConvert;
  final bool isPostGIS;

  // Function Imports
  final bool needsDurationFromString;
  final bool needsGeometryFromJson;

  final YamlMap? mappings;

  // JSONB model imports
  final Set<String> jsonbImports;

  SupadartGenerator({
    required this.clientExtension,
    required this.storageClientExtension,
    required this.dartClasses,
    required this.modelExports,
    required this.enums,
    required this.isDart,
    required this.needsIntl,
    required this.needsDartConvert,
    required this.needsDurationFromString,
    required this.needsGeometryFromJson,
    required this.mappings,
    required this.isPostGIS,
    required this.jsonbImports,
  });

  List<GeneratedFile> generateClassesSingleFile() {
    String code = "";

    code += getSupadartHeader(true);
    code += dartClasses.map((c) => c.classCode).join("\n");

    return [
      GeneratedFile(fileName: "generated_classes.dart", fileContent: code)
    ];
  }

  List<GeneratedFile> generateDartModelFilesSeparated() {
    List<GeneratedFile> output = [];

    final buffer = StringBuffer()..writeln('''
// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, file_names, unnecessary_null_comparison, prefer_null_aware_operators
// WARNING: This code is auto-generated by Supadart.
// WARNING: Modifications may be overwritten. Please make changes in the Supadart configuration.
import 'supadart_header.dart';
''');

    output.addAll(dartClasses.map((dartClass) => GeneratedFile(
          fileName: classNameToFileName(dartClass.className),
          fileContent: '$buffer\n${dartClass.classCode}',
        )));

    output.add(GeneratedFile(
      fileName: "supadart_exports.dart",
      fileContent: modelExports,
    ));

    final supadartHeader = getSupadartHeader(false);
    output.add(GeneratedFile(
      fileName: "supadart_header.dart",
      fileContent: supadartHeader,
    ));

    return output;
  }

  String getSupadartHeader(
    bool isSingleFile,
  ) {
    final supadartImports = [
      "// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, file_names, unnecessary_null_comparison, prefer_null_aware_operators",
      "\n",
      "// WARNING: This code is auto-generated by Supadart.",
      "// WARNING: Modifications may be overwritten. Please make changes in the SupaDart configuration.",
      "\n",
      "// SDK",
      isDart
          ? "import 'package:supabase/supabase.dart';"
          : "import 'package:supabase_flutter/supabase_flutter.dart';",
      "\n",
      isPostGIS
          ? "${isSingleFile ? "import" : "export"} 'package:geobase/geobase.dart';"
          : "// No geobase needed",
      needsIntl
          ? """
          // INTL is an official package from Dart and is used for parsing dates
          // flutter pub add intl or dart pub add intl
          ${isSingleFile ? "import" : "export"} 'package:intl/intl.dart';
          """
          : "// No Intl package needed",
      needsDartConvert
          ? "${isSingleFile ? "import" : "export"} 'dart:convert';"
          : "// No Dart Convert needed",
      // JSONB model imports
      jsonbImports.isNotEmpty
          ? "// JSONB Model Imports\n${jsonbImports.map((imp) => "${isSingleFile ? "import" : "export"} '$imp';").join('\n')}"
          : "// No JSONB Model imports needed",
      "// Supadart Class",
      supadartAbstractClass,
      "\n",
      "// Supabase Client Extension",
      clientExtension,
      "\n",
      "// Supabase Storage Client Extension",
      storageClientExtension,
      "\n",
      "// Enums",
      enums,
      "// Utils",
      needsDurationFromString ? durationFromStringExtension : "",
      needsGeometryFromJson ? geometryFromJsonExtension : "",
    ];
    return supadartImports.join("\n");
  }
}
