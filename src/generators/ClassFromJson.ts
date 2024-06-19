import { Definition } from "./utils";

export const generateFromJsonMethod = (
  className: string,
  properties: Definition["properties"]
) => {
  let code = `static ${className} fromJson(Map<String, dynamic> json) {\n`;
  code += `return ${className}(\n`;
  for (const propertyName in properties) {
    code += `${propertyName}: json['${propertyName}'],\n`;
  }
  code += `);\n`;
  code += `}\n\n`;
  return code;
};
