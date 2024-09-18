import '../class/generate_map.dart';
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
  return swagger.definitions.entries.map((entry) {
    final tableName = entry.key;
    final table = entry.value;
    final className = tableNameToClassName(tableName, mappings);

    final code = StringBuffer()
      ..writeln('class $className implements SupadartClass<$className> {')
      ..write(generateAttributes(table))
      ..write(generateConstructor(className, table))
      ..writeln("static String get table_name => '$tableName';")
      ..write(generateStaticColumnNames(table))
      ..write(generateConverterMethod(className))
      ..write(generateConverterSingleMethod(className))
      ..write(generateGenerateMapPrivateMethod(table))
      ..write(generateInsertMethod(table))
      ..write(generateUpdateMethod(table))
      ..write(generateFromJsonMethod(className, table))
      ..write(generateToJsonMethod(className, table))
      ..writeln('}')
      ..writeln();

    return DartClass(
      className: className,
      classCode: code.toString(),
    );
  }).toList();
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
