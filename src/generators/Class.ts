import { generateFromJsonMethod } from "./ClassFromJson";
import { generateInsertMethod } from "./ClassInsert";
import { generateUpdateMethod } from "./ClassUpdate";
import { Definitions, getDartType } from "./utils";

export const generateDartClasses = (definitions: Definitions) => {
  let dartCode = "";

  for (const tableName in definitions) {
    const table = definitions[tableName];
    const className = tableName.charAt(0).toUpperCase() + tableName.slice(1);
    // const primaryKey = table.required[0];

    // Class definition
    dartCode += `class ${className} {\n`;

    // Attributes
    for (const propertyName in table.properties) {
      const property = table.properties[propertyName];
      const dartType = getDartType(property.type);

      // Add question mark for optional fields (not in "required")
      const isOptional = !table.required.includes(propertyName);
      dartCode += `${dartType}${isOptional ? "?" : ""} ${propertyName};\n`;
    }

    // Constructor
    dartCode += `\n  ${className}({\n`;
    for (const propertyName in table.properties) {
      const isOptional = !table.required.includes(propertyName);
      dartCode += `${
        isOptional ? "this." : "required this."
      }${propertyName},\n`;
    }
    dartCode += `});\n\n`;

    // Table name
    dartCode += `static String get table_name => '${tableName}';\n`;

    // Helper functions
    dartCode += generateInsertMethod(table.properties, table.required);
    dartCode += generateUpdateMethod(table.properties);
    dartCode += generateFromJsonMethod(className, table.properties);

    dartCode += "}\n\n";
  }

  return dartCode;
};
