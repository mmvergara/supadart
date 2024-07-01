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
  let output = `${jsonValue} != null ?`;
  switch (dartType) {
    case "num":
      output += `num.tryParse(${jsonValue}.toString())`;
      break;
    case "List<num>":
      output += `(${jsonValue} as List<dynamic>).map((v) => num.tryParse(v.toString()) as num).toList()`;
      break;
    case "BigInt":
      output += `BigInt.tryParse(${jsonValue}.toString()) as BigInt`;
      break;
    case "List<BigInt>":
      output += `(${jsonValue} as List<dynamic>).map((v) => BigInt.tryParse(v.toString()) as BigInt).toList()`;
      break;
    case "double":
      output += `double.tryParse(${jsonValue}.toString())`;
      break;
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
    case "bool":
      output += `${jsonValue} == 1 ? true : false`;
      break;
    case "List<bool>":
      output += `(${jsonValue} as List<dynamic>).map((v) => v == 1 ? true : false).toList()`;
      break;
    default:
      output += `${jsonValue} as ${dartType}`;
      break;
  }
  // Add Null Default Value
  output += ` : ${dartTypeDefaultNullValue(dartType)}`;
  return output;
  // Check if the field is required

  // let output = "";
  // console.log(jsonValue, isArray);
  // if (isRequired) {
  //   if (isArray) {
  //     output = `(${parseValue} as List<dynamic>).map((v) => ${getMapParseWrapper(
  //       dartType,
  //       format
  //     )} as ${removeListBrackets(dartType)}).toList()`;
  //   } else {
  //     output = `${parseValue} as ${dartType}`;
  //   }
  // } else {
  //   if (isArray) {
  //     output = `${jsonValue} != null ? (${parseValue} as List<dynamic>).map((v) =>  ${getMapParseWrapper(
  //       dartType,
  //       format
  //     )} as ${removeListBrackets(dartType)}).toList() : null`;
  //   } else {
  //     output = `${jsonValue} != null ? ${parseValue} as ${dartType} : null`;
  //   }
  // }
};

// const removeListBrackets = (value: string) => {
//   return value.replace("List<", "").replace(">", "");
// };

// const getMapParseWrapper = (dartType: DartType, format: Format) => {
//   let parseValue = "";
//   switch (dartType) {
//     case "num":
//       parseValue = `num.tryParse(v.toString())`;
//       break;
//     case "BigInt":
//       parseValue = `BigInt.tryParse(v.toString())`;
//       break;
//     case "double":
//       parseValue = `double.tryParse(v.toString())`;
//       break;
//     case "DateTime":
//       if (format === "time without time zone") {
//         parseValue = `DateTime.tryParse("1970-01-01T\${v.toString()}")`;
//         break;
//       }
//       if (format === "time with time zone") {
//         parseValue = `DateTime.tryParse("1970-01-01T\${v.toString()}")`;
//         break;
//       }
//       parseValue = `DateTime.tryParse(v.toString())`;
//       break;
//     default:
//       parseValue = `v`;
//   }
//   return parseValue;
// };

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
