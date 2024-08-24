import '../utils/to_json_encodable.dart';
import '../swagger/column.dart';

String generateUpdateMethod(
  Map<String, Column> columns,
) {
  var code = 'static Map<String, dynamic> update({\n';

  columns.forEach((columnName, columnDetails) {
    code += '${columnDetails.dartType}? $columnName,\n';
  });

  code += '}) {\n';
  code += 'return {\n';

  columns.forEach((columnName, columnDetails) {
    code +=
        "if ($columnName != null) '${columnDetails.dbColName}': ${toJsonEncodable(columnDetails.dartType, columnDetails.postgresFormat, columnName, columnDetails)},\n";
  });

  code += '};\n';
  code += '}\n\n';

  return code;
}
