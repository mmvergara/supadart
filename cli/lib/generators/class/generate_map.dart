import '../swagger/table.dart';
import '../utils/to_json_encodable.dart';

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
      "if ($columnName != null) '${columnDetails.dbColName}': ${toJsonEncodable(columnDetails.dartType, columnDetails.postgresFormat, columnName, columnDetails)},",
    );
  });

  buffer.writeln('};');
  buffer.writeln('}');

  return buffer.toString();
}
