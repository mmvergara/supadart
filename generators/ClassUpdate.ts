import { Definition } from "./types";
import { getDartTypeByFormat } from "./utils";

export const generateUpdateMethod = (properties: Definition["properties"]) => {
  let code = `static Map<String, dynamic> update({\n`;
  for (const propertyName in properties) {
    code += `${getDartTypeByFormat(
      properties[propertyName].format
    )}? ${propertyName},\n`;
  }
  code += `}) {\n`;
  code += `return {\n`;
  for (const propertyName in properties) {
    code += `if (${propertyName} != null) '${propertyName}': ${propertyName},\n`;
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};
