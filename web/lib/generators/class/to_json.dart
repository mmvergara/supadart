import '../swagger/table.dart';

String generateToJsonMethod(String className, Table table) {
  final columns = table.columns;
  final code = StringBuffer();

  // Method signature
  code.writeln('Map<String, dynamic> toJson() {');
  code.writeln(
      '// Promotion doesn\'t work well with public fields due to the possibility of the field being modified elsewhere.');

  code.writeln('return _generateMap(');

  columns.forEach((columnName, columnDetails) {
    code.writeln(
        '  ${columnDetails.camelColName}: ${columnDetails.camelColName},');
  });

  code.writeln(');');

  code.writeln('}');

  return code.toString();
}
