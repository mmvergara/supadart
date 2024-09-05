import '../swagger/table.dart';
import '../swagger/column.dart';

String generateFromJsonMethod(String className, Table table) {
  final columns = table.columns;
  final StringBuffer code = StringBuffer();

  code.writeln('factory $className.fromJson(Map<String, dynamic> json) {');
  code.writeln('return $className(');

  columns.forEach((columnName, columnDetails) {
    code.writeln('$columnName: ${decodeFromJson(columnDetails)},');
  });

  code.writeln(');');
  code.writeln('}');
  code.writeln();

  return code.toString();
}

String decodeFromJson(Column columnDetails) {
  final postgresFormat = columnDetails.postgresFormat;
  final dartType = columnDetails.dartType;
  String jsonValue = 'json[\'${columnDetails.dbColName}\']';
  String jsonDecode = "";

  switch (postgresFormat) {
    case 'smallint':
    case 'integer':
      jsonDecode = 'int.parse($jsonValue.toString())';
      break;
    case 'smallint[]':
    case 'integer[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => int.parse(v.toString())).toList()';
      break;

    case 'bigint':
      jsonDecode = 'BigInt.parse($jsonValue.toString())';
      break;
    case 'bigint[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => BigInt.parse(v.toString())).toList()';
      break;

    case 'real':
    case 'double precision':
      jsonDecode = 'double.parse($jsonValue.toString())';
      break;

    case 'real[]':
    case 'double precision[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => double.parse(v.toString())).toList()';
      break;

    case 'numeric':
      jsonDecode = 'num.parse($jsonValue.toString())';
      break;
    case 'numeric[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => num.parse(v.toString())).toList()';
      break;

    case 'json':
    case 'jsonb':
      jsonDecode = '$jsonValue as Map<String, dynamic>';
      break;
    case 'json[]':
    case 'jsonb[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => v as Map<String, dynamic>).toList()';
      break;

    case 'text':
    case 'character varying':
    case 'character':
    case 'uuid':
      jsonDecode = '$jsonValue.toString()';
      break;

    case 'text[]':
    case 'character varying[]':
    case 'character[]':
    case 'uuid[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => v.toString()).toList()';
      break;

    case 'date':
    case 'timestamp without time zone':
    case 'timestamp with time zone':
      jsonDecode = 'DateTime.tryParse($jsonValue.toString()) as DateTime';
      break;
    case 'date[]':
    case 'timestamp without time zone[]':
    case 'timestamp with time zone[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => DateTime.tryParse(v.toString()) as DateTime).toList()';
      break;

    case 'time without time zone':
    case 'time with time zone':
      jsonDecode +=
          'DateTime.tryParse("1970-01-01T\$${{jsonValue}}") as DateTime';
      break;
    case 'time without time zone[]':
    case 'time with time zone[]':
      jsonDecode =
          '($jsonValue as List<dynamic>).map((v) => DateTime.tryParse("1970-01-01T\$v") as DateTime).toList()';
      break;

    case 'boolean':
      jsonDecode += '$jsonValue as bool';
      break;
    case 'boolean[]':
      jsonDecode +=
          '($jsonValue as List<dynamic>).map((v) => v as bool).toList()';
      break;

    // NOT YET SUPPORTED TYPES ARE ENCODED TO STRINGS BY DEFAULT
    // NEED CONTRIBUTIONS TO SUPPORT THESE TYPES
    case 'interval':
    case 'bytea':
    case 'inet':
    case 'cidr':
    case 'macaddr':
    case 'macaddr8':
    case 'point':
    case 'line':
    case 'lseg':
    case 'box':
    case 'path':
    case 'polygon':
    case 'circle':
    case 'bit':
    case 'bit varying':
    case 'money':
    case 'tsquery':
    case 'tsvector':
    case 'xml':
    case 'pg_lsn':
    case 'pg_snapshot':
    case 'txid_snapshot':
      jsonDecode = '$jsonValue.toString()';
      break;
    case 'interval[]':
    case 'bytea[]':
    case 'inet[]':
    case 'cidr[]':
    case 'macaddr[]':
    case 'macaddr8[]':
    case 'point[]':
    case 'line[]':
    case 'lseg[]':
    case 'box[]':
    case 'path[]':
    case 'polygon[]':
    case 'circle[]':
    case 'bit[]':
    case 'bit varying[]':
    case 'money[]':
    case 'tsquery[]':
    case 'tsvector[]':
    case 'xml[]':
    case 'pg_lsn[]':
    case 'pg_snapshot[]':
    case 'txid_snapshot[]':
      jsonDecode = "$jsonValue.map((e) => e.toString()).toList()";
      break;

    default:
      // if no type is found it is assumed to be an enum type
      String enumName = columnDetails.dartType;
      return '$jsonValue != null ? $enumName.values.byName($jsonValue.toString()) : $enumName.values.first';
  }
  String code =
      '$jsonValue != null ? $jsonDecode : ${dartTypeDefaultNullValue(dartType)}';
  return code;
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
