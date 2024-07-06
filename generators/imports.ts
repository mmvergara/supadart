import { DartClass, Imports } from "./types";

export const getImports = (
  dartClasses: DartClass[],
  isFlutter: boolean
): Imports => {
  const generatedClasses = dartClasses.map((c) => c.classCode).join("\n");

  let imports = [
    "// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names",
  ];

  const supabaseSdkImport = isFlutter
    ? "import 'package:supabase_flutter/supabase_flutter.dart';"
    : "import 'package:supabase/supabase.dart';";
  imports.push(supabaseSdkImport);

  const DateFormatterPackage = "import 'package:intl/intl.dart';";
  if (generatedClasses.includes("DateFormat")) {
    imports.push(DateFormatterPackage);
    imports.push(
      "// This is an official package from dart and is used for parsing dates"
    );
    imports.push("// flutter pub add intl or dart pub add intl");
  }

  return imports;
};
