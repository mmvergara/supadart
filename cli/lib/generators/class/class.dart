import '../swagger/column.dart';

import 'from_json.dart';
import 'converters.dart';
import 'static_column_names.dart';
import 'update.dart';
import 'insert.dart';
import 'to_json.dart';

import '../utils/string_formatters.dart';

import '../swagger/swagger.dart';
import 'package:yaml/yaml.dart';

class DartClass {
  final String className;
  final String classCode;

  DartClass({
    required this.className,
    required this.classCode,
  });
}

List<DartClass> generateDartClasses(
    DatabaseSwagger swagger, YamlMap? mappings) {
  List<DartClass> generatedClasses = [];
  swagger.definitions.forEach((tableName, table) {
    String code = "";

    final columns = table.columns;
    final requiredFields = table.requiredFields;
    final className = tableNameToClassName(tableName, mappings);

    code += 'class $className implements SupadartClass<$className> {\n';

    code += generateHasEnumsIndicator(columns);
    code += generateAttributes(columns, requiredFields);
    code += generateConstructor(className, columns, requiredFields);

    // Table name
    code += 'static String get table_name => \'$tableName\';\n';

    // Static column names
    code += generateStaticColumnNames(columns);
    // Methods
    code += generateConverterMethod(className);
    code += generateConverterSingleMethod(className);
    code += generateInsertMethod(columns, requiredFields);
    code += generateUpdateMethod(columns);
    code += generateFromJsonMethod(className, columns, requiredFields);
    code += generateToJsonMethod(className, columns);

    code += '}\n\n';
    generatedClasses.add(
      DartClass(
        className: className,
        classCode: code,
      ),
    );
  });

  return generatedClasses;
}

String generateHasEnumsIndicator(Map<String, Column> columns) {
  final hasEnums = columns.values.any((column) => column.enumValues.isNotEmpty);
  return hasEnums ? '// [supadart:has_enums]\n' : '';
}

String generateAttributes(
    Map<String, Column> columns, List<String> requiredFields) {
  String code = '';
  columns.forEach((columnName, columnDetails) {
    final isOptional = !requiredFields.contains(columnName);
    code +=
        'final ${columnDetails.dartType}${isOptional ? "?" : ""} $columnName;\n';
  });
  return code;
}

String generateConstructor(String className, Map<String, Column> columns,
    List<String> requiredFields) {
  String code = '\n const $className({\n';
  columns.forEach((propertyName, _) {
    final isRequired = requiredFields.contains(propertyName);
    code += '${isRequired ? "required this." : "this."}$propertyName,\n';
  });
  code += '});\n\n';
  return code;
}
