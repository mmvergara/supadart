import 'swagger.dart';

String generateStaticColumnNames(Map<String, Column> properties) {
  String code = "";
  properties.forEach((propertyName, _) {
    code += "static String get c_$propertyName => '$propertyName';\n";
  });
  return "$code\n";
}
