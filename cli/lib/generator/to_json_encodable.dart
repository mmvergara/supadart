String toJsonEncodable(
  String dartType,
  String format,
  String columnName,
) {
  bool isArray = format.contains("[]");
  if (isArray) {
    format = format.replaceAll("[]", "");
  }

  String parseValue = "";
  switch (dartType) {
    case "DateTime":
      if (format == "time without time zone") {
        parseValue = isArray
            ? "$columnName.map((e) => DateFormat('HH:mm:ss.SSS').format(e)).toList()"
            : "DateFormat('HH:mm:ss.SSS').format($columnName)";
        break;
      }
      if (format == "time with time zone") {
        parseValue = isArray
            ? "$columnName.map((e) => DateFormat('HH:mm:ss zzzz').format(e)).toList()"
            : "DateFormat('HH:mm:ss zzzz').format($columnName)";
        break;
      }
      if (format == "timestamp with time zone") {
        parseValue = isArray
            ? '$columnName.map((e) => e.toUtc().toString()).toList()'
            : '$columnName.toUtc().toString()';
        break;
      }
      parseValue = '$columnName.toIso8601String()';
      break;
    case "Map<String, dynamic>":
      return columnName;
    case "List<Map<String, dynamic>>":
      parseValue = 'jsonEncode($columnName)';
      break;
    default:
      parseValue = '$columnName.toString()';
  }

  if (isArray && dartType == "List<Map<String, dynamic>>") {
    parseValue += '''
    .replaceAll('"', '\\\\\"')
    .replaceAll("{", '"{')
    .replaceAll("}", '}"')
    .replaceAll("[", '{')
    .replaceAll("]", '}')''';
  } else if (isArray) {
    parseValue += '.replaceAll("[", "{").replaceAll("]", "}")';
  }
  return parseValue;
}
