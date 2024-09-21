import '../swagger/table.dart';

String generateCopyWithMethod(String className, Table table) {
  final columns = table.columns;
  final StringBuffer code = StringBuffer();

  code.writeln('${className} copyWith({');

  columns.forEach((columnName, columnDetails) {
    code.writeln('${columnDetails.dartType}? $columnName,');
  });

  code.writeln('}) {');

  code.writeln('return $className(');
  columns.forEach((columnName, columnDetails) {
    code.writeln('$columnName: $columnName ?? this.$columnName,');
  });

  code.writeln(');');
  code.writeln('}');
  code.writeln();
  return code.toString();
}
