import '../utils/to_json_encodable.dart';
import '../swagger/table.dart';

String generateToJsonMethod(String className, Table table) {
  final columns = table.columns;
  final code = StringBuffer();

  // Method signature
  code.writeln('Map<String, dynamic> toJson() {');
  code.writeln(
      '// Promotion doesn\'t work well with public fields due to the possibility of the field being modified elsewhere.');

  List<String> vars = [];
  List<String> jsonVars = [];

  columns.forEach((columnName, columnDetails) {
    // Generate key-value pairs
    final dbColName = columnDetails.dbColName;
    final dartType = columnDetails.dartType;
    final postgresFormat = columnDetails.postgresFormat;

    final camelColName = columnDetails.camelColName;
    final tempVarName = 'final $camelColName = this.$camelColName;';
    vars.add(tempVarName);

    final jsonEncodable =
        toJsonEncodable(dartType, postgresFormat, camelColName, columnDetails);
    jsonVars.add("if ($camelColName != null) '$dbColName': $jsonEncodable");
  });

  code.writeln(vars.join('\n'));
  code.writeln('return {');
  code.writeln(jsonVars.join(',\n'));
  code.writeln('};');
  code.writeln('}');

  return code.toString();
}
