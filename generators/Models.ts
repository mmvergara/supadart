import { Definitions } from "./types";

export const generateModels = (definitions: Definitions) => {
  let code = `library models;\n`;
  for (let tableName in definitions) {
    tableName = tableName.toLowerCase();
    code += `export '${tableName}.dart';\n`;
  }
  return code;
};
