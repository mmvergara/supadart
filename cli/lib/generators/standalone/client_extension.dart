import '../swagger/swagger.dart';

String generateClientExtension(DatabaseSwagger swagger) {
  final code = StringBuffer('extension SupadartClient on SupabaseClient {\n');
  swagger.definitions.forEach((tableName, _) {
    code.write(
        "SupabaseQueryBuilder get ${tableName.toLowerCase()} => from('$tableName');\n");
  });
  code.write('}\n');
  return code.toString();
}
