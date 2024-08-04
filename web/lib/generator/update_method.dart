import 'swagger.dart';
import 'to_json_encodable.dart';

String generateUpdateMethod(
  Map<String, Column> columns,
) {
  var code = 'static Map<String, dynamic> update({\n';

  columns.forEach((columnName, columnDetails) {
    final dartType = columnDetails.dartType;
    code += '${dartType.type}? $columnName,\n';
  });

  code += '}) {\n';
  code += 'return {\n';

  columns.forEach((columnName, columnDetails) {
    final dartDataType = columnDetails.dartType;
    code +=
        "if ($columnName != null) '$columnName': ${toJsonEncodable(dartDataType.type, columnDetails.postgresFormat, columnName)},\n";
  });

  code += '};\n';
  code += '}\n\n';

  return code;
}
