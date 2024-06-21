import { Definitions } from "./utils";

export const generateClientExtension = (definitions: Definitions) => {
  let code = `extension TypeSafeTable on SupabaseClient {\n`;
  for (let tableName in definitions) {
    tableName = tableName.toLowerCase();
    code += `SupabaseQueryBuilder get ${tableName} {\n`;
    code += `return from('${tableName}');\n`;
    code += `}\n`;
  }
  code += `}\n`;
  return code;
};
