import { generateDartClasses } from "./Class";
import { generateClientExtension } from "./ClientExtension";
import { Definitions } from "./types";

export const generateClassesAndClient = async (
  definitions: Definitions,
  isDart: boolean
) => {
  let outputCode =
    "// ignore_for_file: non_constant_identifier_names, camel_case_types\n";

  const imports = [
    isDart
      ? "import 'package:supabase/supabase.dart';"
      : "import 'package:supabase_flutter/supabase_flutter.dart';",
    "import 'package:intl/intl.dart';",
  ];

  outputCode += imports.join("\n") + "\n\n";

  outputCode += generateDartClasses(definitions);
  outputCode += "\n\n";
  outputCode += generateClientExtension(definitions);
  return outputCode.trim();
};
