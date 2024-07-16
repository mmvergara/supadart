export const generateWithConverterMethod = (className: string) => {
  let code = `static List<${className}>? withConverter(List<Map<String, dynamic>> data) {\n`;
  code += `return data.map((data) => ${className}.fromJson(data)).toList();\n`;
  code += `}\n`;
  return code;
};
