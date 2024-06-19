import { Definition, getDartType } from "./utils";

export const generateInsertMethod = (
  properties: Definition["properties"],
  requiredFields: Definition["required"]
) => {
  let code = `static Map<String, dynamic> insert({\n`;
  for (const propertyName in properties) {
    // Check if the field has a default value
    const isOptional = !!(
      properties[propertyName]?.hasOwnProperty("default") ||
      !requiredFields.includes(propertyName) ||
      properties[propertyName]?.description?.includes("<pk/>")
    );

    code += `${isOptional ? "" : "required"} ${getDartType(
      properties[propertyName].type
    )}${isOptional ? "?" : ""} ${propertyName},\n`;
  }
  code += `}) {\n`;
  code += `return {\n`;
  for (const propertyName in properties) {
    const isOptional = !!(
      properties[propertyName]?.hasOwnProperty("default") ||
      !requiredFields.includes(propertyName) ||
      properties[propertyName]?.description?.includes("<pk/>")
    );
    if (isOptional) {
      code += `if (${propertyName} != null) '${propertyName}': ${propertyName},\n`;
    } else {
      code += `'${propertyName}': ${propertyName},\n`;
    }
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};
