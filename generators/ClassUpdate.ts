import { Definition } from "./types";
import { getDartTypeByFormat, toJsonEncodable } from "./utils";

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
    const dartDataType = getDartTypeByFormat(properties[propertyName].format);
    code += `if (${propertyName} != null) '${propertyName}': ${toJsonEncodable(
      dartDataType,
      properties[propertyName].format,
      propertyName
    )},\n`;
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};
