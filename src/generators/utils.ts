export type Definitions = Record<string, Definition>;
export type Definition = {
  required: string[];
  properties: {
    [key: string]: {
      type?: Type;
      format: Format;
      default?: string | number | boolean;
      description?: string;
    };
  };
  type: "object";
};

export type Type = "string" | "integer" | "boolean" | "number";
export type DartType =
  | "String"
  | "int"
  | "double"
  | "num"
  | "Map<String, dynamic>"
  | "bool"
  | "DateTime"
  | "Converter Doesn't Support This Type";
// https://supabase.com/docs/guides/database/tables#data-types
// All postgres data types are supported but the following are the only the subset that are supported by Supabase Table Editor.
export type Format =
  | "bigint"
  | "double precision"
  | "numeric"
  | "json"
  | "jsonb"
  | "text"
  | "character varying"
  | "uuid"
  | "date"
  | "timestamp without time zone"
  | "timestamp with time zone"
  | "boolean";

export const getDartTypeByFormat = (format: Format): DartType => {
  switch (format) {
    // number
    case "bigint":
      return "int";
    case "double precision":
      return "double";
    case "numeric":
      return "num";

    // im not quite confident with this one
    case "json":
      return "Map<String, dynamic>";
    case "jsonb":
      return "Map<String, dynamic>";

    // string
    case "text":
      return "String";
    case "character varying":
      return "String";
    case "uuid":
      return "String";

    // Date and Time
    // making the "time without time zone" is very tricky

    // case "time without time zone":
    //   return "DateTime";
    case "date":
      return "DateTime";
    case "timestamp without time zone":
      return "DateTime";
    case "timestamp with time zone":
      return "DateTime";
    case "boolean":
      return "bool";

    default:
      return "Converter Doesn't Support This Type";
  }
};

// const exampleAllTypes = {
//   properties: {
//     id: {
//       description: "Note:\nThis is a Primary Key.<pk/>",
//       format: "bigint",
//       type: "integer",
//     },
//     created_at: {
//       default: "now()",
//       format: "timestamp with time zone",
//       type: "string",
//     },
//     int8: {
//       format: "bigint",
//       type: "integer",
//     },
//     float8: {
//       format: "double precision",
//       type: "number",
//     },
//     numeric: {
//       format: "numeric",
//       type: "number",
//     },
//     json: {
//       format: "json",
//     },
//     jsonb: {
//       format: "jsonb",
//     },
//     text: {
//       format: "text",
//       type: "string",
//     },
//     varchar: {
//       format: "character varying",
//       type: "string",
//     },
//     uuid: {
//       default: "gen_random_uuid()",
//       format: "uuid",
//       type: "string",
//     },
//     date: {
//       format: "date",
//       type: "string",
//     },
//     time: {
//       format: "time without time zone",
//       type: "string",
//     },
//     timetz: {
//       format: "timestamp with time zone",
//       type: "string",
//     },
//     timestamp: {
//       format: "timestamp without time zone",
//       type: "string",
//     },
//     timestamptz: {
//       format: "timestamp with time zone",
//       type: "string",
//     },
//     bool: {
//       format: "boolean",
//       type: "boolean",
//     },
//   },
// };
