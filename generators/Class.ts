import { generateFromJsonMethod } from "./fromJson";
import { generateInsertMethod } from "./insertMethod";
import { generateStaticColumnNames } from "./staticColumnNames";
import { generateUpdateMethod } from "./updateMethod";
import { DartClass, Definitions } from "./types";
import { getDartTypeByFormat, snakeCasingToPascaleCasing } from "./utils";

export const generateDartClasses = (definitions: Definitions): DartClass[] => {
  const generatedClasses: DartClass[] = [];

  // Object entries
  for (const [tableName, table] of Object.entries(definitions)) {
    let dartCode = "";
    const { properties, required } = table;
    const className = snakeCasingToPascaleCasing(tableName);

    // Class definition
    dartCode += `class ${className} implements SupadartClass<${className}> {\n`;

    // Attributes
    for (const propertyName in properties) {
      const property = properties[propertyName];
      const dartType = getDartTypeByFormat(property.format);

      // Add question mark for optional fields (not in "required")
      const isOptional = !table.required.includes(propertyName);
      dartCode += `final ${dartType}${
        isOptional ? "?" : ""
      } ${propertyName};\n`;
    }

    // Constructor
    dartCode += `\n const ${className}({\n`;
    for (const propertyName in properties) {
      const isRequired = required.includes(propertyName);
      dartCode += `${
        isRequired ? "required this." : "this."
      }${propertyName},\n`;
    }
    dartCode += `});\n\n`;

    // Table name
    dartCode += `static String get table_name => '${tableName}';\n`;

    // Static column names
    dartCode += generateStaticColumnNames(properties);

    // Helper functions
    dartCode += generateInsertMethod(properties, required);
    dartCode += generateUpdateMethod(properties);
    dartCode += generateFromJsonMethod(className, properties, required);

    dartCode += "}\n\n";
    generatedClasses.push({
      className,
      classCode: dartCode,
    });
  }

  return generatedClasses;
};
