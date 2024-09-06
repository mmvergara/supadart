import '../swagger/table.dart';
import '../swagger/column.dart';

String generateGenerateMapPrivateMethod(Table table) {
  final columns = table.columns;
  final buffer = StringBuffer();

  buffer.writeln('static Map<String, dynamic> _generateMap({');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln('${columnDetails.dartType}? $columnName,');
  });

  buffer.writeln('}) {');

  buffer.writeln('return {');

  columns.forEach((columnName, columnDetails) {
    buffer.writeln(
      "if ($columnName != null) '${columnDetails.dbColName}': ${encodeToJson(columnDetails)},",
    );
  });

  buffer.writeln('};');
  buffer.writeln('}');

  return buffer.toString();
}

String encodeToJson(
  Column columnDetails,
) {
  final columnName = columnDetails.camelColName;
  String format = columnDetails.postgresFormat;
  bool isArray = format.contains("[]");

  String jsonEncodableType = '';
  switch (format) {
    case 'smallint':
    case 'integer':
    case 'smallint[]':
    case 'integer[]':
      jsonEncodableType = columnName;
      break;

    case 'bigint':
      jsonEncodableType = "$columnName.toString()";
      break;
    case 'bigint[]':
      jsonEncodableType = "$columnName.map((e) => e.toString()).toList()";
      break;

    case 'real':
    case 'real[]':
      jsonEncodableType = columnName;

    case 'double precision':
    case 'numeric':
      jsonEncodableType = '$columnName.toString()';
      break;
    case 'double precision[]':
    case 'numeric[]':
      jsonEncodableType = "$columnName.map((e) => e.toString()).toList()";
      break;

    case 'json':
    case 'jsonb':
      jsonEncodableType = columnName;
      break;

    case 'json[]':
    case 'jsonb[]':
      jsonEncodableType = '$columnName.map((e) => jsonEncode(e)).toList()';
      break;

    case 'text':
    case 'character varying':
    case 'character':
    case 'uuid':
      jsonEncodableType = columnName;
      break;
    case 'text[]':
    case 'character varying[]':
    case 'character[]':
    case 'uuid[]':
      jsonEncodableType = "$columnName.map((e) => e).toList()";
      break;

    case 'date':
      jsonEncodableType = "$columnName.toIso8601String()";
      break;
    case 'date[]':
      jsonEncodableType =
          "$columnName.map((e) => e.toIso8601String()).toList()";
      break;
    case 'time without time zone':
      jsonEncodableType = "DateFormat('HH:mm:ss.SSS').format($columnName)";
      break;
    case 'time without time zone[]':
      jsonEncodableType =
          "$columnName.map((e) => DateFormat('HH:mm:ss.SSS').format(e)).toList()";
      break;

    case 'time with time zone':
      jsonEncodableType = "DateFormat('HH:mm:ssZ').format($columnName.toUtc())";
      break;
    case 'time with time zone[]':
      jsonEncodableType =
          "$columnName.map((e) => DateFormat('HH:mm:ssZ').format(e.toUtc())).toList()";
      break;

    case 'timestamp without time zone':
      jsonEncodableType = "$columnName.toIso8601String()";
      break;
    case 'timestamp without time zone[]':
      jsonEncodableType =
          "$columnName.map((e) => e.toIso8601String()).toList()";
      break;
    case 'timestamp with time zone':
      jsonEncodableType = "$columnName.toUtc().toIso8601String()";
      break;
    case 'timestamp with time zone[]':
      jsonEncodableType =
          "$columnName.map((e) => e.toUtc().toIso8601String()).toList()";
      break;

    case 'boolean':
      jsonEncodableType = columnName;
      break;

    case 'boolean[]':
      jsonEncodableType = "$columnName.map((e) => e).toList()";
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
      jsonEncodableType = '$columnName.toString()';
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
      jsonEncodableType = "$columnName.map((e) => e.toString()).toList()";
      break;

    default:
      // If no format is provided, we assume it's a Enum
      if (columnDetails.enumValues.isNotEmpty) {
        jsonEncodableType = isArray
            ? "$columnName.map((e) => e.toString().split('.').last).toList()"
            : "$columnName.toString().split('.').last";
        break;
      }
  }
  return jsonEncodableType;
}
