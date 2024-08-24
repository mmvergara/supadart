import '../swagger/column.dart';

String generateStaticColumnNames(Map<String, Column> properties) {
  String code = "";
  properties.forEach((propertyName, col) {
    code += "static String get c_$propertyName => '${col.dbColName}';\n";
  });
  return "$code\n";
}
