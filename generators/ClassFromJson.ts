import { DartType, Definition } from "./types";
import { getDartTypeByFormat } from "./utils";

export const generateFromJsonMethod = (
  className: string,
  properties: Definition["properties"],
  requiredFields: string[]
) => {
  let code = `factory ${className}.fromJson(Map<String, dynamic> json) {\n`;
  code += `return ${className}(\n`;
  for (const propertyName in properties) {
    const isRequired = requiredFields.includes(propertyName);

    const dartType = getDartTypeByFormat(properties[propertyName].format);
    console.log(dartType, propertyName);
    code += `${propertyName}: ${parseWrapper(
      dartType,
      `json['${propertyName}']`,
      isRequired
    )},\n`;
  }
  code += `);\n`;
  code += `}\n\n`;
  return code;
};

export const parseWrapper = (
  dartType: DartType,
  jsonValue: string,
  required: boolean
): string => {
  if (required) {
    switch (dartType) {
      case "double":
        return `double.parse(${jsonValue}.toString())`;
      case "DateTime":
        return `DateTime.parse(${jsonValue})`;
      default:
        return jsonValue;
    }
  }

  switch (dartType) {
    case "double":
      return `${jsonValue} != null ? double.tryParse(${jsonValue}.toString()) : null`;
    case "DateTime":
      return `${jsonValue} != null ? DateTime.tryParse(${jsonValue}) : null`;
    default:
      return jsonValue;
  }
};
