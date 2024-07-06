import { DartType, Format } from "./types";

export const getDartTypeByFormat = (format: Format): DartType => {
  switch (format) {
    // ====================
    // Integer types
    case "bigint":
      return "BigInt";
    case "integer":
    case "smallint":
      return "int";
    // Integer Array types
    case "bigint[]":
      return "List<BigInt>";
    case "integer[]":
    case "smallint[]":
      return "List<int>";

    // ====================
    // Floating-point types
    case "double precision":
    case "real":
      return "double";
    // Floating-point Array types
    case "double precision[]":
    case "real[]":
      return "List<double>";

    // ====================
    // Numeric type
    case "numeric":
      return "num";
    // Numeric Array type
    case "numeric[]":
      return "List<num>";

    // ====================
    // Boolean type
    case "boolean":
      return "bool";
    // Boolean Array type
    case "boolean[]":
      return "List<bool>";

    // ====================
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
    // String Array types
    case "text[]":
    case "character varying[]":
    case "character[]":
    case "uuid[]":
    case "bit[]":
    case "bit varying[]":
    case "cidr[]":
    case "inet[]":
    case "macaddr[]":
    case "macaddr8[]":
    case "money[]":
    case "tsquery[]":
    case "tsvector[]":
    case "xml[]":
      return "List<String>";

    // ====================
    // Date and Time types
    case "date":
    case "timestamp without time zone":
    case "timestamp with time zone":
    case "time without time zone":
    case "time with time zone":
      return "DateTime";
    // Date and Time Array types
    case "date[]":
    case "timestamp without time zone[]":
    case "timestamp with time zone[]":
    case "time without time zone[]":
    case "time with time zone[]":
      return "List<DateTime>";

    // ====================
    // Interval type
    case "interval":
      return "Duration";
    // Interval Array type
    case "interval[]":
      return "List<Duration>";

    // ====================
    // Binary data type
    case "bytea":
      return "String";
    // Binary data Array type
    case "bytea[]":
      return "List<String>";

    // ====================
    // JSON types
    case "json":
    case "jsonb":
      return "Map<String, dynamic>";

    // JSON Array types
    case "json[]":
    case "jsonb[]":
      return "List<Map<String, dynamic>>";

    // ====================
    // Geometric types
    case "box":
    case "circle":
    case "line":
    case "lseg":
    case "path":
    case "point":
    case "polygon":
      return "String"; // These might require custom classes for proper representation
    // Geometric Array types
    case "box[]":
    case "circle[]":
    case "line[]":
    case "lseg[]":
    case "path[]":
    case "point[]":
    case "polygon[]":
      return "List<String>"; // These might require custom classes for proper representation

    // ====================
    // PostgreSQL-specific types
    case "pg_lsn":
    case "pg_snapshot":
    case "txid_snapshot":
      return "String"; // These might require custom handling
    // PostgreSQL-specific Array types
    case "pg_lsn[]":
    case "pg_snapshot[]":
    case "txid_snapshot[]":
      return "List<String>"; // These might require custom handling

    default:
      return "dynamic"; // For unsupported types, use dynamic as a fallback
  }
};
export const toJsonEncodable = (
  dartType: DartType,
  format: Format,
  propertyName: string
) => {
  const isArray = format.includes("[]");
  if (isArray) {
    format = format.replace("[]", "") as Format;
  }

  let parseValue = "";
  switch (dartType) {
    case "DateTime":
      if (format === "time without time zone") {
        if (isArray) {
          parseValue = `${propertyName}.map((e) => DateFormat('HH:mm:ss.SSS').format(e)).toList()`;
        } else {
          parseValue = `DateFormat('HH:mm:ss.SSS').format(${propertyName})`;
        }
        break;
      }
      if (format === "time with time zone") {
        if (isArray) {
          parseValue = `${propertyName}.map((e) => DateFormat('HH:mm:ss zzzz').format(e)).toList()`;
        } else {
          parseValue = `DateFormat('HH:mm:ss zzzz').format(${propertyName})`;
        }
        break;
      }
      if (format === "timestamp with time zone") {
        if (isArray) {
          parseValue = `${propertyName}.map((e) => e.toUtc().toString()).toList()`;
        } else {
          parseValue = `${propertyName}.toUtc().toString()`;
        }
        break;
      }
      parseValue = `${propertyName}.toIso8601String()`;
      break;
    case "List<Map<String, dynamic>>":
      console.log("List<Map<String, dynamic>>", propertyName);
      parseValue = `jsonEncode(${propertyName})`;
      break;
    default:
      parseValue = `${propertyName}.toString()`;
  }

  if (isArray && dartType === "List<Map<String, dynamic>>") {
    parseValue += `.replaceAll('"', '\\\\\"')
        .replaceAll("{", '"{')
        .replaceAll("}", '}"')
        .replaceAll("[", '{')
        .replaceAll("]", '}')`;
  } else if (isArray) {
    parseValue += '.replaceAll("[", "{").replaceAll("]", "}")';
  }
  return parseValue;
};
export const generateDartFileName = (tableName: string): string => {
  // Remove any non-alphanumeric characters and replace them with an empty string
  let fileName = tableName.replace(/[^a-zA-Z0-9]/g, "");

  // Convert the file name to lowercase
  fileName = fileName.toLowerCase();

  return fileName;
};

export const snakeCasingToPascaleCasing = (name: string): string => {
  return name
    .split("_")
    .map((word) => word[0].toUpperCase() + word.slice(1))
    .join("");
};
