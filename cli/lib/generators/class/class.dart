import 'package:supadart/generators/class/generate_map.dart';

import '../class/to_json.dart';
import '../swagger/table.dart';
import '../utils/string_formatters.dart';
import '../swagger/swagger.dart';
import 'from_json.dart';
import 'converters.dart';
import 'update.dart';
import 'insert.dart';
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
    final code = StringBuffer();
    final className = tableNameToClassName(tableName, mappings);

    // Class definition
    code.writeln('class $className implements SupadartClass<$className> {');
    code.write(generateHasEnumsIndicator(table));
    code.write(generateAttributes(table));
    code.write(generateConstructor(className, table));

    // Table name
    code.writeln("static String get table_name => '$tableName';");

    // Static column names
    code.write(generateStaticColumnNames(table));

    // Methods
    code.write(generateConverterMethod(className));
    code.write(generateConverterSingleMethod(className));
    code.write(generateGenerateMapPrivateMethod(table));
    code.write(generateInsertMethod(table));
    code.write(generateUpdateMethod(table));
    code.write(generateFromJsonMethod(className, table));
    code.write(generateToJsonMethod(className, table));
    code.writeln('}');
    code.writeln();

    generatedClasses.add(
      DartClass(
        className: className,
        classCode: code.toString(),
      ),
    );
  });
  return generatedClasses;
}

String generateHasEnumsIndicator(Table table) {
  final columns = table.columns;
  final hasEnums = columns.values.any((column) => column.enumValues.isNotEmpty);
  return hasEnums ? '// [supadart:has_enums]\n' : '';
}

String generateAttributes(Table table) {
  final columns = table.columns;
  final requiredFields = table.requiredFields;
  final code = StringBuffer();
  columns.forEach((columnName, columnDetails) {
    final isOptional = !requiredFields.contains(columnName);
    code.writeln(
        'final ${columnDetails.dartType}${isOptional ? "?" : ""} $columnName;');
  });
  return code.toString();
}

String generateConstructor(String className, Table table) {
  final columns = table.columns;
  final requiredFields = table.requiredFields;
  final code = StringBuffer();
  code.writeln('\nconst $className({');
  columns.forEach((propertyName, _) {
    final isRequired = requiredFields.contains(propertyName);
    code.writeln('${isRequired ? "required this." : "this."}$propertyName,');
  });
  code.writeln('});');
  code.writeln();
  return code.toString();
}

String generateStaticColumnNames(Table table) {
  final columns = table.columns;
  final code = StringBuffer();
  columns.forEach((propertyName, col) {
    code.writeln("static String get c_$propertyName => '${col.dbColName}';");
  });
  code.writeln();
  return code.toString();
}
