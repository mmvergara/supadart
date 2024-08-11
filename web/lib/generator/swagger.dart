import 'dart:convert';

import 'format_to_dart_type.dart';
import 'package:http/http.dart' as http;

Future<DatabaseSwagger?> fetchDatabaseSwagger(
    String url, String anonKey) async {
  final response = await http.get(Uri.parse('$url/rest/v1/?apikey=$anonKey'));
  String responseBody = "";
  if (response.statusCode == 200) {
    return DatabaseSwagger.fromJson(jsonDecode(response.body));
  } else {
    print("Error Fetching Supabase Swagger");
    responseBody = response.body;
  }

  print("Trying without the api key...");
  final response2 = await http.get(Uri.parse('$url/rest/v1/'));
  if (response2.statusCode == 200) {
    print("Fetched Supabase Swagger!");
    return DatabaseSwagger.fromJson(jsonDecode(response.body));
  }

  print(responseBody);
  return null;
}

class DatabaseSwagger {
  final Map<String, Table> definitions;

  DatabaseSwagger(this.definitions);

  factory DatabaseSwagger.fromJson(Map<String, dynamic> json) {
    final definitions = json['definitions'] as Map<String, dynamic>;
    return DatabaseSwagger(
      definitions
          .map((key, value) => MapEntry(key, Table.fromJson(key, value))),
    );
  }
}

// Class to represent a database table
class Table {
  final String name;
  final List<String> requiredFields;
  final Map<String, Column> columns;

  Table({
    required this.name,
    required this.requiredFields,
    required this.columns,
  });

  factory Table.fromJson(String name, Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;
    return Table(
      name: name,
      requiredFields: json['required'] != null
          ? List<String>.from(json['required'])
          : <String>[],
      columns:
          properties.map((key, value) => MapEntry(key, Column.fromJson(value))),
    );
  }
}

// Class to represent a database column
class Column {
  final String postgresFormat;
  final List<String> enumValues;
  final dynamic defaultValue;
  final String? description;
  final int? maxLength;
  final bool isPrimaryKey;
  final bool isSerialType;

  Column({
    required this.postgresFormat,
    this.enumValues = const [],
    this.defaultValue,
    this.description,
    this.maxLength,
    this.isPrimaryKey = false,
    this.isSerialType = false,
  });

  String get dartType {
    if (enumValues.isNotEmpty) {
      return postgresFormat.split(".").last.toUpperCase();
    }
    return postgresFormatToDartType(postgresFormat).type;
  }

  bool get hasDefaultValue => defaultValue != null;

  factory Column.fromJson(Map<String, dynamic> json) {
    return Column(
      postgresFormat: json['format'],
      enumValues:
          json['enum'] != null ? List<String>.from(json['enum']) : <String>[],
      defaultValue: json['default'],
      description: json['description'],
      maxLength: json['maxLength'],
      isPrimaryKey: json['description']?.contains('<pk/>') ?? false,
      isSerialType: json['description']?.contains('[supadart:serial]') ?? false,
    );
  }
}
