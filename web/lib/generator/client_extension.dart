import 'swagger.dart';

String generateClientExtension(DatabaseSwagger swagger) {
  String code = 'extension SupadartClient on SupabaseClient {\n';
  swagger.definitions.forEach((tableName, _) {
    tableName = tableName.toLowerCase();
    code += "SupabaseQueryBuilder get $tableName => from('$tableName');\n";
  });
  code += '}\n';
  return code;
}
