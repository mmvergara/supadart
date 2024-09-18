class DartType {
  final String type;
  DartType(this.type);
}

DartType postgresFormatToDartType(String format) {
  switch (format) {
    // ====================
    // Integer types
    case "bigint":
      return DartType("BigInt");

    case "integer":
    case "smallint":
      return DartType("int");
    // Integer Array types
    case "bigint[]":
      return DartType("List<BigInt>");
    case "integer[]":
    case "smallint[]":
      return DartType("List<int>");

    // ====================
    // Floating-point types
    case "double precision":
    case "real":
      return DartType("double");
    // Floating-point Array types
    case "double precision[]":
    case "real[]":
      return DartType("List<double>");

    // ====================
    // Numeric type
    case "numeric":
      return DartType("num");
    // Numeric Array type
    case "numeric[]":
      return DartType("List<num>");

    // ====================
    // Boolean type
    case "boolean":
      return DartType("bool");
    // Boolean Array type
    case "boolean[]":
      return DartType("List<bool>");

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
      return DartType("String");
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
      return DartType("List<String>");

    // ====================
    // Date and Time types
    case "date":
    case "timestamp without time zone":
    case "timestamp with time zone":
    case "time without time zone":
    case "time with time zone":
      return DartType("DateTime");
    // Date and Time Array types
    case "date[]":
    case "timestamp without time zone[]":
    case "timestamp with time zone[]":
    case "time without time zone[]":
    case "time with time zone[]":
      return DartType("List<DateTime>");

    // ====================
    // Interval type
    case "interval":
      return DartType("Duration");
    // Interval Array type
    case "interval[]":
      return DartType("List<Duration>");

    // ====================
    // Binary data type
    case "bytea":
      return DartType("String");
    // Binary data Array type
    case "bytea[]":
      return DartType("List<String>");

    // ====================
    // JSON types
    case "json":
    case "jsonb":
      return DartType("Map<String, dynamic>");
    // JSON Array types
    case "json[]":
    case "jsonb[]":
      return DartType("List<Map<String, dynamic>>");

    // ====================
    // Geometric types
    case "box":
    case "circle":
    case "line":
    case "lseg":
    case "path":
    case "point":
    case "polygon":
      return DartType(
          "String"); // These might require custom classes for proper representation
    // Geometric Array types
    case "box[]":
    case "circle[]":
    case "line[]":
    case "lseg[]":
    case "path[]":
    case "point[]":
    case "polygon[]":
      return DartType(
          "List<String>"); // These might require custom classes for proper representation

    // ====================
    // PostgreSQL-specific types
    case "pg_lsn":
    case "pg_snapshot":
    case "txid_snapshot":
      return DartType("String"); // These might require custom handling
    // PostgreSQL-specific Array types
    case "pg_lsn[]":
    case "pg_snapshot[]":
    case "txid_snapshot[]":
      return DartType("List<String>"); // These might require custom handling

    default:
      return DartType(
          "dynamic"); // For unsupported types, use dynamic as a fallback
  }
}
