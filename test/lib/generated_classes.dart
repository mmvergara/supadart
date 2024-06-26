// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';

extension TypeSafeTable on SupabaseClient {
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

class StringTypes {
  final String id;
  final String? col_uuid;
  final dynamic? col_uuid_array;
  final String? col_character;
  final dynamic? col_character_array;
  final String? col_charactervarying;
  final dynamic? col_charactervarying_array;
  final String? col_text;
  final dynamic? col_text_array;

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
    dynamic? col_uuid_array,
    String? col_character,
    dynamic? col_character_array,
    String? col_charactervarying,
    dynamic? col_charactervarying_array,
    String? col_text,
    dynamic? col_text_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_uuid != null) 'col_uuid': col_uuid.toString(),
      if (col_uuid_array != null) 'col_uuid_array': col_uuid_array.toString(),
      if (col_character != null) 'col_character': col_character.toString(),
      if (col_character_array != null)
        'col_character_array': col_character_array.toString(),
      if (col_charactervarying != null)
        'col_charactervarying': col_charactervarying.toString(),
      if (col_charactervarying_array != null)
        'col_charactervarying_array': col_charactervarying_array.toString(),
      if (col_text != null) 'col_text': col_text.toString(),
      if (col_text_array != null) 'col_text_array': col_text_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_uuid,
    dynamic? col_uuid_array,
    String? col_character,
    dynamic? col_character_array,
    String? col_charactervarying,
    dynamic? col_charactervarying_array,
    String? col_text,
    dynamic? col_text_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_uuid != null) 'col_uuid': col_uuid.toString(),
      if (col_uuid_array != null) 'col_uuid_array': col_uuid_array.toString(),
      if (col_character != null) 'col_character': col_character.toString(),
      if (col_character_array != null)
        'col_character_array': col_character_array.toString(),
      if (col_charactervarying != null)
        'col_charactervarying': col_charactervarying.toString(),
      if (col_charactervarying_array != null)
        'col_charactervarying_array': col_charactervarying_array.toString(),
      if (col_text != null) 'col_text': col_text.toString(),
      if (col_text_array != null) 'col_text_array': col_text_array.toString(),
    };
  }

  factory StringTypes.fromJson(Map<String, dynamic> json) {
    return StringTypes(
      id: json['id'] as String,
      col_uuid: json['col_uuid'] != null ? json['col_uuid'] as String : null,
      col_uuid_array: json['col_uuid_array'] != null
          ? json['col_uuid_array'] as dynamic
          : null,
      col_character: json['col_character'] != null
          ? json['col_character'] as String
          : null,
      col_character_array: json['col_character_array'] != null
          ? json['col_character_array'] as dynamic
          : null,
      col_charactervarying: json['col_charactervarying'] != null
          ? json['col_charactervarying'] as String
          : null,
      col_charactervarying_array: json['col_charactervarying_array'] != null
          ? json['col_charactervarying_array'] as dynamic
          : null,
      col_text: json['col_text'] != null ? json['col_text'] as String : null,
      col_text_array: json['col_text_array'] != null
          ? json['col_text_array'] as dynamic
          : null,
    );
  }
}

class BooleanBitTypes {
  final String id;
  final bool? col_boolean;
  final dynamic? col_boolean_array;
  final String? col_bit;
  final dynamic? col_bit_array;
  final String? col_bitvarying;
  final dynamic? col_bitvarying_array;

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
    dynamic? col_boolean_array,
    String? col_bit,
    dynamic? col_bit_array,
    String? col_bitvarying,
    dynamic? col_bitvarying_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_boolean != null) 'col_boolean': col_boolean.toString(),
      if (col_boolean_array != null)
        'col_boolean_array': col_boolean_array.toString(),
      if (col_bit != null) 'col_bit': col_bit.toString(),
      if (col_bit_array != null) 'col_bit_array': col_bit_array.toString(),
      if (col_bitvarying != null) 'col_bitvarying': col_bitvarying.toString(),
      if (col_bitvarying_array != null)
        'col_bitvarying_array': col_bitvarying_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    bool? col_boolean,
    dynamic? col_boolean_array,
    String? col_bit,
    dynamic? col_bit_array,
    String? col_bitvarying,
    dynamic? col_bitvarying_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_boolean != null) 'col_boolean': col_boolean.toString(),
      if (col_boolean_array != null)
        'col_boolean_array': col_boolean_array.toString(),
      if (col_bit != null) 'col_bit': col_bit.toString(),
      if (col_bit_array != null) 'col_bit_array': col_bit_array.toString(),
      if (col_bitvarying != null) 'col_bitvarying': col_bitvarying.toString(),
      if (col_bitvarying_array != null)
        'col_bitvarying_array': col_bitvarying_array.toString(),
    };
  }

  factory BooleanBitTypes.fromJson(Map<String, dynamic> json) {
    return BooleanBitTypes(
      id: json['id'] as String,
      col_boolean:
          json['col_boolean'] != null ? json['col_boolean'] as bool : null,
      col_boolean_array: json['col_boolean_array'] != null
          ? json['col_boolean_array'] as dynamic
          : null,
      col_bit: json['col_bit'] != null ? json['col_bit'] as String : null,
      col_bit_array: json['col_bit_array'] != null
          ? json['col_bit_array'] as dynamic
          : null,
      col_bitvarying: json['col_bitvarying'] != null
          ? json['col_bitvarying'] as String
          : null,
      col_bitvarying_array: json['col_bitvarying_array'] != null
          ? json['col_bitvarying_array'] as dynamic
          : null,
    );
  }
}

class MiscTypes {
  final String id;
  final String? col_money;
  final dynamic? col_money_array;
  final String? col_pg_lsn;
  final dynamic? col_pg_lsn_array;
  final String? col_pg_snapshot;
  final dynamic? col_pg_snapshot_array;
  final String? col_tsquery;
  final dynamic? col_tsquery_array;
  final String? col_tsvector;
  final dynamic? col_tsvector_array;
  final String? col_txid_snapshot;
  final dynamic? col_txid_snapshot_array;

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
    dynamic? col_money_array,
    String? col_pg_lsn,
    dynamic? col_pg_lsn_array,
    String? col_pg_snapshot,
    dynamic? col_pg_snapshot_array,
    String? col_tsquery,
    dynamic? col_tsquery_array,
    String? col_tsvector,
    dynamic? col_tsvector_array,
    String? col_txid_snapshot,
    dynamic? col_txid_snapshot_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_money != null) 'col_money': col_money.toString(),
      if (col_money_array != null)
        'col_money_array': col_money_array.toString(),
      if (col_pg_lsn != null) 'col_pg_lsn': col_pg_lsn.toString(),
      if (col_pg_lsn_array != null)
        'col_pg_lsn_array': col_pg_lsn_array.toString(),
      if (col_pg_snapshot != null)
        'col_pg_snapshot': col_pg_snapshot.toString(),
      if (col_pg_snapshot_array != null)
        'col_pg_snapshot_array': col_pg_snapshot_array.toString(),
      if (col_tsquery != null) 'col_tsquery': col_tsquery.toString(),
      if (col_tsquery_array != null)
        'col_tsquery_array': col_tsquery_array.toString(),
      if (col_tsvector != null) 'col_tsvector': col_tsvector.toString(),
      if (col_tsvector_array != null)
        'col_tsvector_array': col_tsvector_array.toString(),
      if (col_txid_snapshot != null)
        'col_txid_snapshot': col_txid_snapshot.toString(),
      if (col_txid_snapshot_array != null)
        'col_txid_snapshot_array': col_txid_snapshot_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_money,
    dynamic? col_money_array,
    String? col_pg_lsn,
    dynamic? col_pg_lsn_array,
    String? col_pg_snapshot,
    dynamic? col_pg_snapshot_array,
    String? col_tsquery,
    dynamic? col_tsquery_array,
    String? col_tsvector,
    dynamic? col_tsvector_array,
    String? col_txid_snapshot,
    dynamic? col_txid_snapshot_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_money != null) 'col_money': col_money.toString(),
      if (col_money_array != null)
        'col_money_array': col_money_array.toString(),
      if (col_pg_lsn != null) 'col_pg_lsn': col_pg_lsn.toString(),
      if (col_pg_lsn_array != null)
        'col_pg_lsn_array': col_pg_lsn_array.toString(),
      if (col_pg_snapshot != null)
        'col_pg_snapshot': col_pg_snapshot.toString(),
      if (col_pg_snapshot_array != null)
        'col_pg_snapshot_array': col_pg_snapshot_array.toString(),
      if (col_tsquery != null) 'col_tsquery': col_tsquery.toString(),
      if (col_tsquery_array != null)
        'col_tsquery_array': col_tsquery_array.toString(),
      if (col_tsvector != null) 'col_tsvector': col_tsvector.toString(),
      if (col_tsvector_array != null)
        'col_tsvector_array': col_tsvector_array.toString(),
      if (col_txid_snapshot != null)
        'col_txid_snapshot': col_txid_snapshot.toString(),
      if (col_txid_snapshot_array != null)
        'col_txid_snapshot_array': col_txid_snapshot_array.toString(),
    };
  }

  factory MiscTypes.fromJson(Map<String, dynamic> json) {
    return MiscTypes(
      id: json['id'] as String,
      col_money: json['col_money'] != null ? json['col_money'] as String : null,
      col_money_array: json['col_money_array'] != null
          ? json['col_money_array'] as dynamic
          : null,
      col_pg_lsn:
          json['col_pg_lsn'] != null ? json['col_pg_lsn'] as String : null,
      col_pg_lsn_array: json['col_pg_lsn_array'] != null
          ? json['col_pg_lsn_array'] as dynamic
          : null,
      col_pg_snapshot: json['col_pg_snapshot'] != null
          ? json['col_pg_snapshot'] as String
          : null,
      col_pg_snapshot_array: json['col_pg_snapshot_array'] != null
          ? json['col_pg_snapshot_array'] as dynamic
          : null,
      col_tsquery:
          json['col_tsquery'] != null ? json['col_tsquery'] as String : null,
      col_tsquery_array: json['col_tsquery_array'] != null
          ? json['col_tsquery_array'] as dynamic
          : null,
      col_tsvector:
          json['col_tsvector'] != null ? json['col_tsvector'] as String : null,
      col_tsvector_array: json['col_tsvector_array'] != null
          ? json['col_tsvector_array'] as dynamic
          : null,
      col_txid_snapshot: json['col_txid_snapshot'] != null
          ? json['col_txid_snapshot'] as String
          : null,
      col_txid_snapshot_array: json['col_txid_snapshot_array'] != null
          ? json['col_txid_snapshot_array'] as dynamic
          : null,
    );
  }
}

class Books {
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
      id: BigInt.parse(json['id'].toString()),
      name: json['name'] as String,
      description:
          json['description'] != null ? json['description'] as String : null,
      price: json['price'] as int,
      created_at: DateTime.parse(json['created_at'].toString()),
    );
  }
}

class GeometricTypes {
  final String id;
  final String? col_point;
  final dynamic? col_point_array;
  final String? col_line;
  final dynamic? col_line_array;
  final String? col_lseg;
  final dynamic? col_lseg_array;
  final String? col_box;
  final dynamic? col_box_array;
  final String? col_path;
  final dynamic? col_path_array;
  final String? col_polygon;
  final dynamic? col_polygon_array;
  final String? col_circle;
  final dynamic? col_circle_array;

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
    dynamic? col_point_array,
    String? col_line,
    dynamic? col_line_array,
    String? col_lseg,
    dynamic? col_lseg_array,
    String? col_box,
    dynamic? col_box_array,
    String? col_path,
    dynamic? col_path_array,
    String? col_polygon,
    dynamic? col_polygon_array,
    String? col_circle,
    dynamic? col_circle_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_point != null) 'col_point': col_point.toString(),
      if (col_point_array != null)
        'col_point_array': col_point_array.toString(),
      if (col_line != null) 'col_line': col_line.toString(),
      if (col_line_array != null) 'col_line_array': col_line_array.toString(),
      if (col_lseg != null) 'col_lseg': col_lseg.toString(),
      if (col_lseg_array != null) 'col_lseg_array': col_lseg_array.toString(),
      if (col_box != null) 'col_box': col_box.toString(),
      if (col_box_array != null) 'col_box_array': col_box_array.toString(),
      if (col_path != null) 'col_path': col_path.toString(),
      if (col_path_array != null) 'col_path_array': col_path_array.toString(),
      if (col_polygon != null) 'col_polygon': col_polygon.toString(),
      if (col_polygon_array != null)
        'col_polygon_array': col_polygon_array.toString(),
      if (col_circle != null) 'col_circle': col_circle.toString(),
      if (col_circle_array != null)
        'col_circle_array': col_circle_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_point,
    dynamic? col_point_array,
    String? col_line,
    dynamic? col_line_array,
    String? col_lseg,
    dynamic? col_lseg_array,
    String? col_box,
    dynamic? col_box_array,
    String? col_path,
    dynamic? col_path_array,
    String? col_polygon,
    dynamic? col_polygon_array,
    String? col_circle,
    dynamic? col_circle_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_point != null) 'col_point': col_point.toString(),
      if (col_point_array != null)
        'col_point_array': col_point_array.toString(),
      if (col_line != null) 'col_line': col_line.toString(),
      if (col_line_array != null) 'col_line_array': col_line_array.toString(),
      if (col_lseg != null) 'col_lseg': col_lseg.toString(),
      if (col_lseg_array != null) 'col_lseg_array': col_lseg_array.toString(),
      if (col_box != null) 'col_box': col_box.toString(),
      if (col_box_array != null) 'col_box_array': col_box_array.toString(),
      if (col_path != null) 'col_path': col_path.toString(),
      if (col_path_array != null) 'col_path_array': col_path_array.toString(),
      if (col_polygon != null) 'col_polygon': col_polygon.toString(),
      if (col_polygon_array != null)
        'col_polygon_array': col_polygon_array.toString(),
      if (col_circle != null) 'col_circle': col_circle.toString(),
      if (col_circle_array != null)
        'col_circle_array': col_circle_array.toString(),
    };
  }

  factory GeometricTypes.fromJson(Map<String, dynamic> json) {
    return GeometricTypes(
      id: json['id'] as String,
      col_point: json['col_point'] != null ? json['col_point'] as String : null,
      col_point_array: json['col_point_array'] != null
          ? json['col_point_array'] as dynamic
          : null,
      col_line: json['col_line'] != null ? json['col_line'] as String : null,
      col_line_array: json['col_line_array'] != null
          ? json['col_line_array'] as dynamic
          : null,
      col_lseg: json['col_lseg'] != null ? json['col_lseg'] as String : null,
      col_lseg_array: json['col_lseg_array'] != null
          ? json['col_lseg_array'] as dynamic
          : null,
      col_box: json['col_box'] != null ? json['col_box'] as String : null,
      col_box_array: json['col_box_array'] != null
          ? json['col_box_array'] as dynamic
          : null,
      col_path: json['col_path'] != null ? json['col_path'] as String : null,
      col_path_array: json['col_path_array'] != null
          ? json['col_path_array'] as dynamic
          : null,
      col_polygon:
          json['col_polygon'] != null ? json['col_polygon'] as String : null,
      col_polygon_array: json['col_polygon_array'] != null
          ? json['col_polygon_array'] as dynamic
          : null,
      col_circle:
          json['col_circle'] != null ? json['col_circle'] as String : null,
      col_circle_array: json['col_circle_array'] != null
          ? json['col_circle_array'] as dynamic
          : null,
    );
  }
}

class JsonTypes {
  final String id;
  final Map<String, dynamic>? col_json;
  final dynamic? col_json_array;
  final Map<String, dynamic>? col_jsonb;
  final dynamic? col_jsonb_array;

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
    dynamic? col_json_array,
    Map<String, dynamic>? col_jsonb,
    dynamic? col_jsonb_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_json != null) 'col_json': col_json,
      if (col_json_array != null) 'col_json_array': col_json_array.toString(),
      if (col_jsonb != null) 'col_jsonb': col_jsonb,
      if (col_jsonb_array != null)
        'col_jsonb_array': col_jsonb_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    Map<String, dynamic>? col_json,
    dynamic? col_json_array,
    Map<String, dynamic>? col_jsonb,
    dynamic? col_jsonb_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_json != null) 'col_json': col_json,
      if (col_json_array != null) 'col_json_array': col_json_array.toString(),
      if (col_jsonb != null) 'col_jsonb': col_jsonb,
      if (col_jsonb_array != null)
        'col_jsonb_array': col_jsonb_array.toString(),
    };
  }

  factory JsonTypes.fromJson(Map<String, dynamic> json) {
    return JsonTypes(
      id: json['id'] as String,
      col_json: json['col_json'] != null
          ? json['col_json'] as Map<String, dynamic>
          : null,
      col_json_array: json['col_json_array'] != null
          ? json['col_json_array'] as dynamic
          : null,
      col_jsonb: json['col_jsonb'] != null
          ? json['col_jsonb'] as Map<String, dynamic>
          : null,
      col_jsonb_array: json['col_jsonb_array'] != null
          ? json['col_jsonb_array'] as dynamic
          : null,
    );
  }
}

class BinaryXmlTypes {
  final String id;
  final String? col_bytea;
  final dynamic? col_bytea_array;
  final String? col_xml;
  final dynamic? col_xml_array;

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
    dynamic? col_bytea_array,
    String? col_xml,
    dynamic? col_xml_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bytea != null) 'col_bytea': col_bytea.toString(),
      if (col_bytea_array != null)
        'col_bytea_array': col_bytea_array.toString(),
      if (col_xml != null) 'col_xml': col_xml.toString(),
      if (col_xml_array != null) 'col_xml_array': col_xml_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_bytea,
    dynamic? col_bytea_array,
    String? col_xml,
    dynamic? col_xml_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bytea != null) 'col_bytea': col_bytea.toString(),
      if (col_bytea_array != null)
        'col_bytea_array': col_bytea_array.toString(),
      if (col_xml != null) 'col_xml': col_xml.toString(),
      if (col_xml_array != null) 'col_xml_array': col_xml_array.toString(),
    };
  }

  factory BinaryXmlTypes.fromJson(Map<String, dynamic> json) {
    return BinaryXmlTypes(
      id: json['id'] as String,
      col_bytea: json['col_bytea'] != null ? json['col_bytea'] as String : null,
      col_bytea_array: json['col_bytea_array'] != null
          ? json['col_bytea_array'] as dynamic
          : null,
      col_xml: json['col_xml'] != null ? json['col_xml'] as String : null,
      col_xml_array: json['col_xml_array'] != null
          ? json['col_xml_array'] as dynamic
          : null,
    );
  }
}

class NetworkTypes {
  final String id;
  final String? col_cidr;
  final dynamic? col_cidr_array;
  final String? col_inet;
  final dynamic? col_inet_array;
  final String? col_macaddr;
  final dynamic? col_macaddr_array;
  final String? col_macaddr8;
  final dynamic? col_macaddr8_array;

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
    dynamic? col_cidr_array,
    String? col_inet,
    dynamic? col_inet_array,
    String? col_macaddr,
    dynamic? col_macaddr_array,
    String? col_macaddr8,
    dynamic? col_macaddr8_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_cidr != null) 'col_cidr': col_cidr.toString(),
      if (col_cidr_array != null) 'col_cidr_array': col_cidr_array.toString(),
      if (col_inet != null) 'col_inet': col_inet.toString(),
      if (col_inet_array != null) 'col_inet_array': col_inet_array.toString(),
      if (col_macaddr != null) 'col_macaddr': col_macaddr.toString(),
      if (col_macaddr_array != null)
        'col_macaddr_array': col_macaddr_array.toString(),
      if (col_macaddr8 != null) 'col_macaddr8': col_macaddr8.toString(),
      if (col_macaddr8_array != null)
        'col_macaddr8_array': col_macaddr8_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? col_cidr,
    dynamic? col_cidr_array,
    String? col_inet,
    dynamic? col_inet_array,
    String? col_macaddr,
    dynamic? col_macaddr_array,
    String? col_macaddr8,
    dynamic? col_macaddr8_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_cidr != null) 'col_cidr': col_cidr.toString(),
      if (col_cidr_array != null) 'col_cidr_array': col_cidr_array.toString(),
      if (col_inet != null) 'col_inet': col_inet.toString(),
      if (col_inet_array != null) 'col_inet_array': col_inet_array.toString(),
      if (col_macaddr != null) 'col_macaddr': col_macaddr.toString(),
      if (col_macaddr_array != null)
        'col_macaddr_array': col_macaddr_array.toString(),
      if (col_macaddr8 != null) 'col_macaddr8': col_macaddr8.toString(),
      if (col_macaddr8_array != null)
        'col_macaddr8_array': col_macaddr8_array.toString(),
    };
  }

  factory NetworkTypes.fromJson(Map<String, dynamic> json) {
    return NetworkTypes(
      id: json['id'] as String,
      col_cidr: json['col_cidr'] != null ? json['col_cidr'] as String : null,
      col_cidr_array: json['col_cidr_array'] != null
          ? json['col_cidr_array'] as dynamic
          : null,
      col_inet: json['col_inet'] != null ? json['col_inet'] as String : null,
      col_inet_array: json['col_inet_array'] != null
          ? json['col_inet_array'] as dynamic
          : null,
      col_macaddr:
          json['col_macaddr'] != null ? json['col_macaddr'] as String : null,
      col_macaddr_array: json['col_macaddr_array'] != null
          ? json['col_macaddr_array'] as dynamic
          : null,
      col_macaddr8:
          json['col_macaddr8'] != null ? json['col_macaddr8'] as String : null,
      col_macaddr8_array: json['col_macaddr8_array'] != null
          ? json['col_macaddr8_array'] as dynamic
          : null,
    );
  }
}

class NumericTypes {
  final String id;
  final BigInt? col_bigint;
  final dynamic? col_bigint_array;
  final BigInt col_bigserial;
  final dynamic? col_bigserial_array;
  final int? col_integer;
  final dynamic? col_integer_array;
  final int? col_smallint;
  final dynamic? col_smallint_array;
  final int col_smallserial;
  final dynamic? col_smallserial_array;
  final int col_serial;
  final dynamic? col_serial_array;
  final double? col_double;
  final dynamic? col_double_array;
  final double? col_real;
  final dynamic? col_real_array;
  final num? col_numeric;
  final dynamic? col_numeric_array;

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
    dynamic? col_bigint_array,
    BigInt? col_bigserial,
    dynamic? col_bigserial_array,
    int? col_integer,
    dynamic? col_integer_array,
    int? col_smallint,
    dynamic? col_smallint_array,
    int? col_smallserial,
    dynamic? col_smallserial_array,
    int? col_serial,
    dynamic? col_serial_array,
    double? col_double,
    dynamic? col_double_array,
    double? col_real,
    dynamic? col_real_array,
    num? col_numeric,
    dynamic? col_numeric_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bigint != null) 'col_bigint': col_bigint.toString(),
      if (col_bigint_array != null)
        'col_bigint_array': col_bigint_array.toString(),
      if (col_bigserial != null) 'col_bigserial': col_bigserial.toString(),
      if (col_bigserial_array != null)
        'col_bigserial_array': col_bigserial_array.toString(),
      if (col_integer != null) 'col_integer': col_integer.toString(),
      if (col_integer_array != null)
        'col_integer_array': col_integer_array.toString(),
      if (col_smallint != null) 'col_smallint': col_smallint.toString(),
      if (col_smallint_array != null)
        'col_smallint_array': col_smallint_array.toString(),
      if (col_smallserial != null)
        'col_smallserial': col_smallserial.toString(),
      if (col_smallserial_array != null)
        'col_smallserial_array': col_smallserial_array.toString(),
      if (col_serial != null) 'col_serial': col_serial.toString(),
      if (col_serial_array != null)
        'col_serial_array': col_serial_array.toString(),
      if (col_double != null) 'col_double': col_double.toString(),
      if (col_double_array != null)
        'col_double_array': col_double_array.toString(),
      if (col_real != null) 'col_real': col_real.toString(),
      if (col_real_array != null) 'col_real_array': col_real_array.toString(),
      if (col_numeric != null) 'col_numeric': col_numeric.toString(),
      if (col_numeric_array != null)
        'col_numeric_array': col_numeric_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    BigInt? col_bigint,
    dynamic? col_bigint_array,
    BigInt? col_bigserial,
    dynamic? col_bigserial_array,
    int? col_integer,
    dynamic? col_integer_array,
    int? col_smallint,
    dynamic? col_smallint_array,
    int? col_smallserial,
    dynamic? col_smallserial_array,
    int? col_serial,
    dynamic? col_serial_array,
    double? col_double,
    dynamic? col_double_array,
    double? col_real,
    dynamic? col_real_array,
    num? col_numeric,
    dynamic? col_numeric_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_bigint != null) 'col_bigint': col_bigint.toString(),
      if (col_bigint_array != null)
        'col_bigint_array': col_bigint_array.toString(),
      if (col_bigserial != null) 'col_bigserial': col_bigserial.toString(),
      if (col_bigserial_array != null)
        'col_bigserial_array': col_bigserial_array.toString(),
      if (col_integer != null) 'col_integer': col_integer.toString(),
      if (col_integer_array != null)
        'col_integer_array': col_integer_array.toString(),
      if (col_smallint != null) 'col_smallint': col_smallint.toString(),
      if (col_smallint_array != null)
        'col_smallint_array': col_smallint_array.toString(),
      if (col_smallserial != null)
        'col_smallserial': col_smallserial.toString(),
      if (col_smallserial_array != null)
        'col_smallserial_array': col_smallserial_array.toString(),
      if (col_serial != null) 'col_serial': col_serial.toString(),
      if (col_serial_array != null)
        'col_serial_array': col_serial_array.toString(),
      if (col_double != null) 'col_double': col_double.toString(),
      if (col_double_array != null)
        'col_double_array': col_double_array.toString(),
      if (col_real != null) 'col_real': col_real.toString(),
      if (col_real_array != null) 'col_real_array': col_real_array.toString(),
      if (col_numeric != null) 'col_numeric': col_numeric.toString(),
      if (col_numeric_array != null)
        'col_numeric_array': col_numeric_array.toString(),
    };
  }

  factory NumericTypes.fromJson(Map<String, dynamic> json) {
    return NumericTypes(
      id: json['id'] as String,
      col_bigint: json['col_bigint'] != null
          ? BigInt.tryParse(json['col_bigint'].toString())
          : null,
      col_bigint_array: json['col_bigint_array'] != null
          ? json['col_bigint_array'] as dynamic
          : null,
      col_bigserial: BigInt.parse(json['col_bigserial'].toString()),
      col_bigserial_array: json['col_bigserial_array'] != null
          ? json['col_bigserial_array'] as dynamic
          : null,
      col_integer:
          json['col_integer'] != null ? json['col_integer'] as int : null,
      col_integer_array: json['col_integer_array'] != null
          ? json['col_integer_array'] as dynamic
          : null,
      col_smallint:
          json['col_smallint'] != null ? json['col_smallint'] as int : null,
      col_smallint_array: json['col_smallint_array'] != null
          ? json['col_smallint_array'] as dynamic
          : null,
      col_smallserial: json['col_smallserial'] as int,
      col_smallserial_array: json['col_smallserial_array'] != null
          ? json['col_smallserial_array'] as dynamic
          : null,
      col_serial: json['col_serial'] as int,
      col_serial_array: json['col_serial_array'] != null
          ? json['col_serial_array'] as dynamic
          : null,
      col_double: json['col_double'] != null
          ? double.tryParse(json['col_double'].toString())
          : null,
      col_double_array: json['col_double_array'] != null
          ? json['col_double_array'] as dynamic
          : null,
      col_real: json['col_real'] != null
          ? double.tryParse(json['col_real'].toString())
          : null,
      col_real_array: json['col_real_array'] != null
          ? json['col_real_array'] as dynamic
          : null,
      col_numeric: json['col_numeric'] != null
          ? num.tryParse(json['col_numeric'].toString())
          : null,
      col_numeric_array: json['col_numeric_array'] != null
          ? json['col_numeric_array'] as dynamic
          : null,
    );
  }
}

class DatetimeTypes {
  final String id;
  final DateTime? col_date;
  final dynamic? col_date_array;
  final DateTime? col_time;
  final dynamic? col_time_array;
  final DateTime? col_timetz;
  final dynamic? col_timetz_array;
  final DateTime? col_timestamp;
  final dynamic? col_timestamp_array;
  final DateTime? col_timestamptz;
  final dynamic? col_timestamptz_array;
  final Duration? col_interval;
  final dynamic? col_interval_array;

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
    dynamic? col_date_array,
    DateTime? col_time,
    dynamic? col_time_array,
    DateTime? col_timetz,
    dynamic? col_timetz_array,
    DateTime? col_timestamp,
    dynamic? col_timestamp_array,
    DateTime? col_timestamptz,
    dynamic? col_timestamptz_array,
    Duration? col_interval,
    dynamic? col_interval_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_date != null) 'col_date': col_date.toIso8601String(),
      if (col_date_array != null) 'col_date_array': col_date_array.toString(),
      if (col_time != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(col_time),
      if (col_time_array != null) 'col_time_array': col_time_array.toString(),
      if (col_timetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(col_timetz),
      if (col_timetz_array != null)
        'col_timetz_array': col_timetz_array.toString(),
      if (col_timestamp != null)
        'col_timestamp': col_timestamp.toIso8601String(),
      if (col_timestamp_array != null)
        'col_timestamp_array': col_timestamp_array.toString(),
      if (col_timestamptz != null)
        'col_timestamptz': col_timestamptz.toUtc().toString(),
      if (col_timestamptz_array != null)
        'col_timestamptz_array': col_timestamptz_array.toString(),
      if (col_interval != null) 'col_interval': col_interval.toString(),
      if (col_interval_array != null)
        'col_interval_array': col_interval_array.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    DateTime? col_date,
    dynamic? col_date_array,
    DateTime? col_time,
    dynamic? col_time_array,
    DateTime? col_timetz,
    dynamic? col_timetz_array,
    DateTime? col_timestamp,
    dynamic? col_timestamp_array,
    DateTime? col_timestamptz,
    dynamic? col_timestamptz_array,
    Duration? col_interval,
    dynamic? col_interval_array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (col_date != null) 'col_date': col_date.toIso8601String(),
      if (col_date_array != null) 'col_date_array': col_date_array.toString(),
      if (col_time != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(col_time),
      if (col_time_array != null) 'col_time_array': col_time_array.toString(),
      if (col_timetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(col_timetz),
      if (col_timetz_array != null)
        'col_timetz_array': col_timetz_array.toString(),
      if (col_timestamp != null)
        'col_timestamp': col_timestamp.toIso8601String(),
      if (col_timestamp_array != null)
        'col_timestamp_array': col_timestamp_array.toString(),
      if (col_timestamptz != null)
        'col_timestamptz': col_timestamptz.toUtc().toString(),
      if (col_timestamptz_array != null)
        'col_timestamptz_array': col_timestamptz_array.toString(),
      if (col_interval != null) 'col_interval': col_interval.toString(),
      if (col_interval_array != null)
        'col_interval_array': col_interval_array.toString(),
    };
  }

  factory DatetimeTypes.fromJson(Map<String, dynamic> json) {
    return DatetimeTypes(
      id: json['id'] as String,
      col_date: json['col_date'] != null
          ? DateTime.tryParse(json['col_date'].toString())
          : null,
      col_date_array: json['col_date_array'] != null
          ? json['col_date_array'] as dynamic
          : null,
      col_time: json['col_time'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_time'].toString()}")
          : null,
      col_time_array: json['col_time_array'] != null
          ? json['col_time_array'] as dynamic
          : null,
      col_timetz: json['col_timetz'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_timetz'].toString()}")
          : null,
      col_timetz_array: json['col_timetz_array'] != null
          ? json['col_timetz_array'] as dynamic
          : null,
      col_timestamp: json['col_timestamp'] != null
          ? DateTime.tryParse(json['col_timestamp'].toString())
          : null,
      col_timestamp_array: json['col_timestamp_array'] != null
          ? json['col_timestamp_array'] as dynamic
          : null,
      col_timestamptz: json['col_timestamptz'] != null
          ? DateTime.tryParse(json['col_timestamptz'].toString())
          : null,
      col_timestamptz_array: json['col_timestamptz_array'] != null
          ? json['col_timestamptz_array'] as dynamic
          : null,
      col_interval: json['col_interval'] != null
          ? json['col_interval'] as Duration
          : null,
      col_interval_array: json['col_interval_array'] != null
          ? json['col_interval_array'] as dynamic
          : null,
    );
  }
}
