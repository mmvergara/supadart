import 'package:yaml/yaml.dart';
import '../utils/string_formatters.dart';
import '../swagger/swagger.dart';

String generateExports(DatabaseSwagger swagger, YamlMap? mappings) {
  final code = StringBuffer('library models;\n');
  for (final table in swagger.tables) {
    final className = tableNameToClassName(
        table.schema, table.name, mappings, swagger.schemas);
    code.write("export '${classNameToFileName(className)}';\n");
  }
  return code.toString();
}
