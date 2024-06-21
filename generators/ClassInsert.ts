import { DartType, Definition } from "./types";
import { getDartTypeByFormat, toJsonEncodable } from "./utils";

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
    const isSerialType =
      properties[propertyName].description?.includes("serial");

    const isRequired =
      isRequiredField && !hasDefaultValue && !isPrimaryKey && !isSerialType;

    const dartDataType = getDartTypeByFormat(properties[propertyName].format);
    if (isRequired) {
      code += `'${propertyName}': ${toJsonEncodable(
        dartDataType,
        propertyName
      )},\n`;
    } else {
      code += `if (${propertyName} != null) '${propertyName}': ${toJsonEncodable(
        dartDataType,
        propertyName
      )},\n`;
    }
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};
