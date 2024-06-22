import { generateDartClasses } from "./Class";
import { generateClientExtension } from "./ClientExtension";
import {
  ClientExtension,
  DartClass,
  Definitions,
  Imports,
  SupabaseSDKImport,
} from "./types";
import { generateDartFileName } from "./utils";

export const generateClassesAndClient = (
  definitions: Definitions,
  isDart: boolean
) => {
  const imports: Imports = [
    "// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names",
    "import 'package:intl/intl.dart';",
  ];

  const supabaseSdkImport: SupabaseSDKImport = isDart
    ? "import 'package:supabase/supabase.dart';"
    : "import 'package:supabase_flutter/supabase_flutter.dart';";

  const dartClasses: DartClass[] = generateDartClasses(definitions);
  const clientExtension: ClientExtension = generateClientExtension(definitions);
  return {
    imports,
    supabaseSdkImport,
    dartClasses,
    clientExtension,
  };
};

export const generateDartModelFile = (
  definitions: Definitions,
  isDart: boolean
) => {
  const { clientExtension, dartClasses, imports, supabaseSdkImport } =
    generateClassesAndClient(definitions, isDart);

  let code = "";
  imports.forEach((i) => (code += i + "\n"));
  code += supabaseSdkImport + "\n\n";
  code += clientExtension + "\n\n";
  code += dartClasses.map((c) => c.classCode).join("\n");

  return code;
};

export const generateDartModelFilesSeperated = (
  definitions: Definitions,
  isDart: boolean
): Record<string, string> => {
  const { clientExtension, dartClasses, imports, supabaseSdkImport } =
    generateClassesAndClient(definitions, isDart);

  const importString = imports.join("\n") + "\n";
  const output: Record<string, string> = {};

  dartClasses.forEach(({ classCode, className }) => {
    output[generateDartFileName(className)] = importString + classCode;
  });

  output["clientExtension"] =
    "// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names" +
    supabaseSdkImport +
    "\n" +
    clientExtension;

  return output;
};
