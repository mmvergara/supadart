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
      `json['${propertyName}']`
    )},\n`;
  }
  code += `);\n`;
  code += `}\n\n`;
  return code;
};

export const parseWrapper = (
  dartType: DartType,
  format: Format,
  jsonValue: string
): string => {
  const isArray = format.includes("[]");
  if (isArray) {
    format = format.replace("[]", "") as Format;
  }
  let output = `${jsonValue} != null ?`;
  switch (dartType) {
    // ====================
    case "int":
      output += `${jsonValue} as int`;
      break;
    case "List<int>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v as int).toList()`;
      break;
    // ====================
    case "BigInt":
      output += `BigInt.tryParse(${jsonValue}.toString()) as BigInt`;
      break;
    case "List<BigInt>":
      output += `(${jsonValue} as List<dynamic>).map((v) => BigInt.tryParse(v.toString()) as BigInt).toList()`;
      break;
    // ====================
    case "double":
      output += `double.tryParse(${jsonValue}.toString())`;
      break;
    case "List<double>":
      output += `(${jsonValue} as List<dynamic>).map((v) => double.tryParse(v.toString()) as double).toList()`;
      break;
    // ====================
    case "num":
      output += `num.tryParse(${jsonValue}.toString())`;
      break;
    case "List<num>":
      output += `(${jsonValue} as List<dynamic>).map((v) => num.tryParse(v.toString()) as num).toList()`;
      break;
    // ====================
    case "bool":
      output += `${jsonValue} as bool`;
      break;
    case "List<bool>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v as bool).toList()`;
      break;
    // ====================
    case "String":
      output += `${jsonValue}.toString()`;
      break;
    case "List<String>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v as String).toList()`;
      break;
    // ====================
    case "DateTime":
      if (format === "time without time zone") {
        output += `DateTime.tryParse("1970-01-01T\${${jsonValue}.toString()}") as DateTime`;
        break;
      }
      if (format === "time with time zone") {
        output += `DateTime.tryParse("1970-01-01T\${${jsonValue}.toString()}") as DateTime`;
        break;
      }
      output += `DateTime.tryParse(${jsonValue}.toString()) as DateTime`;
      break;
    case "List<DateTime>":
      if (format === "time without time zone") {
        output += `(${jsonValue} as List<dynamic>).map((v) => DateTime.tryParse("1970-01-01T\${v.toString()}") as DateTime).toList()`;
        break;
      }
      if (format === "time with time zone") {
        output += `(${jsonValue} as List<dynamic>).map((v) => DateTime.tryParse("1970-01-01T\${v.toString()}") as DateTime).toList()`;
        break;
      }
      output += `(${jsonValue} as List<dynamic>).map((v) => DateTime.tryParse(v.toString()) as DateTime).toList()`;
      break;
    // ====================
    case "Duration":
      output += `${jsonValue} as Duration`;
      break;
    case "List<Duration>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v as Duration).toList()`;
      break;
    // ====================
    case "Map<String, dynamic>":
      output += `${jsonValue} as Map<String, dynamic>`;
      break;
    case "List<Map<String, dynamic>>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v as Map<String, dynamic>).toList()`;
      break;
    // ====================
    default:
      console.log(dartType);
      output += `Something went wrong, please open an issue on this`;
      break;
  }
  // Add Null Default Value, This will enable the support for column selection
  output += ` : ${dartTypeDefaultNullValue(dartType)}`;
  return output;
};

const dartTypeDefaultNullValue = (dartType: DartType): string => {
  switch (dartType) {
    case "int":
      return "0";
    case "BigInt":
      return "BigInt.from(0)";
    case "double":
      return "0.0";
    case "num":
      return "0";
    case "bool":
      return "false";
    case "String":
      return "'0'";
    case "DateTime":
      return "DateTime.fromMillisecondsSinceEpoch(0)"; // Using Unix epoch as default
    case "Duration":
      return "Duration()"; // Assuming duration in milliseconds
    case "Map<String, dynamic>":
      return "{}";
    case "dynamic":
      return "null";
    case "List<int>":
    case "List<BigInt>":
    case "List<double>":
    case "List<num>":
    case "List<bool>":
    case "List<String>":
    case "List<DateTime>":
    case "List<Duration>":
    case "List<Map<String, dynamic>>":
    case "List<dynamic>":
      return "[]";
    default:
      return "null";
  }
};
