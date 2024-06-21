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
  | "int"
  | "BigInt"
  | "double"
  | "num"
  | "bool"
  | "String"
  | "DateTime"
  | "Duration"
  | "Uint8List"
  | "Map<String, dynamic>"
  | "dynamic"
  | "We don't support this type please open an issue on it";

export type Format =
  // Numeric types
  | "bigint"
  | "integer"
  | "smallint"
  | "double precision"
  | "real"
  | "numeric"

  // Boolean type
  | "boolean"

  // Character types
  | "text"
  | "character varying"
  | "character"

  // Binary data type
  | "bytea"

  // Date/Time types
  | "date"
  | "time without time zone"
  | "time with time zone"
  | "timestamp without time zone"
  | "timestamp with time zone"
  | "interval"

  // Network address types
  | "cidr"
  | "inet"
  | "macaddr"
  | "macaddr8"

  // Geometric types
  | "box"
  | "circle"
  | "line"
  | "lseg"
  | "path"
  | "point"
  | "polygon"

  // JSON types
  | "json"
  | "jsonb"

  // UUID type
  | "uuid"

  // Bit string types
  | "bit"
  | "bit varying"

  // Text search types
  | "tsquery"
  | "tsvector"

  // XML type
  | "xml"

  // Money type
  | "money"

  // PostgreSQL-specific types
  | "pg_lsn"
  | "pg_snapshot"
  | "txid_snapshot";
