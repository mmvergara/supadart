import '../swagger/table.dart';

String generateToJsonMethod(String className, Table table) {
  final columns = table.columns;
  final code = StringBuffer();

  // Method signature
  code.writeln('Map<String, dynamic> toJson() {');
  code.writeln('return _generateMap(');
  columns.forEach((columnName, columnDetails) {
    code.writeln(
        '  ${columnDetails.camelColName}: ${columnDetails.camelColName},');
  });

  code.writeln(');');

  code.writeln('}');

  return code.toString();
}
