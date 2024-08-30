import '../swagger/table.dart';

String generateInsertMethod(Table table) {
  final columns = table.columns;
  final StringBuffer code = StringBuffer();

  // Method signature
  code.writeln('static Map<String, dynamic> insert({');

  // Generate parameters
  for (final entry in columns.entries) {
    final columnName = entry.key;
    final columnDetails = entry.value;
    final isRequired = columnDetails.isRequired;
    final dartType = columnDetails.dartType;

    code.writeln(
        '  ${isRequired ? "required " : ""}$dartType${isRequired ? "" : "?"} $columnName,');
  }
  code.writeln('}) {');

  code.writeln('return _generateMap(');

  for (final entry in columns.entries) {
    final columnName = entry.key;
    code.writeln('  $columnName: $columnName,');
  }

  code.writeln(');');

  // // Method body
  // code.writeln('  return {');
  // // Generate key-value pairs
  // for (final entry in columns.entries) {
  //   final columnName = entry.key;
  //   final columnDetails = entry.value;
  //   final isRequired = columnDetails.isRequired;
  //   final dbColName = columnDetails.dbColName;
  //   final dartType = columnDetails.dartType;
  //   final postgresFormat = columnDetails.postgresFormat;

  //   final jsonEncodable =
  //       toJsonEncodable(dartType, postgresFormat, columnName, columnDetails);

  //   if (isRequired) {
  //     code.writeln("    '$dbColName': $jsonEncodable,");
  //   } else {
  //     code.writeln(
  //         "    if ($columnName != null) '$dbColName': $jsonEncodable,");
  //   }
  // }
  // code.writeln('  };');

  code.writeln('}');

  return code.toString();
}
