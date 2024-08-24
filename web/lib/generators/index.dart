import 'package:yaml/yaml.dart';

import 'swagger/swagger.dart';
import 'standalone/exports.dart';
import 'standalone/enums.dart';
import 'standalone/client_extension.dart';
import 'standalone/supadart_abstract_class.dart';
import 'utils/get_imports.dart';
import 'utils/string_formatters.dart';
import 'class/class.dart';

List<GeneratedFile> supadartRun(
  DatabaseSwagger swagger,
  bool isDart,
  bool isSeparated,
  YamlMap? mappings,
) {
  final dartClasses = generateDartClasses(swagger, mappings);
  final imports = getImports(dartClasses, isDart, false);
  final clientExtension = generateClientExtension(swagger);
  final models = generateExports(swagger, mappings);
  final enums = generateEnums(swagger);

  final supadartGenerator = SupadartGenerator(
    clientExtension: clientExtension,
    supadartAbstractClass: supadartAbstractClass,
    imports: imports,
    dartClasses: dartClasses,
    exports: models,
    enums: enums,
    isDart: isDart,
    mappings: mappings,
  );

  return isSeparated
      ? supadartGenerator.generateDartModelFilesSeparated()
      : supadartGenerator.generateClassesSingleFile();
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
  final String supadartAbstractClass;
  final List<String> imports;
  final List<DartClass> dartClasses;
  final String exports;
  final String enums;

  final bool isDart;
  final YamlMap? mappings;

  SupadartGenerator({
    required this.clientExtension,
    required this.supadartAbstractClass,
    required this.imports,
    required this.dartClasses,
    required this.exports,
    required this.enums,
    required this.isDart,
    required this.mappings,
  });

  List<GeneratedFile> generateClassesSingleFile() {
    String code = "";
    code += imports.join("\n");
    code += "${clientExtension.toString()}\n\n";
    code += "$supadartAbstractClass\n\n";
    code += "$enums\n\n";
    code += dartClasses.map((c) => c.classCode).join("\n");

    return [
      GeneratedFile(fileName: "generated_classes.dart", fileContent: code)
    ];
  }

  List<GeneratedFile> generateDartModelFilesSeparated() {
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
      fileContent: exports,
    ));

    output.add(GeneratedFile(
      fileName: "generated_enums.dart",
      fileContent: enums,
    ));

    return output;
  }
}
