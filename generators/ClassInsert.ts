import { DartType, Definition } from "./types";
import { getDartTypeByFormat } from "./utils";

export const generateInsertMethod = (
  properties: Definition["properties"],
  requiredFields: Definition["required"]
) => {
  let code = `static Map<String, dynamic> insert({\n`;

  // Generate parameters
  for (const propertyName in properties) {
    // Check if the field has a default value

    const isPrimaryKey =
      properties[propertyName].description?.includes("<pk/>");
    const isRequiredField = requiredFields.includes(propertyName);
    const hasDefaultValue = properties[propertyName].default;
    const isRequired = isRequiredField && !hasDefaultValue && !isPrimaryKey;

    code += `${isRequired ? "required" : ""} ${getDartTypeByFormat(
      properties[propertyName].format
    )}${isRequired ? "" : "?"} ${propertyName},\n`;
  }
  code += `}) {\n`;
  code += `return {\n`;

  // Generate key-value pairs
  for (const propertyName in properties) {
    const isPrimaryKey =
      properties[propertyName].description?.includes("<pk/>");
    const isRequiredField = requiredFields.includes(propertyName);
    const hasDefaultValue = properties[propertyName].default;
    const isRequired = isRequiredField && !hasDefaultValue && !isPrimaryKey;

    const dartDataType = getDartTypeByFormat(properties[propertyName].format);
    if (isRequired) {
      code += `'${propertyName}': ${wrapIfDate(dartDataType, propertyName)},\n`;
    } else {
      code += `if (${propertyName} != null) '${propertyName}': ${wrapIfDate(
        dartDataType,
        propertyName
      )},\n`;
    }
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};
function wrapIfDate(dartType: DartType, propertyName: string) {
  if (dartType === "DateTime") {
    return `${propertyName}.toIso8601String()`;
  }
  return propertyName;
}
