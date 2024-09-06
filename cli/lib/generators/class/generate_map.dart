import '../swagger/table.dart';
import '../utils/encoderJson.dart';

String generateGenerateMapPrivateMethod(Table table) {
  final columns = table.columns;
  final buffer = StringBuffer();

  buffer.writeln('static Map<String, dynamic> _generateMap({');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln('${columnDetails.dartType}? $columnName,');
  });

  buffer.writeln('}) {');

  buffer.writeln('return {');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln(
      "if ($columnName != null) '${columnDetails.dbColName}': ${encodeToJson(columnDetails)},",
    );
  });

  buffer.writeln('};');
  buffer.writeln('}');

  return buffer.toString();
}
