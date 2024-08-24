import '../swagger/swagger.dart';

String generateEnums(DatabaseSwagger swagger) {
  final enumMap = <String, String>{};
  swagger.definitions.forEach((tableName, table) {
    table.columns.forEach((columnName, columnDetails) {
      if (columnDetails.enumValues.isNotEmpty) {
        final enumName = columnDetails.postgresFormat
            .split(".")
            .last
            .toUpperCase()
            .replaceAll('"', "");
        enumMap[enumName] = columnDetails.enumValues.join(", ");
      }
    });
  });

  final code = StringBuffer();
  enumMap.forEach((enumName, enumValues) {
    code.write("enum $enumName { $enumValues }\n");
  });
  return code.toString();
}
