import { DartType, Definition, Format } from "./types";
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
    code += `${propertyName}: ${parseWrapper(
      dartType,
      properties[propertyName].format,
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
  format: Format,
  jsonValue: string,
  required: boolean
): string => {
  if (required) {
    switch (dartType) {
      case "num":
        return `num.parse(${jsonValue}.toString())`;
      case "BigInt":
        return `BigInt.parse(${jsonValue}.toString())`;
      case "double":
        return `double.parse(${jsonValue}.toString())`;
      case "DateTime":
        if (format === "time without time zone") {
          return `DateTime.parse("1970-01-01T\${${jsonValue}}")`;
        }
        if (format === "time with time zone") {
          return `DateTime.parse("1970-01-01T\${${jsonValue}}")`;
        }
        return `DateTime.parse(${jsonValue})`;
      default:
        return jsonValue;
    }
  }

  switch (dartType) {
    case "num":
      return `${jsonValue} != null ? num.tryParse(${jsonValue}.toString()) : null`;
    case "BigInt":
      return `${jsonValue} != null ? BigInt.tryParse(${jsonValue}.toString()) : null`;
    case "double":
      return `${jsonValue} != null ? double.tryParse(${jsonValue}.toString()) : null`;
    case "DateTime":
      if (format === "time without time zone") {
        return `${jsonValue} != null ? DateTime.tryParse("1970-01-01T\${${jsonValue}}") : null`;
      }
      if (format === "time with time zone") {
        return `${jsonValue} != null ? DateTime.tryParse("1970-01-01T\${${jsonValue}}") : null`;
      }
      return `${jsonValue} != null ? DateTime.tryParse(${jsonValue}) : null`;
    default:
      return jsonValue;
  }
};
