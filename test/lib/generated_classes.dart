// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names
import 'package:supabase/supabase.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
// INTL is an official package from dart and is used for parsing dates
// flutter pub add intl or dart pub add intl

// THIS FILE IS AUTO GENERATED. MODIFY WITH CAUTION

extension SupadartClient on SupabaseClient {
  SupabaseQueryBuilder get string_types {
    return from('string_types');
  }

  SupabaseQueryBuilder get boolean_bit_types {
    return from('boolean_bit_types');
  }

  SupabaseQueryBuilder get misc_types {
    return from('misc_types');
  }

  SupabaseQueryBuilder get books {
    return from('books');
  }

  SupabaseQueryBuilder get geometric_types {
    return from('geometric_types');
  }

  SupabaseQueryBuilder get json_types {
    return from('json_types');
  }

  SupabaseQueryBuilder get binary_xml_types {
    return from('binary_xml_types');
  }

  SupabaseQueryBuilder get network_types {
    return from('network_types');
  }

  SupabaseQueryBuilder get numeric_types {
    return from('numeric_types');
  }

  SupabaseQueryBuilder get datetime_types {
    return from('datetime_types');
  }
}

abstract class SupadartClass<T> {
  static Map<String, dynamic> insert(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  static Map<String, dynamic> update(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  factory SupadartClass.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class StringTypes implements SupadartClass<StringTypes> {
  final String id;
  final String? col_uuid;
  final List<String>? col_uuid_array;
  final String? col_character;
  final List<String>? col_character_array;
  final String? col_charactervarying;
  final List<String>? col_charactervarying_array;
  final String? col_text;
  final List<String>? col_text_array;

  const StringTypes({
    required this.id,
    this.col_uuid,
    this.col_uuid_array,
    this.col_character,
    this.col_character_array,
    this.col_charactervarying,
    this.col_charactervarying_array,
    this.col_text,
    this.col_text_array,
  });

  static String get table_name => 'string_types';
  static String get c_id => 'id';
  static String get c_col_uuid => 'col_uuid';
  static String get c_col_uuid_array => 'col_uuid_array';
  static String get c_col_character => 'col_character';
  static String get c_col_character_array => 'col_character_array';
  static String get c_col_charactervarying => 'col_charactervarying';
  static String get c_col_charactervarying_array =>
      'col_charactervarying_array';
  static String get c_col_text => 'col_text';
  static String get c_col_text_array => 'col_text_array';
  static Map<String, dynamic> insert({
    String? id,
    String? col_uuid,
    List<String>? col_uuid_array,
    String? col_character,
    List<String>? col_character_array,
    String? col_charactervarying,
    List<String>? col_charactervarying_array,
    String? col_text,
    List<String>? col_text_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_uuid != null) 'col_uuid': col_uuid.toString(),
      if (col_uuid_array != null)
        'col_uuid_array':
            col_uuid_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_character != null) 'col_character': col_character.toString(),
      if (col_character_array != null)
        'col_character_array': col_character_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_charactervarying != null)
        'col_charactervarying': col_charactervarying.toString(),
      if (col_charactervarying_array != null)
        'col_charactervarying_array': col_charactervarying_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_text != null) 'col_text': col_text.toString(),
      if (col_text_array != null)
        'col_text_array':
            col_text_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_uuid,
    List<String>? col_uuid_array,
    String? col_character,
    List<String>? col_character_array,
    String? col_charactervarying,
    List<String>? col_charactervarying_array,
    String? col_text,
    List<String>? col_text_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_uuid != null) 'col_uuid': col_uuid.toString(),
      if (col_uuid_array != null)
        'col_uuid_array':
            col_uuid_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_character != null) 'col_character': col_character.toString(),
      if (col_character_array != null)
        'col_character_array': col_character_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_charactervarying != null)
        'col_charactervarying': col_charactervarying.toString(),
      if (col_charactervarying_array != null)
        'col_charactervarying_array': col_charactervarying_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_text != null) 'col_text': col_text.toString(),
      if (col_text_array != null)
        'col_text_array':
            col_text_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  factory StringTypes.fromJson(Map<String, dynamic> json) {
    return StringTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_uuid: json['col_uuid'] != null ? json['col_uuid'].toString() : '',
      col_uuid_array: json['col_uuid_array'] != null
          ? (json['col_uuid_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_character:
          json['col_character'] != null ? json['col_character'].toString() : '',
      col_character_array: json['col_character_array'] != null
          ? (json['col_character_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_charactervarying: json['col_charactervarying'] != null
          ? json['col_charactervarying'].toString()
          : '',
      col_charactervarying_array: json['col_charactervarying_array'] != null
          ? (json['col_charactervarying_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_text: json['col_text'] != null ? json['col_text'].toString() : '',
      col_text_array: json['col_text_array'] != null
          ? (json['col_text_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class BooleanBitTypes implements SupadartClass<BooleanBitTypes> {
  final String id;
  final bool? col_boolean;
  final List<bool>? col_boolean_array;
  final String? col_bit;
  final List<String>? col_bit_array;
  final String? col_bitvarying;
  final List<String>? col_bitvarying_array;

  const BooleanBitTypes({
    required this.id,
    this.col_boolean,
    this.col_boolean_array,
    this.col_bit,
    this.col_bit_array,
    this.col_bitvarying,
    this.col_bitvarying_array,
  });

  static String get table_name => 'boolean_bit_types';
  static String get c_id => 'id';
  static String get c_col_boolean => 'col_boolean';
  static String get c_col_boolean_array => 'col_boolean_array';
  static String get c_col_bit => 'col_bit';
  static String get c_col_bit_array => 'col_bit_array';
  static String get c_col_bitvarying => 'col_bitvarying';
  static String get c_col_bitvarying_array => 'col_bitvarying_array';
  static Map<String, dynamic> insert({
    String? id,
    bool? col_boolean,
    List<bool>? col_boolean_array,
    String? col_bit,
    List<String>? col_bit_array,
    String? col_bitvarying,
    List<String>? col_bitvarying_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_boolean != null) 'col_boolean': col_boolean.toString(),
      if (col_boolean_array != null)
        'col_boolean_array': col_boolean_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_bit != null) 'col_bit': col_bit.toString(),
      if (col_bit_array != null)
        'col_bit_array':
            col_bit_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_bitvarying != null) 'col_bitvarying': col_bitvarying.toString(),
      if (col_bitvarying_array != null)
        'col_bitvarying_array': col_bitvarying_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    bool? col_boolean,
    List<bool>? col_boolean_array,
    String? col_bit,
    List<String>? col_bit_array,
    String? col_bitvarying,
    List<String>? col_bitvarying_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_boolean != null) 'col_boolean': col_boolean.toString(),
      if (col_boolean_array != null)
        'col_boolean_array': col_boolean_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_bit != null) 'col_bit': col_bit.toString(),
      if (col_bit_array != null)
        'col_bit_array':
            col_bit_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_bitvarying != null) 'col_bitvarying': col_bitvarying.toString(),
      if (col_bitvarying_array != null)
        'col_bitvarying_array': col_bitvarying_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory BooleanBitTypes.fromJson(Map<String, dynamic> json) {
    return BooleanBitTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_boolean:
          json['col_boolean'] != null ? json['col_boolean'] as bool : false,
      col_boolean_array: json['col_boolean_array'] != null
          ? (json['col_boolean_array'] as List<dynamic>)
              .map((v) => v as bool)
              .toList()
          : <bool>[],
      col_bit: json['col_bit'] != null ? json['col_bit'].toString() : '',
      col_bit_array: json['col_bit_array'] != null
          ? (json['col_bit_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_bitvarying: json['col_bitvarying'] != null
          ? json['col_bitvarying'].toString()
          : '',
      col_bitvarying_array: json['col_bitvarying_array'] != null
          ? (json['col_bitvarying_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class MiscTypes implements SupadartClass<MiscTypes> {
  final String id;
  final String? col_money;
  final List<String>? col_money_array;
  final String? col_pg_lsn;
  final List<String>? col_pg_lsn_array;
  final String? col_pg_snapshot;
  final List<String>? col_pg_snapshot_array;
  final String? col_tsquery;
  final List<String>? col_tsquery_array;
  final String? col_tsvector;
  final List<String>? col_tsvector_array;
  final String? col_txid_snapshot;
  final List<String>? col_txid_snapshot_array;

  const MiscTypes({
    required this.id,
    this.col_money,
    this.col_money_array,
    this.col_pg_lsn,
    this.col_pg_lsn_array,
    this.col_pg_snapshot,
    this.col_pg_snapshot_array,
    this.col_tsquery,
    this.col_tsquery_array,
    this.col_tsvector,
    this.col_tsvector_array,
    this.col_txid_snapshot,
    this.col_txid_snapshot_array,
  });

  static String get table_name => 'misc_types';
  static String get c_id => 'id';
  static String get c_col_money => 'col_money';
  static String get c_col_money_array => 'col_money_array';
  static String get c_col_pg_lsn => 'col_pg_lsn';
  static String get c_col_pg_lsn_array => 'col_pg_lsn_array';
  static String get c_col_pg_snapshot => 'col_pg_snapshot';
  static String get c_col_pg_snapshot_array => 'col_pg_snapshot_array';
  static String get c_col_tsquery => 'col_tsquery';
  static String get c_col_tsquery_array => 'col_tsquery_array';
  static String get c_col_tsvector => 'col_tsvector';
  static String get c_col_tsvector_array => 'col_tsvector_array';
  static String get c_col_txid_snapshot => 'col_txid_snapshot';
  static String get c_col_txid_snapshot_array => 'col_txid_snapshot_array';
  static Map<String, dynamic> insert({
    String? id,
    String? col_money,
    List<String>? col_money_array,
    String? col_pg_lsn,
    List<String>? col_pg_lsn_array,
    String? col_pg_snapshot,
    List<String>? col_pg_snapshot_array,
    String? col_tsquery,
    List<String>? col_tsquery_array,
    String? col_tsvector,
    List<String>? col_tsvector_array,
    String? col_txid_snapshot,
    List<String>? col_txid_snapshot_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_money != null) 'col_money': col_money.toString(),
      if (col_money_array != null)
        'col_money_array': col_money_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_pg_lsn != null) 'col_pg_lsn': col_pg_lsn.toString(),
      if (col_pg_lsn_array != null)
        'col_pg_lsn_array': col_pg_lsn_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_pg_snapshot != null)
        'col_pg_snapshot': col_pg_snapshot.toString(),
      if (col_pg_snapshot_array != null)
        'col_pg_snapshot_array': col_pg_snapshot_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_tsquery != null) 'col_tsquery': col_tsquery.toString(),
      if (col_tsquery_array != null)
        'col_tsquery_array': col_tsquery_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_tsvector != null) 'col_tsvector': col_tsvector.toString(),
      if (col_tsvector_array != null)
        'col_tsvector_array': col_tsvector_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_txid_snapshot != null)
        'col_txid_snapshot': col_txid_snapshot.toString(),
      if (col_txid_snapshot_array != null)
        'col_txid_snapshot_array': col_txid_snapshot_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_money,
    List<String>? col_money_array,
    String? col_pg_lsn,
    List<String>? col_pg_lsn_array,
    String? col_pg_snapshot,
    List<String>? col_pg_snapshot_array,
    String? col_tsquery,
    List<String>? col_tsquery_array,
    String? col_tsvector,
    List<String>? col_tsvector_array,
    String? col_txid_snapshot,
    List<String>? col_txid_snapshot_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_money != null) 'col_money': col_money.toString(),
      if (col_money_array != null)
        'col_money_array': col_money_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_pg_lsn != null) 'col_pg_lsn': col_pg_lsn.toString(),
      if (col_pg_lsn_array != null)
        'col_pg_lsn_array': col_pg_lsn_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_pg_snapshot != null)
        'col_pg_snapshot': col_pg_snapshot.toString(),
      if (col_pg_snapshot_array != null)
        'col_pg_snapshot_array': col_pg_snapshot_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_tsquery != null) 'col_tsquery': col_tsquery.toString(),
      if (col_tsquery_array != null)
        'col_tsquery_array': col_tsquery_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_tsvector != null) 'col_tsvector': col_tsvector.toString(),
      if (col_tsvector_array != null)
        'col_tsvector_array': col_tsvector_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_txid_snapshot != null)
        'col_txid_snapshot': col_txid_snapshot.toString(),
      if (col_txid_snapshot_array != null)
        'col_txid_snapshot_array': col_txid_snapshot_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory MiscTypes.fromJson(Map<String, dynamic> json) {
    return MiscTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_money: json['col_money'] != null ? json['col_money'].toString() : '',
      col_money_array: json['col_money_array'] != null
          ? (json['col_money_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_pg_lsn:
          json['col_pg_lsn'] != null ? json['col_pg_lsn'].toString() : '',
      col_pg_lsn_array: json['col_pg_lsn_array'] != null
          ? (json['col_pg_lsn_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_pg_snapshot: json['col_pg_snapshot'] != null
          ? json['col_pg_snapshot'].toString()
          : '',
      col_pg_snapshot_array: json['col_pg_snapshot_array'] != null
          ? (json['col_pg_snapshot_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_tsquery:
          json['col_tsquery'] != null ? json['col_tsquery'].toString() : '',
      col_tsquery_array: json['col_tsquery_array'] != null
          ? (json['col_tsquery_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_tsvector:
          json['col_tsvector'] != null ? json['col_tsvector'].toString() : '',
      col_tsvector_array: json['col_tsvector_array'] != null
          ? (json['col_tsvector_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_txid_snapshot: json['col_txid_snapshot'] != null
          ? json['col_txid_snapshot'].toString()
          : '',
      col_txid_snapshot_array: json['col_txid_snapshot_array'] != null
          ? (json['col_txid_snapshot_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class Books implements SupadartClass<Books> {
  final BigInt id;
  final String name;
  final String? description;
  final int price;
  final DateTime created_at;

  const Books({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.created_at,
  });

  static String get table_name => 'books';
  static String get c_id => 'id';
  static String get c_name => 'name';
  static String get c_description => 'description';
  static String get c_price => 'price';
  static String get c_created_at => 'created_at';
  static Map<String, dynamic> insert({
    BigInt? id,
    required String name,
    String? description,
    required int price,
    DateTime? created_at,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      'name': name.toString(),
      if (description != null) 'description': description.toString(),
      'price': price.toString(),
      if (created_at != null) 'created_at': created_at.toUtc().toString(),
    };
  }

  static Map<String, dynamic> update({
    BigInt? id,
    String? name,
    String? description,
    int? price,
    DateTime? created_at,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (name != null) 'name': name.toString(),
      if (description != null) 'description': description.toString(),
      if (price != null) 'price': price.toString(),
      if (created_at != null) 'created_at': created_at.toUtc().toString(),
    };
  }

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id'] != null
          ? BigInt.tryParse(json['id'].toString()) as BigInt
          : BigInt.from(0),
      name: json['name'] != null ? json['name'].toString() : '',
      description:
          json['description'] != null ? json['description'].toString() : '',
      price: json['price'] != null ? json['price'] as int : 0,
      created_at: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class GeometricTypes implements SupadartClass<GeometricTypes> {
  final String id;
  final String? col_point;
  final List<String>? col_point_array;
  final String? col_line;
  final List<String>? col_line_array;
  final String? col_lseg;
  final List<String>? col_lseg_array;
  final String? col_box;
  final List<String>? col_box_array;
  final String? col_path;
  final List<String>? col_path_array;
  final String? col_polygon;
  final List<String>? col_polygon_array;
  final String? col_circle;
  final List<String>? col_circle_array;

  const GeometricTypes({
    required this.id,
    this.col_point,
    this.col_point_array,
    this.col_line,
    this.col_line_array,
    this.col_lseg,
    this.col_lseg_array,
    this.col_box,
    this.col_box_array,
    this.col_path,
    this.col_path_array,
    this.col_polygon,
    this.col_polygon_array,
    this.col_circle,
    this.col_circle_array,
  });

  static String get table_name => 'geometric_types';
  static String get c_id => 'id';
  static String get c_col_point => 'col_point';
  static String get c_col_point_array => 'col_point_array';
  static String get c_col_line => 'col_line';
  static String get c_col_line_array => 'col_line_array';
  static String get c_col_lseg => 'col_lseg';
  static String get c_col_lseg_array => 'col_lseg_array';
  static String get c_col_box => 'col_box';
  static String get c_col_box_array => 'col_box_array';
  static String get c_col_path => 'col_path';
  static String get c_col_path_array => 'col_path_array';
  static String get c_col_polygon => 'col_polygon';
  static String get c_col_polygon_array => 'col_polygon_array';
  static String get c_col_circle => 'col_circle';
  static String get c_col_circle_array => 'col_circle_array';
  static Map<String, dynamic> insert({
    String? id,
    String? col_point,
    List<String>? col_point_array,
    String? col_line,
    List<String>? col_line_array,
    String? col_lseg,
    List<String>? col_lseg_array,
    String? col_box,
    List<String>? col_box_array,
    String? col_path,
    List<String>? col_path_array,
    String? col_polygon,
    List<String>? col_polygon_array,
    String? col_circle,
    List<String>? col_circle_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_point != null) 'col_point': col_point.toString(),
      if (col_point_array != null)
        'col_point_array': col_point_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_line != null) 'col_line': col_line.toString(),
      if (col_line_array != null)
        'col_line_array':
            col_line_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_lseg != null) 'col_lseg': col_lseg.toString(),
      if (col_lseg_array != null)
        'col_lseg_array':
            col_lseg_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_box != null) 'col_box': col_box.toString(),
      if (col_box_array != null)
        'col_box_array':
            col_box_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_path != null) 'col_path': col_path.toString(),
      if (col_path_array != null)
        'col_path_array':
            col_path_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_polygon != null) 'col_polygon': col_polygon.toString(),
      if (col_polygon_array != null)
        'col_polygon_array': col_polygon_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_circle != null) 'col_circle': col_circle.toString(),
      if (col_circle_array != null)
        'col_circle_array': col_circle_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_point,
    List<String>? col_point_array,
    String? col_line,
    List<String>? col_line_array,
    String? col_lseg,
    List<String>? col_lseg_array,
    String? col_box,
    List<String>? col_box_array,
    String? col_path,
    List<String>? col_path_array,
    String? col_polygon,
    List<String>? col_polygon_array,
    String? col_circle,
    List<String>? col_circle_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_point != null) 'col_point': col_point.toString(),
      if (col_point_array != null)
        'col_point_array': col_point_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_line != null) 'col_line': col_line.toString(),
      if (col_line_array != null)
        'col_line_array':
            col_line_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_lseg != null) 'col_lseg': col_lseg.toString(),
      if (col_lseg_array != null)
        'col_lseg_array':
            col_lseg_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_box != null) 'col_box': col_box.toString(),
      if (col_box_array != null)
        'col_box_array':
            col_box_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_path != null) 'col_path': col_path.toString(),
      if (col_path_array != null)
        'col_path_array':
            col_path_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_polygon != null) 'col_polygon': col_polygon.toString(),
      if (col_polygon_array != null)
        'col_polygon_array': col_polygon_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_circle != null) 'col_circle': col_circle.toString(),
      if (col_circle_array != null)
        'col_circle_array': col_circle_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory GeometricTypes.fromJson(Map<String, dynamic> json) {
    return GeometricTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_point: json['col_point'] != null ? json['col_point'].toString() : '',
      col_point_array: json['col_point_array'] != null
          ? (json['col_point_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_line: json['col_line'] != null ? json['col_line'].toString() : '',
      col_line_array: json['col_line_array'] != null
          ? (json['col_line_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_lseg: json['col_lseg'] != null ? json['col_lseg'].toString() : '',
      col_lseg_array: json['col_lseg_array'] != null
          ? (json['col_lseg_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_box: json['col_box'] != null ? json['col_box'].toString() : '',
      col_box_array: json['col_box_array'] != null
          ? (json['col_box_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_path: json['col_path'] != null ? json['col_path'].toString() : '',
      col_path_array: json['col_path_array'] != null
          ? (json['col_path_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_polygon:
          json['col_polygon'] != null ? json['col_polygon'].toString() : '',
      col_polygon_array: json['col_polygon_array'] != null
          ? (json['col_polygon_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_circle:
          json['col_circle'] != null ? json['col_circle'].toString() : '',
      col_circle_array: json['col_circle_array'] != null
          ? (json['col_circle_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class JsonTypes implements SupadartClass<JsonTypes> {
  final String id;
  final Map<String, dynamic>? col_json;
  final List<Map<String, dynamic>>? col_json_array;
  final Map<String, dynamic>? col_jsonb;
  final List<Map<String, dynamic>>? col_jsonb_array;

  const JsonTypes({
    required this.id,
    this.col_json,
    this.col_json_array,
    this.col_jsonb,
    this.col_jsonb_array,
  });

  static String get table_name => 'json_types';
  static String get c_id => 'id';
  static String get c_col_json => 'col_json';
  static String get c_col_json_array => 'col_json_array';
  static String get c_col_jsonb => 'col_jsonb';
  static String get c_col_jsonb_array => 'col_jsonb_array';
  static Map<String, dynamic> insert({
    String? id,
    Map<String, dynamic>? col_json,
    List<Map<String, dynamic>>? col_json_array,
    Map<String, dynamic>? col_jsonb,
    List<Map<String, dynamic>>? col_jsonb_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_json != null) 'col_json': col_json,
      if (col_json_array != null)
        'col_json_array': jsonEncode(col_json_array)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
      if (col_jsonb != null) 'col_jsonb': col_jsonb,
      if (col_jsonb_array != null)
        'col_jsonb_array': jsonEncode(col_jsonb_array)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    Map<String, dynamic>? col_json,
    List<Map<String, dynamic>>? col_json_array,
    Map<String, dynamic>? col_jsonb,
    List<Map<String, dynamic>>? col_jsonb_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_json != null) 'col_json': col_json,
      if (col_json_array != null)
        'col_json_array': jsonEncode(col_json_array)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
      if (col_jsonb != null) 'col_jsonb': col_jsonb,
      if (col_jsonb_array != null)
        'col_jsonb_array': jsonEncode(col_jsonb_array)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
    };
  }

  factory JsonTypes.fromJson(Map<String, dynamic> json) {
    return JsonTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_json: json['col_json'] != null
          ? json['col_json'] as Map<String, dynamic>
          : <String, dynamic>{},
      col_json_array: json['col_json_array'] != null
          ? (json['col_json_array'] as List<dynamic>)
              .map((v) => v as Map<String, dynamic>)
              .toList()
          : <Map<String, dynamic>>[],
      col_jsonb: json['col_jsonb'] != null
          ? json['col_jsonb'] as Map<String, dynamic>
          : <String, dynamic>{},
      col_jsonb_array: json['col_jsonb_array'] != null
          ? (json['col_jsonb_array'] as List<dynamic>)
              .map((v) => v as Map<String, dynamic>)
              .toList()
          : <Map<String, dynamic>>[],
    );
  }
}

class BinaryXmlTypes implements SupadartClass<BinaryXmlTypes> {
  final String id;
  final String? col_bytea;
  final List<String>? col_bytea_array;
  final String? col_xml;
  final List<String>? col_xml_array;

  const BinaryXmlTypes({
    required this.id,
    this.col_bytea,
    this.col_bytea_array,
    this.col_xml,
    this.col_xml_array,
  });

  static String get table_name => 'binary_xml_types';
  static String get c_id => 'id';
  static String get c_col_bytea => 'col_bytea';
  static String get c_col_bytea_array => 'col_bytea_array';
  static String get c_col_xml => 'col_xml';
  static String get c_col_xml_array => 'col_xml_array';
  static Map<String, dynamic> insert({
    String? id,
    String? col_bytea,
    List<String>? col_bytea_array,
    String? col_xml,
    List<String>? col_xml_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bytea != null) 'col_bytea': col_bytea.toString(),
      if (col_bytea_array != null)
        'col_bytea_array': col_bytea_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_xml != null) 'col_xml': col_xml.toString(),
      if (col_xml_array != null)
        'col_xml_array':
            col_xml_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_bytea,
    List<String>? col_bytea_array,
    String? col_xml,
    List<String>? col_xml_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bytea != null) 'col_bytea': col_bytea.toString(),
      if (col_bytea_array != null)
        'col_bytea_array': col_bytea_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_xml != null) 'col_xml': col_xml.toString(),
      if (col_xml_array != null)
        'col_xml_array':
            col_xml_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  factory BinaryXmlTypes.fromJson(Map<String, dynamic> json) {
    return BinaryXmlTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_bytea: json['col_bytea'] != null ? json['col_bytea'].toString() : '',
      col_bytea_array: json['col_bytea_array'] != null
          ? (json['col_bytea_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_xml: json['col_xml'] != null ? json['col_xml'].toString() : '',
      col_xml_array: json['col_xml_array'] != null
          ? (json['col_xml_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class NetworkTypes implements SupadartClass<NetworkTypes> {
  final String id;
  final String? col_cidr;
  final List<String>? col_cidr_array;
  final String? col_inet;
  final List<String>? col_inet_array;
  final String? col_macaddr;
  final List<String>? col_macaddr_array;
  final String? col_macaddr8;
  final List<String>? col_macaddr8_array;

  const NetworkTypes({
    required this.id,
    this.col_cidr,
    this.col_cidr_array,
    this.col_inet,
    this.col_inet_array,
    this.col_macaddr,
    this.col_macaddr_array,
    this.col_macaddr8,
    this.col_macaddr8_array,
  });

  static String get table_name => 'network_types';
  static String get c_id => 'id';
  static String get c_col_cidr => 'col_cidr';
  static String get c_col_cidr_array => 'col_cidr_array';
  static String get c_col_inet => 'col_inet';
  static String get c_col_inet_array => 'col_inet_array';
  static String get c_col_macaddr => 'col_macaddr';
  static String get c_col_macaddr_array => 'col_macaddr_array';
  static String get c_col_macaddr8 => 'col_macaddr8';
  static String get c_col_macaddr8_array => 'col_macaddr8_array';
  static Map<String, dynamic> insert({
    String? id,
    String? col_cidr,
    List<String>? col_cidr_array,
    String? col_inet,
    List<String>? col_inet_array,
    String? col_macaddr,
    List<String>? col_macaddr_array,
    String? col_macaddr8,
    List<String>? col_macaddr8_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_cidr != null) 'col_cidr': col_cidr.toString(),
      if (col_cidr_array != null)
        'col_cidr_array':
            col_cidr_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_inet != null) 'col_inet': col_inet.toString(),
      if (col_inet_array != null)
        'col_inet_array':
            col_inet_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_macaddr != null) 'col_macaddr': col_macaddr.toString(),
      if (col_macaddr_array != null)
        'col_macaddr_array': col_macaddr_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_macaddr8 != null) 'col_macaddr8': col_macaddr8.toString(),
      if (col_macaddr8_array != null)
        'col_macaddr8_array': col_macaddr8_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_cidr,
    List<String>? col_cidr_array,
    String? col_inet,
    List<String>? col_inet_array,
    String? col_macaddr,
    List<String>? col_macaddr_array,
    String? col_macaddr8,
    List<String>? col_macaddr8_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_cidr != null) 'col_cidr': col_cidr.toString(),
      if (col_cidr_array != null)
        'col_cidr_array':
            col_cidr_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_inet != null) 'col_inet': col_inet.toString(),
      if (col_inet_array != null)
        'col_inet_array':
            col_inet_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_macaddr != null) 'col_macaddr': col_macaddr.toString(),
      if (col_macaddr_array != null)
        'col_macaddr_array': col_macaddr_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_macaddr8 != null) 'col_macaddr8': col_macaddr8.toString(),
      if (col_macaddr8_array != null)
        'col_macaddr8_array': col_macaddr8_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory NetworkTypes.fromJson(Map<String, dynamic> json) {
    return NetworkTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_cidr: json['col_cidr'] != null ? json['col_cidr'].toString() : '',
      col_cidr_array: json['col_cidr_array'] != null
          ? (json['col_cidr_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_inet: json['col_inet'] != null ? json['col_inet'].toString() : '',
      col_inet_array: json['col_inet_array'] != null
          ? (json['col_inet_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_macaddr:
          json['col_macaddr'] != null ? json['col_macaddr'].toString() : '',
      col_macaddr_array: json['col_macaddr_array'] != null
          ? (json['col_macaddr_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      col_macaddr8:
          json['col_macaddr8'] != null ? json['col_macaddr8'].toString() : '',
      col_macaddr8_array: json['col_macaddr8_array'] != null
          ? (json['col_macaddr8_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }
}

class NumericTypes implements SupadartClass<NumericTypes> {
  final String id;
  final BigInt? col_bigint;
  final List<BigInt>? col_bigint_array;
  final BigInt col_bigserial;
  final List<BigInt>? col_bigserial_array;
  final int? col_integer;
  final List<int>? col_integer_array;
  final int? col_smallint;
  final List<int>? col_smallint_array;
  final int col_smallserial;
  final List<int>? col_smallserial_array;
  final int col_serial;
  final List<int>? col_serial_array;
  final double? col_double;
  final List<double>? col_double_array;
  final double? col_real;
  final List<double>? col_real_array;
  final num? col_numeric;
  final List<num>? col_numeric_array;

  const NumericTypes({
    required this.id,
    this.col_bigint,
    this.col_bigint_array,
    required this.col_bigserial,
    this.col_bigserial_array,
    this.col_integer,
    this.col_integer_array,
    this.col_smallint,
    this.col_smallint_array,
    required this.col_smallserial,
    this.col_smallserial_array,
    required this.col_serial,
    this.col_serial_array,
    this.col_double,
    this.col_double_array,
    this.col_real,
    this.col_real_array,
    this.col_numeric,
    this.col_numeric_array,
  });

  static String get table_name => 'numeric_types';
  static String get c_id => 'id';
  static String get c_col_bigint => 'col_bigint';
  static String get c_col_bigint_array => 'col_bigint_array';
  static String get c_col_bigserial => 'col_bigserial';
  static String get c_col_bigserial_array => 'col_bigserial_array';
  static String get c_col_integer => 'col_integer';
  static String get c_col_integer_array => 'col_integer_array';
  static String get c_col_smallint => 'col_smallint';
  static String get c_col_smallint_array => 'col_smallint_array';
  static String get c_col_smallserial => 'col_smallserial';
  static String get c_col_smallserial_array => 'col_smallserial_array';
  static String get c_col_serial => 'col_serial';
  static String get c_col_serial_array => 'col_serial_array';
  static String get c_col_double => 'col_double';
  static String get c_col_double_array => 'col_double_array';
  static String get c_col_real => 'col_real';
  static String get c_col_real_array => 'col_real_array';
  static String get c_col_numeric => 'col_numeric';
  static String get c_col_numeric_array => 'col_numeric_array';
  static Map<String, dynamic> insert({
    String? id,
    BigInt? col_bigint,
    List<BigInt>? col_bigint_array,
    BigInt? col_bigserial,
    List<BigInt>? col_bigserial_array,
    int? col_integer,
    List<int>? col_integer_array,
    int? col_smallint,
    List<int>? col_smallint_array,
    int? col_smallserial,
    List<int>? col_smallserial_array,
    int? col_serial,
    List<int>? col_serial_array,
    double? col_double,
    List<double>? col_double_array,
    double? col_real,
    List<double>? col_real_array,
    num? col_numeric,
    List<num>? col_numeric_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bigint != null) 'col_bigint': col_bigint.toString(),
      if (col_bigint_array != null)
        'col_bigint_array': col_bigint_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_bigserial != null) 'col_bigserial': col_bigserial.toString(),
      if (col_bigserial_array != null)
        'col_bigserial_array': col_bigserial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_integer != null) 'col_integer': col_integer.toString(),
      if (col_integer_array != null)
        'col_integer_array': col_integer_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_smallint != null) 'col_smallint': col_smallint.toString(),
      if (col_smallint_array != null)
        'col_smallint_array': col_smallint_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_smallserial != null)
        'col_smallserial': col_smallserial.toString(),
      if (col_smallserial_array != null)
        'col_smallserial_array': col_smallserial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_serial != null) 'col_serial': col_serial.toString(),
      if (col_serial_array != null)
        'col_serial_array': col_serial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_double != null) 'col_double': col_double.toString(),
      if (col_double_array != null)
        'col_double_array': col_double_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_real != null) 'col_real': col_real.toString(),
      if (col_real_array != null)
        'col_real_array':
            col_real_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_numeric != null) 'col_numeric': col_numeric.toString(),
      if (col_numeric_array != null)
        'col_numeric_array': col_numeric_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    BigInt? col_bigint,
    List<BigInt>? col_bigint_array,
    BigInt? col_bigserial,
    List<BigInt>? col_bigserial_array,
    int? col_integer,
    List<int>? col_integer_array,
    int? col_smallint,
    List<int>? col_smallint_array,
    int? col_smallserial,
    List<int>? col_smallserial_array,
    int? col_serial,
    List<int>? col_serial_array,
    double? col_double,
    List<double>? col_double_array,
    double? col_real,
    List<double>? col_real_array,
    num? col_numeric,
    List<num>? col_numeric_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bigint != null) 'col_bigint': col_bigint.toString(),
      if (col_bigint_array != null)
        'col_bigint_array': col_bigint_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_bigserial != null) 'col_bigserial': col_bigserial.toString(),
      if (col_bigserial_array != null)
        'col_bigserial_array': col_bigserial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_integer != null) 'col_integer': col_integer.toString(),
      if (col_integer_array != null)
        'col_integer_array': col_integer_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_smallint != null) 'col_smallint': col_smallint.toString(),
      if (col_smallint_array != null)
        'col_smallint_array': col_smallint_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_smallserial != null)
        'col_smallserial': col_smallserial.toString(),
      if (col_smallserial_array != null)
        'col_smallserial_array': col_smallserial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_serial != null) 'col_serial': col_serial.toString(),
      if (col_serial_array != null)
        'col_serial_array': col_serial_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_double != null) 'col_double': col_double.toString(),
      if (col_double_array != null)
        'col_double_array': col_double_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_real != null) 'col_real': col_real.toString(),
      if (col_real_array != null)
        'col_real_array':
            col_real_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_numeric != null) 'col_numeric': col_numeric.toString(),
      if (col_numeric_array != null)
        'col_numeric_array': col_numeric_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory NumericTypes.fromJson(Map<String, dynamic> json) {
    return NumericTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_bigint: json['col_bigint'] != null
          ? BigInt.tryParse(json['col_bigint'].toString()) as BigInt
          : BigInt.from(0),
      col_bigint_array: json['col_bigint_array'] != null
          ? (json['col_bigint_array'] as List<dynamic>)
              .map((v) => BigInt.tryParse(v.toString()) as BigInt)
              .toList()
          : <BigInt>[],
      col_bigserial: json['col_bigserial'] != null
          ? BigInt.tryParse(json['col_bigserial'].toString()) as BigInt
          : BigInt.from(0),
      col_bigserial_array: json['col_bigserial_array'] != null
          ? (json['col_bigserial_array'] as List<dynamic>)
              .map((v) => BigInt.tryParse(v.toString()) as BigInt)
              .toList()
          : <BigInt>[],
      col_integer: json['col_integer'] != null ? json['col_integer'] as int : 0,
      col_integer_array: json['col_integer_array'] != null
          ? (json['col_integer_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      col_smallint:
          json['col_smallint'] != null ? json['col_smallint'] as int : 0,
      col_smallint_array: json['col_smallint_array'] != null
          ? (json['col_smallint_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      col_smallserial:
          json['col_smallserial'] != null ? json['col_smallserial'] as int : 0,
      col_smallserial_array: json['col_smallserial_array'] != null
          ? (json['col_smallserial_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      col_serial: json['col_serial'] != null ? json['col_serial'] as int : 0,
      col_serial_array: json['col_serial_array'] != null
          ? (json['col_serial_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      col_double: json['col_double'] != null
          ? double.tryParse(json['col_double'].toString())
          : 0.0,
      col_double_array: json['col_double_array'] != null
          ? (json['col_double_array'] as List<dynamic>)
              .map((v) => double.tryParse(v.toString()) as double)
              .toList()
          : <double>[],
      col_real: json['col_real'] != null
          ? double.tryParse(json['col_real'].toString())
          : 0.0,
      col_real_array: json['col_real_array'] != null
          ? (json['col_real_array'] as List<dynamic>)
              .map((v) => double.tryParse(v.toString()) as double)
              .toList()
          : <double>[],
      col_numeric: json['col_numeric'] != null
          ? num.tryParse(json['col_numeric'].toString())
          : 0,
      col_numeric_array: json['col_numeric_array'] != null
          ? (json['col_numeric_array'] as List<dynamic>)
              .map((v) => num.tryParse(v.toString()) as num)
              .toList()
          : <num>[],
    );
  }
}

class DatetimeTypes implements SupadartClass<DatetimeTypes> {
  final String id;
  final DateTime? col_date;
  final List<DateTime>? col_date_array;
  final DateTime? col_time;
  final List<DateTime>? col_time_array;
  final DateTime? col_timetz;
  final List<DateTime>? col_timetz_array;
  final DateTime? col_timestamp;
  final List<DateTime>? col_timestamp_array;
  final DateTime? col_timestamptz;
  final List<DateTime>? col_timestamptz_array;
  final Duration? col_interval;
  final List<Duration>? col_interval_array;

  const DatetimeTypes({
    required this.id,
    this.col_date,
    this.col_date_array,
    this.col_time,
    this.col_time_array,
    this.col_timetz,
    this.col_timetz_array,
    this.col_timestamp,
    this.col_timestamp_array,
    this.col_timestamptz,
    this.col_timestamptz_array,
    this.col_interval,
    this.col_interval_array,
  });

  static String get table_name => 'datetime_types';
  static String get c_id => 'id';
  static String get c_col_date => 'col_date';
  static String get c_col_date_array => 'col_date_array';
  static String get c_col_time => 'col_time';
  static String get c_col_time_array => 'col_time_array';
  static String get c_col_timetz => 'col_timetz';
  static String get c_col_timetz_array => 'col_timetz_array';
  static String get c_col_timestamp => 'col_timestamp';
  static String get c_col_timestamp_array => 'col_timestamp_array';
  static String get c_col_timestamptz => 'col_timestamptz';
  static String get c_col_timestamptz_array => 'col_timestamptz_array';
  static String get c_col_interval => 'col_interval';
  static String get c_col_interval_array => 'col_interval_array';
  static Map<String, dynamic> insert({
    String? id,
    DateTime? col_date,
    List<DateTime>? col_date_array,
    DateTime? col_time,
    List<DateTime>? col_time_array,
    DateTime? col_timetz,
    List<DateTime>? col_timetz_array,
    DateTime? col_timestamp,
    List<DateTime>? col_timestamp_array,
    DateTime? col_timestamptz,
    List<DateTime>? col_timestamptz_array,
    Duration? col_interval,
    List<Duration>? col_interval_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_date != null) 'col_date': col_date.toIso8601String(),
      if (col_date_array != null)
        'col_date_array':
            col_date_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_time != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(col_time),
      if (col_time_array != null)
        'col_time_array':
            col_time_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_timetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(col_timetz),
      if (col_timetz_array != null)
        'col_timetz_array': col_timetz_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_timestamp != null)
        'col_timestamp': col_timestamp.toIso8601String(),
      if (col_timestamp_array != null)
        'col_timestamp_array': col_timestamp_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_timestamptz != null)
        'col_timestamptz': col_timestamptz.toUtc().toString(),
      if (col_timestamptz_array != null)
        'col_timestamptz_array': col_timestamptz_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_interval != null) 'col_interval': col_interval.toString(),
      if (col_interval_array != null)
        'col_interval_array': col_interval_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    DateTime? col_date,
    List<DateTime>? col_date_array,
    DateTime? col_time,
    List<DateTime>? col_time_array,
    DateTime? col_timetz,
    List<DateTime>? col_timetz_array,
    DateTime? col_timestamp,
    List<DateTime>? col_timestamp_array,
    DateTime? col_timestamptz,
    List<DateTime>? col_timestamptz_array,
    Duration? col_interval,
    List<Duration>? col_interval_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_date != null) 'col_date': col_date.toIso8601String(),
      if (col_date_array != null)
        'col_date_array':
            col_date_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_time != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(col_time),
      if (col_time_array != null)
        'col_time_array':
            col_time_array.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (col_timetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(col_timetz),
      if (col_timetz_array != null)
        'col_timetz_array': col_timetz_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_timestamp != null)
        'col_timestamp': col_timestamp.toIso8601String(),
      if (col_timestamp_array != null)
        'col_timestamp_array': col_timestamp_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_timestamptz != null)
        'col_timestamptz': col_timestamptz.toUtc().toString(),
      if (col_timestamptz_array != null)
        'col_timestamptz_array': col_timestamptz_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (col_interval != null) 'col_interval': col_interval.toString(),
      if (col_interval_array != null)
        'col_interval_array': col_interval_array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory DatetimeTypes.fromJson(Map<String, dynamic> json) {
    return DatetimeTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      col_date: json['col_date'] != null
          ? DateTime.tryParse(json['col_date'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      col_date_array: json['col_date_array'] != null
          ? (json['col_date_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      col_time: json['col_time'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_time'].toString()}")
              as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      col_time_array: json['col_time_array'] != null
          ? (json['col_time_array'] as List<dynamic>)
              .map((v) =>
                  DateTime.tryParse("1970-01-01T${v.toString()}") as DateTime)
              .toList()
          : <DateTime>[],
      col_timetz: json['col_timetz'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_timetz'].toString()}")
              as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      col_timetz_array: json['col_timetz_array'] != null
          ? (json['col_timetz_array'] as List<dynamic>)
              .map((v) =>
                  DateTime.tryParse("1970-01-01T${v.toString()}") as DateTime)
              .toList()
          : <DateTime>[],
      col_timestamp: json['col_timestamp'] != null
          ? DateTime.tryParse(json['col_timestamp'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      col_timestamp_array: json['col_timestamp_array'] != null
          ? (json['col_timestamp_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      col_timestamptz: json['col_timestamptz'] != null
          ? DateTime.tryParse(json['col_timestamptz'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      col_timestamptz_array: json['col_timestamptz_array'] != null
          ? (json['col_timestamptz_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      col_interval: json['col_interval'] != null
          ? json['col_interval'] as Duration
          : Duration(),
      col_interval_array: json['col_interval_array'] != null
          ? (json['col_interval_array'] as List<dynamic>)
              .map((v) => v as Duration)
              .toList()
          : <Duration>[],
    );
  }
}
