export const generateConverterMethod = (className: string) => {
  let code = `static List<${className}>? converter(List<Map<String, dynamic>> data) {\n`;
  code += `return data.map((data) => ${className}.fromJson(data)).toList();\n`;
  code += `}\n`;
  return code;
};

export const generateConverterSingleMethod = (className: string) => {
  let code = `static ${className}? converterSingle(Map<String, dynamic>? data) {\n`;
  code += `if (data == null) return null;\n`;
  code += `return ${className}.fromJson(data);\n`;
  code += `}\n`;
  return code;
};
