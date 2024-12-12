import 'table.dart';

class DatabaseSwagger {
  final Map<String, Table> definitions;

  DatabaseSwagger(this.definitions);

  factory DatabaseSwagger.fromJson(
      Map<String, dynamic> json, Map<String, List<String>> mapOfEnums) {
    final definitions = json['definitions'] as Map<String, dynamic>;
    return DatabaseSwagger(
      definitions.map((key, value) =>
          MapEntry(key, Table.fromJson(key, value, mapOfEnums))),
    );
  }
}
