import '../swagger/table.dart';

String generateGenerateNewStaticMethod(Table table) {
  final columns = table.columns;
  final buffer = StringBuffer();

  buffer.writeln('static Object New({');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln('${columnDetails.dartType}? $columnName,');
  });

  buffer.writeln('}) {');

  buffer.writeln('return {');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln(
      "if ($columnName != null) '${columnDetails.dbColName}': $columnName,",
    );
  });

  buffer.writeln('};');
  buffer.writeln('}');

  return buffer.toString();
}
