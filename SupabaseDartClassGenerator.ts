export type Definitions = Record<string, Definition>;
export type Definition = {
  required: string[];
  properties: {
    [key: string]: {
      type: Type;
      format?: Format;
      default?: string | number | boolean;
      description?: string;
    };
  };
  type: "object";
};
export type Type = "string" | "integer" | "boolean" | "number";
export type Format =
  | "uuid"
  | "bigint"
  | "timestamp with time zone"
  | "text"
  | "smallint"
  | "number"
  | "boolean"
  | "double precision";

const generateDartClasses = (definitions: Definitions) => {
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

// Helper function to map JSON types to Dart types
// Need Help Here
const getDartType = (type: Type) => {
  switch (type) {
    case "integer":
    case "number":
      return "int";

    case "string":
      return "String";
    case "boolean":
      return "bool";
  }
};

// Helper function to generate the insert method
const generateInsertMethod = (
  properties: Definition["properties"],
  requiredFields: Definition["required"]
) => {
  let code = `static Map<String, dynamic> insert({\n`;
  for (const propertyName in properties) {
    // Check if the field has a default value
    const isOptional = !!(
      properties[propertyName]?.hasOwnProperty("default") ||
      !requiredFields.includes(propertyName) ||
      properties[propertyName]?.description?.includes("<pk/>")
    );

    code += `${isOptional ? "" : "required"} ${getDartType(
      properties[propertyName].type
    )}${isOptional ? "?" : ""} ${propertyName},\n`;
  }
  code += `}) {\n`;
  code += `return {\n`;
  for (const propertyName in properties) {
    const isOptional = !!(
      properties[propertyName]?.hasOwnProperty("default") ||
      !requiredFields.includes(propertyName) ||
      properties[propertyName]?.description?.includes("<pk/>")
    );
    if (isOptional) {
      code += `if (${propertyName} != null) '${propertyName}': ${propertyName},\n`;
    } else {
      code += `'${propertyName}': ${propertyName},\n`;
    }
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};

// Helper function to generate the update method
const generateUpdateMethod = (properties: Definition["properties"]) => {
  let code = `static Map<String, dynamic> update({\n`;
  for (const propertyName in properties) {
    code += `${getDartType(properties[propertyName].type)}? ${propertyName},\n`;
  }
  code += `}) {\n`;
  code += `return {\n`;
  for (const propertyName in properties) {
    code += `if (${propertyName} != null) '${propertyName}': ${propertyName},\n`;
  }
  code += `};\n`;
  code += `}\n\n`;
  return code;
};

const generateFromJsonMethod = (
  className: string,
  properties: Definition["properties"]
) => {
  let code = `static ${className} fromJson(Map<String, dynamic> json) {\n`;
  code += `return ${className}(\n`;
  for (const propertyName in properties) {
    code += `${propertyName}: json['${propertyName}'],\n`;
  }
  code += `);\n`;
  code += `}\n\n`;
  return code;
};


const generateTypeSafeTable = (definitions: Definitions) => {
  let code = `extension TypeSafeTable on SupabaseClient {\n`;
  for (let tableName in definitions) {
    tableName = tableName.toLowerCase();
    code += `SupabaseQueryBuilder get ${tableName} {\n`;
    code += `return from('${tableName}');\n`;
    code += `}\n`;
  }
  code += `}\n`;
  return code;
};

// const definitions: Definitions = {
//   books: {
//     required: ["id", "book_name", "created_at", "sold", "price"],
//     properties: {
//       id: {
//         description: "Note:\nThis is a Primary Key.<pk/>",
//         format: "bigint",
//         type: "integer",
//       },
//       book_name: {
//         format: "text",
//         type: "string",
//       },
//       created_at: {
//         default: "now()",
//         format: "timestamp with time zone",
//         type: "string",
//       },
//       book_description: {
//         format: "text",
//         type: "string",
//       },
//       sold: {
//         default: false,
//         format: "boolean",
//         type: "boolean",
//       },
//       price: {
//         format: "double precision",
//         type: "number",
//       },
//     },
//     type: "object",
//   },
// };

// const dartCode = generateDartClassess(definitions);
// console.log(dartCode);
