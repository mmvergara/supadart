import 'package:yaml/yaml.dart';
import '../utils/string_formatters.dart';
import '../swagger/swagger.dart';

String generateExports(DatabaseSwagger swagger, YamlMap? mappings) {
  final code = StringBuffer('library models;\n');
  swagger.definitions.forEach((tableName, _) {
    final className = tableNameToClassName(tableName, mappings);
    final fileName = classNameToFileName(className);
    code.write("export '$fileName';\n");
  });
  return code.toString();
}
