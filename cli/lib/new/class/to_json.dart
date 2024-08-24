import '../swagger/column.dart';

String generateToJsonMethod(
  String className,
  Map<String, Column> columns,
) {
  String code = 'Map<String, dynamic> toJson() {\n';
  code += 'return {\n';
  columns.forEach((columnName, columnDetails) {
    code +=
        'if ($columnName != null) \'${columnDetails.dbColName}\': ${columnDetails.camelColName},\n';
  });
  code += '};\n';
  code += '}\n\n';
  return code;
}
