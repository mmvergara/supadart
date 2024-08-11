import 'package:supadart/generator/swagger.dart';

String generateEnums(DatabaseSwagger swagger) {
  Map<String, String> enumMap = {};
  swagger.definitions.forEach((tableName, table) {
    table.columns.forEach((columnName, columnDetails) {
      if (columnDetails.enumValues.isNotEmpty) {
        String enumName =
            columnDetails.postgresFormat.split(".").last.toUpperCase();
        enumMap[enumName] = columnDetails.enumValues.join(", ");
      }
    });
  });

  String code = "";
  enumMap.forEach((enumName, enumValues) {
    code += "enum $enumName { $enumValues }\n";
  });
  return code;
}
