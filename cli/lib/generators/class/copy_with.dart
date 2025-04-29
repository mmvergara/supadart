import '../swagger/table.dart';

String generateCopyWithMethod(String className, Table table) {
  final columns = table.columns;
  final StringBuffer code = StringBuffer();
  //  static const _unset = Object();
  code.writeln('static const _unset = Object();');
  code.writeln('${className} copyWith({');

  columns.forEach((columnName, columnDetails) {
    code.writeln('Object? $columnName = _unset,');
  });

  code.writeln('}) {');

  code.writeln('return $className(');
  columns.forEach((columnName, columnDetails) {
    code.writeln(
        '$columnName: $columnName == _unset ? this.$columnName : $columnName as ${columnDetails.dartType}${columnDetails.isNullable ? "?" : ""},');
  });

  code.writeln(');');
  code.writeln('}');
  code.writeln();
  return code.toString();
}
