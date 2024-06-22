import { generateFromJsonMethod } from "./ClassFromJson";
import { generateInsertMethod } from "./ClassInsert";
import { generateStaticColumnNames } from "./ClassStaticColumnNames";
import { generateUpdateMethod } from "./ClassUpdate";
import { Definitions } from "./types";
import { getDartTypeByFormat } from "./utils";

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
      const dartType = getDartTypeByFormat(property.format);

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
    console.log("Generating static column names");
    console.log("Generating static column names");
    console.log("Generating static column names");
    dartCode += generateStaticColumnNames(definitions[tableName].properties);

    // Helper functions
    dartCode += generateInsertMethod(table.properties, table.required);
    dartCode += generateUpdateMethod(table.properties);
    dartCode += generateFromJsonMethod(
      className,
      table.properties,
      table.required
    );

    dartCode += "}\n\n";
  }

  return dartCode;
};
