import 'enums.dart';
import 'package:yaml/yaml.dart';

import 'class.dart';
import 'client_extension.dart';
import 'dart_class.dart';
import 'imports.dart';
import 'models.dart';
import 'supadart_abstract_class.dart';
import 'swagger.dart';
import 'utils.dart';

class BluePrint {
  final List<String> imports;
  final List<DartClass> dartClasses;
  final String clientExtension;
  final String models;
  final String enums;

  BluePrint({
    required this.imports,
    required this.dartClasses,
    required this.clientExtension,
    required this.models,
    required this.enums,
  });
}

BluePrint generateBluePrint(
    DatabaseSwagger swagger, bool isDart, YamlMap? mappings) {
  final dartClasses = generateDartClasses(swagger, mappings);
  final imports = getImports(dartClasses, isDart, false);
  final clientExtension = generateClientExtension(swagger);
  final models = generateModels(swagger, mappings);
  final enums = generateEnums(swagger);

  return BluePrint(
    imports: imports,
    dartClasses: dartClasses,
    clientExtension: clientExtension,
    models: models,
    enums: enums,
  );
}

class GeneratedFile {
  final String fileName;
  final String fileContent;

  GeneratedFile({
    required this.fileName,
    required this.fileContent,
  });
}

List<GeneratedFile> generateClassesSingleFile(
    DatabaseSwagger swagger, bool isDart, YamlMap? mappings) {
  final blueprint = generateBluePrint(swagger, isDart, mappings);
  final clientExtension = blueprint.clientExtension;
  final enums = blueprint.enums;
  final dartClasses = blueprint.dartClasses;
  final imports = blueprint.imports;

  String code = "";

  code += imports.join("\n");
  code += "${clientExtension.toString()}\n\n";
  code += "$supadartAbstractClass\n\n";
  code += "$enums\n\n";
  code += dartClasses.map((c) => c.classCode).join("\n");

  return [GeneratedFile(fileName: "generated_classes.dart", fileContent: code)];
}

List<GeneratedFile> generateDartModelFilesSeparated(
    DatabaseSwagger swagger, bool isDart, YamlMap? mappings) {
  final blueprint = generateBluePrint(swagger, isDart, mappings);
  final dartClasses = blueprint.dartClasses;
  final clientExtension = blueprint.clientExtension;
  final models = blueprint.models;

  List<GeneratedFile> output = [];

  for (var i = 0; i < dartClasses.length; i++) {
    String code = "";
    final imports = getImports([dartClasses[i]], isDart, true);
    imports.replaceRange(1, 2, ["import 'supadart_abstract_class.dart';"]);

    code += imports.join("\n");
    code += dartClasses[i].classCode;

    // output[classNameToFileName(dartClasses[i].className)] = code;

    output.add(GeneratedFile(
      fileName: classNameToFileName(dartClasses[i].className),
      fileContent: code,
    ));
  }

  final supabaseSdkImport = isDart
      ? "import 'package:supabase/supabase.dart';"
      : "import 'package:supabase_flutter/supabase_flutter.dart';";

  output.add(GeneratedFile(
    fileName: "client_extension.dart",
    fileContent:
        "// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, unnecessary_null_comparison file_names\n$supabaseSdkImport\n$clientExtension",
  ));

  output.add(GeneratedFile(
    fileName: "supadart_abstract_class.dart",
    fileContent: supadartAbstractClass,
  ));

  output.add(GeneratedFile(
    fileName: "models.dart",
    fileContent: models,
  ));

  output.add(GeneratedFile(
    fileName: "generated_enums.dart",
    fileContent: blueprint.enums,
  ));

  return output;
}

List<GeneratedFile> generateModelFiles(
    DatabaseSwagger swagger, bool isDart, bool isSeparated, YamlMap? mappings) {
  return isSeparated
      ? generateDartModelFilesSeparated(swagger, isDart, mappings)
      : generateClassesSingleFile(swagger, isDart, mappings);
}
