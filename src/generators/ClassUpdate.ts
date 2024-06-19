import { Definition, getDartType } from "./utils";

export const generateUpdateMethod = (properties: Definition["properties"]) => {
  let code = `static Map<String, dynamic> update({\n`;
  for (const propertyName in properties) {
    code += `${getDartType(properties[propertyName].type)}? ${propertyName},\n`;
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
