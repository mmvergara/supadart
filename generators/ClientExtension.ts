import { ClientExtension, Definitions } from "./types";

export const generateClientExtension = (
  definitions: Definitions
): ClientExtension => {
  let code = `extension SupadartClient on SupabaseClient {\n`;
  for (let tableName in definitions) {
    tableName = tableName.toLowerCase();
    code += `SupabaseQueryBuilder get ${tableName} => from('${tableName}');\n`;
  }
  code += `}\n`;
  return code;
};
