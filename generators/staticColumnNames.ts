import { Properties } from "./types";

export const generateStaticColumnNames = (properties: Properties) => {
  let code = "";
  for (const propertyName in properties) {
    code += `static String get c_${propertyName} => '${propertyName}';\n`;
  }
  return code;
};
