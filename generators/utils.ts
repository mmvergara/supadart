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

const ALl_TYPES = {
  properties: {
    bigintx: {
      description: "Note:\nThis is a Primary Key.<pk/>",
      format: "bigint",
      type: "integer",
    },
    bigserialx: {
      format: "bigint",
      type: "integer",
    },
    bitx: {
      format: "bit",
      maxLength: 1,
      type: "string",
    },
    bitvaryingx: {
      format: "bit varying",
      type: "string",
    },
    booleanx: {
      format: "boolean",
      type: "boolean",
    },
    boxx: {
      format: "box",
      type: "string",
    },
    byteax: {
      format: "bytea",
      type: "string",
    },
    characterx: {
      format: "character",
      maxLength: 1,
      type: "string",
    },
    charactervaryingx: {
      format: "character varying",
      type: "string",
    },
    cidrx: {
      format: "cidr",
      type: "string",
    },
    circlex: {
      format: "circle",
      type: "string",
    },
    datex: {
      format: "date",
      type: "string",
    },
    doublex: {
      format: "double precision",
      type: "number",
    },
    inetx: {
      format: "inet",
      type: "string",
    },
    integerx: {
      format: "integer",
      type: "integer",
    },
    intervalx: {
      format: "interval",
      type: "string",
    },
    jsonx: {
      format: "json",
    },
    jsonbx: {
      format: "jsonb",
    },
    linex: {
      format: "line",
      type: "string",
    },
    lsegx: {
      format: "lseg",
      type: "string",
    },
    macaddrx: {
      format: "macaddr",
      type: "string",
    },
    macaddr8x: {
      format: "macaddr8",
      type: "string",
    },
    moneyx: {
      format: "money",
      type: "string",
    },
    numericx: {
      format: "numeric",
      type: "number",
    },
    pathx: {
      format: "path",
      type: "string",
    },
    pg_lsnx: {
      format: "pg_lsn",
      type: "string",
    },
    pg_snapshotx: {
      format: "pg_snapshot",
      type: "string",
    },
    pointx: {
      format: "point",
      type: "string",
    },
    polygonx: {
      format: "polygon",
      type: "string",
    },
    realx: {
      format: "real",
      type: "number",
    },
    smallintx: {
      format: "smallint",
      type: "integer",
    },
    smallserialx: {
      format: "smallint",
      type: "integer",
    },
    serialx: {
      format: "integer",
      type: "integer",
    },
    textx: {
      format: "text",
      type: "string",
    },
    timex: {
      format: "time without time zone",
      type: "string",
    },
    timewithouttimezone: {
      format: "time without time zone",
      type: "string",
    },
    timestampx: {
      format: "timestamp without time zone",
      type: "string",
    },
    timestampwithouttimezone: {
      format: "timestamp without time zone",
      type: "string",
    },
    tsqueryx: {
      format: "tsquery",
      type: "string",
    },
    tsvectorx: {
      format: "tsvector",
      type: "string",
    },
    txid_snapshotx: {
      format: "txid_snapshot",
      type: "string",
    },
    uuidx: {
      format: "uuid",
      type: "string",
    },
    xmlx: {
      format: "xml",
      type: "string",
    },
  },
  type: "object",
};
