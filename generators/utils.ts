import { DartType, Format } from "./types";

export const getDartTypeByFormat = (format: Format): DartType => {
  switch (format) {
    // Integer types
    case "bigint":
      return "BigInt";
    case "integer":
    case "smallint":
      return "int";

    // Floating-point types
    case "double precision":
    case "real":
      return "double";

    // Numeric type
    case "numeric":
      return "num";

    // Boolean type
    case "boolean":
      return "bool";

    // String types
    case "text":
    case "character varying":
    case "character":
    case "uuid":
    case "bit":
    case "bit varying":
    case "cidr":
    case "inet":
    case "macaddr":
    case "macaddr8":
    case "money":
    case "tsquery":
    case "tsvector":
    case "xml":
      return "String";

    // Date and Time types
    case "date":
    case "timestamp without time zone":
    case "timestamp with time zone":
    case "time without time zone":
    case "time with time zone":
      return "DateTime";

    // Interval type
    case "interval":
      return "Duration";

    // Binary data type
    case "bytea":
      return "String";

    // JSON types
    case "json":
    case "jsonb":
      return "Map<String, dynamic>";

    // Geometric types
    case "box":
    case "circle":
    case "line":
    case "lseg":
    case "path":
    case "point":
    case "polygon":
      return "String"; // These might require custom classes for proper representation

    // PostgreSQL-specific types
    case "pg_lsn":
    case "pg_snapshot":
    case "txid_snapshot":
      return "String"; // These might require custom handling

    default:
      return "dynamic"; // For unsupported types, use dynamic as a fallback
  }
};
export const toJsonEncodable = (
  dartType: DartType,
  format: Format,
  propertyName: string
) => {
  switch (dartType) {
    case "DateTime":
      if (format === "time without time zone") {
        return `DateFormat('HH:mm:ss.SSS').format(${propertyName})`;
      }
      if (format === "time with time zone") {
        return `DateFormat('HH:mm:ss zzzz').format(${propertyName})`;
      }
      if (format === "timestamp with time zone") {
        return `${propertyName}.toUtc().toString()`;
      }
      return `${propertyName}.toIso8601String()`;
    case "Map<String, dynamic>":
      return `${propertyName}`;
    default:
      return `${propertyName}.toString()`;
  }
};
export const generateDartFileName = (tableName: string): string => {
  // Remove any non-alphanumeric characters and replace them with an empty string
  let fileName = tableName.replace(/[^a-zA-Z0-9]/g, "");

  // Convert the file name to lowercase
  fileName = fileName.toLowerCase();

  return fileName;
};
