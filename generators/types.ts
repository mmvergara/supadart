export type Definitions = Record<string, Definition>;
export type Definition = {
  required: string[];
  properties: Properties;
  type: "object";
};

export type Properties = {
  [key: string]: {
    type?: Type;
    format: Format;
    default?: string | number | boolean;
    description?: string;
    maxLength?: number;
  };
};

export type DartClass = {
  className: string;
  classCode: string;
};
export type Imports = string[];
export type SupabaseSDKImport = string;
export type ClientExtension = string;

export type Type = "string" | "integer" | "boolean" | "number";
export type DartType =
  | "int"
  | "List<int>"
  | "BigInt"
  | "List<BigInt>"
  | "double"
  | "List<double>"
  | "num"
  | "List<num>"
  | "bool"
  | "List<bool>"
  | "String"
  | "List<String>"
  | "DateTime"
  | "List<DateTime>"
  | "Duration"
  | "List<Duration>"
  | "Map<String, dynamic>"
  | "List<Map<String, dynamic>>"
  | "dynamic"
  | "List<dynamic>"
  | "We don't support this type please open an issue on it";

export type Format =
  // Numeric types
  | "bigint"
  | "bigint[]"
  | "integer"
  | "integer[]"
  | "smallint"
  | "smallint[]"
  | "double precision"
  | "double precision[]"
  | "real"
  | "real[]"
  | "numeric"
  | "numeric[]"

  // Boolean type
  | "boolean"
  | "boolean[]"

  // Character types
  | "text"
  | "text[]"
  | "character varying"
  | "character varying[]"
  | "character"
  | "character[]"

  // Binary data type
  | "bytea"
  | "bytea[]"

  // Date/Time types
  | "date"
  | "date[]"
  | "time without time zone"
  | "time without time zone[]"
  | "time with time zone"
  | "time with time zone[]"
  | "timestamp without time zone"
  | "timestamp without time zone[]"
  | "timestamp with time zone"
  | "timestamp with time zone[]"
  | "interval"
  | "interval[]"

  // Network address types
  | "cidr"
  | "cidr[]"
  | "inet"
  | "inet[]"
  | "macaddr"
  | "macaddr[]"
  | "macaddr8"
  | "macaddr8[]"

  // Geometric types
  | "box"
  | "box[]"
  | "circle"
  | "circle[]"
  | "line"
  | "line[]"
  | "lseg"
  | "lseg[]"
  | "path"
  | "path[]"
  | "point"
  | "point[]"
  | "polygon"
  | "polygon[]"

  // JSON types
  | "json"
  | "json[]"
  | "jsonb"
  | "jsonb[]"

  // UUID type
  | "uuid"
  | "uuid[]"

  // Bit string types
  | "bit"
  | "bit[]"
  | "bit varying"
  | "bit varying[]"

  // Text search types
  | "tsquery"
  | "tsquery[]"
  | "tsvector"
  | "tsvector[]"

  // XML type
  | "xml"
  | "xml[]"

  // Money type
  | "money"
  | "money[]"

  // PostgreSQL-specific types
  | "pg_lsn"
  | "pg_lsn[]"
  | "pg_snapshot"
  | "pg_snapshot[]"
  | "txid_snapshot"
  | "txid_snapshot[]";
