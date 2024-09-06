import '../class/class.dart';

List<String> getImports(
    List<DartClass> dartClasses, bool isDart, bool isSingleFile) {
  final generatedClasses = dartClasses.map((c) => c.classCode).join("\n");

  List<String> imports = [
    "// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison",
  ];

  final supabaseSdkImport = isDart
      ? "import 'package:supabase/supabase.dart';"
      : "import 'package:supabase_flutter/supabase_flutter.dart';";
  imports.add(supabaseSdkImport);

  final jsonEncoderImport = "import 'dart:convert';";
  if (generatedClasses.contains("jsonEncode") ||
      generatedClasses.contains("json.decode")) {
    imports.add(jsonEncoderImport);
  }

  final enumsImport = "import 'generated_enums.dart';";
  if (isSingleFile && generatedClasses.contains("[supadart:has_enums]")) {
    imports.add(enumsImport);
  }

  final dateFormatterPackage = "import 'package:intl/intl.dart';";
  if (generatedClasses.contains("DateFormat")) {
    imports.add(dateFormatterPackage);
    imports.add(
        "// INTL is an official package from Dart and is used for parsing dates");
    imports.add("// flutter pub add intl or dart pub add intl");
  }
  imports.add("// THIS FILE IS AUTO GENERATED. MODIFY WITH CAUTION");
  imports.add("");

  return imports;
}
