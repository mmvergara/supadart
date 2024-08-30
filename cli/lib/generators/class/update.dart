import '../swagger/table.dart';

String generateUpdateMethod(Table table) {
  final columns = table.columns;
  final buffer = StringBuffer();

  buffer.writeln('static Map<String, dynamic> update({');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln('${columnDetails.dartType}? $columnName,');
  });
  buffer.writeln('}) {');
  // Method body

  buffer.writeln('return _generateMap(');
  columns.forEach((columnName, columnDetails) {
    buffer.writeln('  $columnName: $columnName,');
  });
  buffer.writeln(');');

  // Method body
  buffer.writeln('}');

  return buffer.toString();
}
