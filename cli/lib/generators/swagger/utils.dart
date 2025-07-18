String postgresFormatToDartType(String format, bool jsonbToDynamic) {
  if (jsonbToDynamic) {
    if (format == 'jsonb') return 'dynamic';
    if (format == 'jsonb[]') return 'List<dynamic>';
  }
  switch (format) {
    // Integer types
    case "bigint":
      return "BigInt";
    case "integer":
    case "smallint":
      return "int";
    case "bigint[]":
      return "List<BigInt>";
    case "integer[]":
    case "smallint[]":
      return "List<int>";

    // Floating-point types
    case "double precision":
    case "real":
      return "double";
    case "double precision[]":
    case "real[]":
      return "List<double>";

    // Numeric types
    case "numeric":
      return "num";
    case "numeric[]":
      return "List<num>";

    // Boolean types
    case "boolean":
      return "bool";
    case "boolean[]":
      return "List<bool>";

    // Date and Time types
    case "date":
    case "timestamp without time zone":
    case "timestamp with time zone":
    case "time without time zone":
    case "time with time zone":
      return "DateTime";
    case "date[]":
    case "timestamp without time zone[]":
    case "timestamp with time zone[]":
    case "time without time zone[]":
    case "time with time zone[]":
      return "List<DateTime>";

    // Interval types
    case "interval":
      return "Duration";
    case "interval[]":
      return "List<Duration>";

    // JSON types
    case "json":
    case "jsonb":
      return "Map<String, dynamic>";
    case "json[]":
    case "jsonb[]":
      return "List<Map<String, dynamic>>";

    // PostGIS types
    case final String s when s.contains('geometry') && s.endsWith('[]'):
    case final String s when s.contains('geography') && s.endsWith('[]'):
      return "List<Geometry>";

    case final String s when s.contains('geometry'):
    case final String s when s.contains('geography'):
      return "Geometry";

    // This is where all other types go, supported or unsupported they are going be strings
    default:
      return format.endsWith("[]") ? "List<String>" : "String";
  }
}
