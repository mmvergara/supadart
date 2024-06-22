import { ClientExtension, Definitions } from "./types";

export const generateClientExtension = (
  definitions: Definitions
): ClientExtension => {
  let code = `// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names\nextension TypeSafeTable on SupabaseClient {\n`;
  for (let tableName in definitions) {
    tableName = tableName.toLowerCase();
    code += `SupabaseQueryBuilder get ${tableName} {\n`;
    code += `return from('${tableName}');\n`;
    code += `}\n`;
  }
  code += `}\n`;
  return code;
};
