import '../swagger/column.dart';
import '../swagger/table.dart';

String generateFromJsonMethod(
    String className, Table table, bool jsonbToDynamic) {
  final columns = table.columns;
  final StringBuffer code = StringBuffer();

  code.writeln('factory $className.fromJson(Map<String, dynamic> jsonn) {');
  code.writeln('return $className(');

  columns.forEach((columnName, columnDetails) {
    code.writeln(
        '$columnName: ${decodeFromJson(columnDetails, jsonbToDynamic)},');
  });

  code.writeln(');');
  code.writeln('}');
  code.writeln();

  return code.toString();
}

String decodeFromJson(Column columnDetails, bool jsonbToDynamic) {
  final postgresFormat = columnDetails.postgresFormat;
  String jsonValue = 'jsonn[\'${columnDetails.dbColName}\']';
  String jsonDecode = "";
  if (jsonbToDynamic &&
      (postgresFormat == 'jsonb' || postgresFormat == 'jsonb[]')) {
    if (postgresFormat == 'jsonb') {
      jsonDecode = '$jsonValue as dynamic';
    } else {
      jsonDecode = '($jsonValue as List<dynamic>)';
    }
  } else {
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
            '($jsonValue as List<dynamic>).map((v) => json.decode(v) as Map<String, dynamic>).toList()';
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

      // case 'date':
      // case 'date[]':
      // case 'time without time zone':
      // case 'time without time zone[]':
      // case 'time with time zone':
      // case 'time with time zone[]':
      // case 'timestamp without time zone':
      // case 'timestamp without time zone[]':
      // case 'timestamp with time zone':
      // case 'timestamp with time zone[]':
      case 'date':
        jsonDecode = 'DateTime.parse($jsonValue.toString())';
        break;
      case 'date[]':
        jsonDecode =
            '($jsonValue as List<dynamic>).map((v) => DateTime.parse(v.toString())).toList()';
        break;
      case 'time without time zone':
      case 'time with time zone':
        jsonDecode = 'DateTime.parse("1970-01-01T\$${{jsonValue}}").toLocal()';
        break;
      case 'time without time zone[]':
      case 'time with time zone[]':
        jsonDecode =
            '($jsonValue as List<dynamic>).map((v) => DateTime.parse("1970-01-01T\$${"v"}").toLocal()).toList()';
        break;
      case 'timestamp without time zone':
      case 'timestamp with time zone':
        jsonDecode = 'DateTime.parse($jsonValue.toString())';
        break;
      case 'timestamp without time zone[]':
      case 'timestamp with time zone[]':
        jsonDecode =
            '($jsonValue as List<dynamic>).map((v) => DateTime.parse(v.toString())).toList()';
        break;

      case 'boolean':
        jsonDecode += '$jsonValue as bool';
        break;
      case 'boolean[]':
        jsonDecode +=
            '($jsonValue as List<dynamic>).map((v) => v as bool).toList()';
        break;

      case 'interval':
        jsonDecode = 'DurationFromString.fromString($jsonValue.toString())';
        break;

      case 'interval[]':
        jsonDecode =
            '($jsonValue as List<dynamic>).map((v) => DurationFromString.fromString(v.toString())).toList()';
        break;

      // These types will be prefixed with the schema PostGIS is installed in
      // (eg. extensions.geometry), and may optionally end with a specific
      // geometry type if specified for the column (eg. extensions.geometry(POINT),
      // extensions.geometry(LINESTRING)), so check that they contain name
      // anywhere in the string.
      case final String s when s.contains('geometry') && s.endsWith('[]'):
      case final String s when s.contains('geography') && s.endsWith('[]'):
        jsonDecode =
            '($jsonValue as List<String>).map((v) => GeometryBuilder.decodeHex($jsonValue.toString(), format: WKB.geometryExtended)).toList()';
        break;

      case final String s when s.contains('geometry'):
      case final String s when s.contains('geography'):
        jsonDecode =
            'GeometryBuilder.decodeHex($jsonValue.toString(), format: WKB.geometryExtended)';
        break;

      // NOT YET SUPPORTED TYPES ARE ENCODED TO STRINGS BY DEFAULT
      // NEED CONTRIBUTIONS TO SUPPORT THESE TYPES
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
        jsonDecode =
            "($jsonValue as List<dynamic>).map((e) => e.toString()).toList()";
        break;
      default:
        // check if its a vector
        if (postgresFormat.contains("vector") ||
            postgresFormat.contains("VECTOR")) {
          jsonDecode = '$jsonValue.toString()';
          break;
        }

        // check if the type is an enum type
        if (columnDetails.isEnum) {
          String enumName = columnDetails.dartType;
          if (postgresFormat.contains("[]")) {
            return '$jsonValue != null ? $enumName.from($jsonValue.map((e) => ${enumName.replaceAll("List<", "").replaceFirst(">", "")}.values.byName(e.toString())).toList()) : []';
          } else {
            return '$jsonValue != null ? $enumName.values.byName($jsonValue.toString()) : $enumName.values.first';
          }
        }

        // If the type is not supported, we will fallback to string type
        if (postgresFormat.contains("[]")) {
          jsonDecode =
              '($jsonValue as List<dynamic>).map((e) => e.toString()).toList()';
        } else {
          jsonDecode = '$jsonValue.toString()';
        }
    }
  }

  if (columnDetails.isNullable) {
    return '$jsonValue != null ? $jsonDecode : null';
  }

  return '$jsonValue != null ? $jsonDecode : ${dartTypeDefaultNullValue(columnDetails)}';
}

String dartTypeDefaultNullValue(Column columnDetails) {
  switch (columnDetails.dartType) {
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
      return 'DateTime.fromMillisecondsSinceEpoch(0)';
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
    case 'Geometry':
      return 'Point(Position.view(const [double.nan, double.nan]))';
    case 'List<Geometry>':
      return '<Geometry>[]';
    default:
      return 'Unsupported Dart type: please open an issue';
  }
}
