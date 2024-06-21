import { Definitions, Properties } from "./types";

export const generateStaticColumnNames = (properties: Properties) => {
  let code = "";
  for (const propertyName in properties) {
    console.log(propertyName);
    code += `static String get c_${propertyName} => '${propertyName}';\n`;
  }
  console.log(code);
  return code;
};
