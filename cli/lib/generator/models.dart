import 'package:supadart/generator/utils.dart';

import 'swagger.dart';

String generateModels(DatabaseSwagger swagger) {
  String code = 'library models;\n';
  code += "export 'client_extension.dart';\n";
  code += "export 'supadart_abstract_class.dart';\n";
  swagger.definitions.forEach((tableName, _) {
    final className = snakeCasingToPascaleCasing(tableName);
    tableName = classNameToFileName(className);
    code += "export '$tableName';\n";
  });
  return code;
}
