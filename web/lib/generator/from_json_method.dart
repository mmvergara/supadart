import 'format_to_dart_type.dart';
import 'swagger.dart';

String generateFromJsonMethod(String className, Map<String, Column> columns,
    List<String> requiredFields) {
  String code = 'factory $className.fromJson(Map<String, dynamic> json) {\n';
  code += 'return $className(\n';
  columns.forEach((columnName, columnDetails) {
    // final isRequired = requiredFields.contains(columnName);
    final dartType = postgresFormatToDartType(columnDetails.postgresFormat);
    code +=
        '$columnName: ${parseWrapper(dartType.type, columnDetails.postgresFormat, 'json[\'$columnName\']')},\n';
  });
  code += ');\n';
  code += '}\n\n';
  return code;
}

String parseWrapper(String dartType, String format, String jsonValue) {
  bool isArray = format.contains('[]');
  if (isArray) {
    format = format.replaceAll('[]', '');
  }
  String output = '$jsonValue != null ?';

  switch (dartType) {
    // ====================
    case 'int':
      output += '$jsonValue as int';
      break;
    case 'List<int>':
      output += '($jsonValue as List<dynamic>).map((v) => v as int).toList()';
      break;
    // ====================
    case 'BigInt':
      output += 'BigInt.tryParse($jsonValue.toString()) as BigInt';
      break;
    case 'List<BigInt>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => BigInt.tryParse(v.toString()) as BigInt).toList()';
      break;
    // ====================
    case 'double':
      output += 'double.tryParse($jsonValue.toString())';
      break;
    case 'List<double>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => double.tryParse(v.toString()) as double).toList()';
      break;
    // ====================
    case 'num':
      output += 'num.tryParse($jsonValue.toString())';
      break;
    case 'List<num>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => num.tryParse(v.toString()) as num).toList()';
      break;
    // ====================
    case 'bool':
      output += '$jsonValue as bool';
      break;
    case 'List<bool>':
      output += '($jsonValue as List<dynamic>).map((v) => v as bool).toList()';
      break;
    // ====================
    case 'String':
      output += '$jsonValue.toString()';
      break;
    case 'List<String>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => v as String).toList()';
      break;
    // ====================
    case 'DateTime':
      if (format == 'time without time zone') {
        jsonValue += '.toString()';
        output +=
            'DateTime.tryParse("1970-01-01T\$${{jsonValue}}") as DateTime';
        break;
      }
      if (format == 'time with time zone') {
        jsonValue += '.toString()';
        output +=
            'DateTime.tryParse("1970-01-01T\$${{jsonValue}}") as DateTime';
        break;
      }
      jsonValue += '.toString()';
      output += 'DateTime.tryParse($jsonValue) as DateTime';
      break;
    case 'List<DateTime>':
      if (format == 'time without time zone') {
        output +=
            '($jsonValue as List<dynamic>).map((v) => DateTime.tryParse("1970-01-01T\${v.toString()}") as DateTime).toList()';
        break;
      }
      if (format == 'time with time zone') {
        output +=
            '($jsonValue as List<dynamic>).map((v) => DateTime.tryParse("1970-01-01T\${v.toString()}") as DateTime).toList()';
        break;
      }
      output +=
          '($jsonValue as List<dynamic>).map((v) => DateTime.tryParse(v.toString()) as DateTime).toList()';
      break;
    // ====================
    case 'Duration':
      output += '$jsonValue as Duration';
      break;
    case 'List<Duration>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => v as Duration).toList()';
      break;
    // ====================
    case 'Map<String, dynamic>':
      output += '$jsonValue as Map<String, dynamic>';
      break;
    case 'List<Map<String, dynamic>>':
      output +=
          '($jsonValue as List<dynamic>).map((v) => v as Map<String, dynamic>).toList()';
      break;
    // ====================
    default:
      output += 'Something went wrong, please open an issue on this';
      break;
  }
  // Add Null Default Value, This will enable the support for column selection
  output += ' : ${dartTypeDefaultNullValue(dartType)}';
  return output;
}

String dartTypeDefaultNullValue(String dartType) {
  switch (dartType) {
    case 'int':
      return '0';
    case 'BigInt':
      return 'BigInt.from(0)';
    case 'double':
      return '0.0';
    case 'num':
      return '0';
    case 'bool':
      return 'false';
    case 'String':
      return "''"; // Empty string as default
    case 'DateTime':
      return 'DateTime.fromMillisecondsSinceEpoch(0)'; // Using Unix epoch as default
    case 'Duration':
      return 'Duration()'; // Assuming duration in milliseconds
    case 'Map<String, dynamic>':
      return '<String, dynamic>{}';
    case 'List<int>':
      return '<int>[]';
    case 'List<BigInt>':
      return '<BigInt>[]';
    case 'List<double>':
      return '<double>[]';
    case 'List<num>':
      return '<num>[]';
    case 'List<bool>':
      return '<bool>[]';
    case 'List<String>':
      return '<String>[]';
    case 'List<DateTime>':
      return '<DateTime>[]';
    case 'List<Duration>':
      return '<Duration>[]';
    case 'List<Map<String, dynamic>>':
      return '<Map<String, dynamic>>[]';
    default:
      return 'Unsupported Dart type: please open an issue';
  }
}
