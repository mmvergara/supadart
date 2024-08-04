import 'format_to_dart_type.dart';
import 'swagger.dart';
import 'to_json_encodable.dart';

String generateInsertMethod(
  Map<String, Column> columns,
  List<String> requiredFields,
) {
  final buffer = StringBuffer()
    ..writeln('static Map<String, dynamic> insert({');

  // Generate parameters
  columns.forEach((columnName, columnDetails) {
    final isRequired = requiredFields.contains(columnName) &&
        !!!columnDetails.hasDefaultValue &&
        !columnDetails.isPrimaryKey &&
        !columnDetails.isSerialType;
    buffer.writeln(
        '${isRequired ? "required " : ""}${postgresFormatToDartType(columnDetails.postgresFormat).type}${isRequired ? "" : "?"} $columnName,');
  });
  buffer.writeln('}) {');
  buffer.writeln('return {');

  // Generate key-value pairs
  columns.forEach((columnName, columnDetails) {
    final isRequired = requiredFields.contains(columnName) &&
        !!!columnDetails.hasDefaultValue &&
        !columnDetails.isPrimaryKey &&
        !columnDetails.isSerialType;
    final dartType =
        postgresFormatToDartType(columnDetails.postgresFormat).type;

    buffer.writeln(isRequired
        ? "'$columnName': ${toJsonEncodable(dartType, columnDetails.postgresFormat, columnName)},"
        : 'if ($columnName != null) \'$columnName\': ${toJsonEncodable(dartType, columnDetails.postgresFormat, columnName)},');
  });
  buffer.writeln('};');
  buffer.writeln('}');

  return buffer.toString();
}
