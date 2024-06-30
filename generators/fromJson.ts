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
  isRequired: boolean
): string => {
  const isArray = format.includes("[]");
  if (isArray) {
    format = format.replace("[]", "") as Format;
  }
  let parseValue = "";
  switch (dartType) {
    case "num":
      parseValue = `num.tryParse(${jsonValue}.toString())`;
      break;
    case "BigInt":
      parseValue = `BigInt.tryParse(${jsonValue}.toString())`;
      break;
    case "double":
      parseValue = `double.tryParse(${jsonValue}.toString())`;
      break;
    case "DateTime":
      if (format === "time without time zone") {
        parseValue = `DateTime.tryParse("1970-01-01T\${${jsonValue}.toString()}")`;
        break;
      }
      if (format === "time with time zone") {
        parseValue = `DateTime.tryParse("1970-01-01T\${${jsonValue}.toString()}")`;
        break;
      }
      parseValue = `DateTime.tryParse(${jsonValue}.toString())`;
      break;
    default:
      parseValue = `${jsonValue}`;
  }

  // Check if the field is required

  let output = "";
  console.log(jsonValue, isArray);
  if (isRequired) {
    if (isArray) {
      output = `(${parseValue} as List<dynamic>).map((v) => v as ${removeListBrackets(
        dartType
      )}).toList()`;
    } else {
      output = `${parseValue} as ${dartType}`;
    }
  } else {
    if (isArray) {
      output = `${jsonValue} != null ? (${parseValue} as List<dynamic>).map((v) => v as ${removeListBrackets(
        dartType
      )}).toList() : null`;
    } else {
      output = `${jsonValue} != null ? ${parseValue} as ${dartType} : null`;
    }
  }
  return output;
};

const removeListBrackets = (value: string) => {
  return value.replace("List<", "").replace(">", "");
};
