import '../swagger/column.dart';

dynamic toJsonEncodable(
  String dartType,
  String format,
  String columnName,
  Column columnDetails,
) {
  bool isArray = format.contains("[]");
  if (isArray) {
    format = format.replaceAll("[]", "");
  }

  dynamic parseValue;
  switch (dartType) {
    case "bool":
    case "int":
    case "double":
      parseValue = columnName;
      break;
    case "DateTime":
      if (format == "time without time zone") {
        parseValue = isArray
            ? "$columnName.map((e) => DateFormat('HH:mm:ss.SSS').format(e)).toList()"
            : "DateFormat('HH:mm:ss.SSS').format($columnName)";
      } else if (format == "time with time zone") {
        parseValue = isArray
            ? "$columnName.map((e) => DateFormat('HH:mm:ss zzzz').format(e)).toList()"
            : "DateFormat('HH:mm:ss zzzz').format($columnName)";
      } else if (format == "timestamp with time zone") {
        parseValue = isArray
            ? '$columnName.map((e) => e.toUtc().toIso8601String()).toList()'
            : '$columnName.toUtc().toIso8601String()';
      } else {
        parseValue = isArray
            ? '$columnName.map((e) => e.toIso8601String()).toList()'
            : '$columnName.toIso8601String()';
      }
      break;
    case "Map<String, dynamic>":
      parseValue = columnName;
      break;
    case "List<Map<String, dynamic>>":
      parseValue = columnName;
      break;
    default:
      if (columnDetails.enumValues.isNotEmpty) {
        parseValue = isArray
            ? "$columnName.map((e) => e.toString().split('.').last).toList()"
            : "$columnName.toString().split('.').last";
      } else if (dartType.startsWith("List<")) {
        // For any other List types, keep it as is
        parseValue = columnName;
      } else {
        parseValue = columnName;
      }
  }

  return parseValue;
}
