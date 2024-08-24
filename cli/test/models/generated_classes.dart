// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison
import 'package:supabase/supabase.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// INTL is an official package from Dart and is used for parsing dates
// flutter pub add intl or dart pub add intl
// THIS FILE IS AUTO GENERATED. MODIFY WITH CAUTION
extension SupadartClient on SupabaseClient {
  SupabaseQueryBuilder get string_types => from('string_types');
  SupabaseQueryBuilder get boolean_bit_types => from('boolean_bit_types');
  SupabaseQueryBuilder get combined_types_view => from('combined_types_view');
  SupabaseQueryBuilder get misc_types => from('misc_types');
  SupabaseQueryBuilder get books => from('books');
  SupabaseQueryBuilder get geometric_types => from('geometric_types');
  SupabaseQueryBuilder get enum_types => from('enum_types');
  SupabaseQueryBuilder get json_types => from('json_types');
  SupabaseQueryBuilder get binary_xml_types => from('binary_xml_types');
  SupabaseQueryBuilder get network_types => from('network_types');
  SupabaseQueryBuilder get numeric_types => from('numeric_types');
  SupabaseQueryBuilder get datetime_types => from('datetime_types');
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

  static converter(List<Map<String, dynamic>> data) {
    throw UnimplementedError();
  }

  static converterSingle(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

enum MOOD { happy, sad, neutral, excited, angry }

class StringTypes implements SupadartClass<StringTypes> {
  final String id;
  final String? colUuid;
  final List<String>? colUuidArray;
  final String? colCharacter;
  final List<String>? colCharacterArray;
  final String? colCharactervarying;
  final List<String>? colCharactervaryingArray;
  final String? colText;
  final List<String>? colTextArray;

  const StringTypes({
    required this.id,
    this.colUuid,
    this.colUuidArray,
    this.colCharacter,
    this.colCharacterArray,
    this.colCharactervarying,
    this.colCharactervaryingArray,
    this.colText,
    this.colTextArray,
  });

  static String get table_name => 'string_types';
  static String get c_id => 'id';
  static String get c_colUuid => 'col_uuid';
  static String get c_colUuidArray => 'col_uuid_array';
  static String get c_colCharacter => 'col_character';
  static String get c_colCharacterArray => 'col_character_array';
  static String get c_colCharactervarying => 'col_charactervarying';
  static String get c_colCharactervaryingArray => 'col_charactervarying_array';
  static String get c_colText => 'col_text';
  static String get c_colTextArray => 'col_text_array';

  static List<StringTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(StringTypes.fromJson).toList();
  }

  static StringTypes converterSingle(Map<String, dynamic> data) {
    return StringTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    String? colUuid,
    List<String>? colUuidArray,
    String? colCharacter,
    List<String>? colCharacterArray,
    String? colCharactervarying,
    List<String>? colCharactervaryingArray,
    String? colText,
    List<String>? colTextArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colUuid != null) 'col_uuid': colUuid.toString(),
      if (colUuidArray != null)
        'col_uuid_array':
            colUuidArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colCharacter != null) 'col_character': colCharacter.toString(),
      if (colCharacterArray != null)
        'col_character_array': colCharacterArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colCharactervarying != null)
        'col_charactervarying': colCharactervarying.toString(),
      if (colCharactervaryingArray != null)
        'col_charactervarying_array': colCharactervaryingArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colText != null) 'col_text': colText.toString(),
      if (colTextArray != null)
        'col_text_array':
            colTextArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? colUuid,
    List<String>? colUuidArray,
    String? colCharacter,
    List<String>? colCharacterArray,
    String? colCharactervarying,
    List<String>? colCharactervaryingArray,
    String? colText,
    List<String>? colTextArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colUuid != null) 'col_uuid': colUuid.toString(),
      if (colUuidArray != null)
        'col_uuid_array':
            colUuidArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colCharacter != null) 'col_character': colCharacter.toString(),
      if (colCharacterArray != null)
        'col_character_array': colCharacterArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colCharactervarying != null)
        'col_charactervarying': colCharactervarying.toString(),
      if (colCharactervaryingArray != null)
        'col_charactervarying_array': colCharactervaryingArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colText != null) 'col_text': colText.toString(),
      if (colTextArray != null)
        'col_text_array':
            colTextArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  factory StringTypes.fromJson(Map<String, dynamic> json) {
    return StringTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colUuid: json['col_uuid'] != null ? json['col_uuid'].toString() : '',
      colUuidArray: json['col_uuid_array'] != null
          ? (json['col_uuid_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colCharacter:
          json['col_character'] != null ? json['col_character'].toString() : '',
      colCharacterArray: json['col_character_array'] != null
          ? (json['col_character_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colCharactervarying: json['col_charactervarying'] != null
          ? json['col_charactervarying'].toString()
          : '',
      colCharactervaryingArray: json['col_charactervarying_array'] != null
          ? (json['col_charactervarying_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colText: json['col_text'] != null ? json['col_text'].toString() : '',
      colTextArray: json['col_text_array'] != null
          ? (json['col_text_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colUuid != null) 'col_uuid': colUuid,
      if (colUuidArray != null) 'col_uuid_array': colUuidArray,
      if (colCharacter != null) 'col_character': colCharacter,
      if (colCharacterArray != null) 'col_character_array': colCharacterArray,
      if (colCharactervarying != null)
        'col_charactervarying': colCharactervarying,
      if (colCharactervaryingArray != null)
        'col_charactervarying_array': colCharactervaryingArray,
      if (colText != null) 'col_text': colText,
      if (colTextArray != null) 'col_text_array': colTextArray,
    };
  }
}

class BooleanBitTypes implements SupadartClass<BooleanBitTypes> {
  final String id;
  final bool? colBoolean;
  final List<bool>? colBooleanArray;
  final String? colBit;
  final List<String>? colBitArray;
  final String? colBitvarying;
  final List<String>? colBitvaryingArray;

  const BooleanBitTypes({
    required this.id,
    this.colBoolean,
    this.colBooleanArray,
    this.colBit,
    this.colBitArray,
    this.colBitvarying,
    this.colBitvaryingArray,
  });

  static String get table_name => 'boolean_bit_types';
  static String get c_id => 'id';
  static String get c_colBoolean => 'col_boolean';
  static String get c_colBooleanArray => 'col_boolean_array';
  static String get c_colBit => 'col_bit';
  static String get c_colBitArray => 'col_bit_array';
  static String get c_colBitvarying => 'col_bitvarying';
  static String get c_colBitvaryingArray => 'col_bitvarying_array';

  static List<BooleanBitTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(BooleanBitTypes.fromJson).toList();
  }

  static BooleanBitTypes converterSingle(Map<String, dynamic> data) {
    return BooleanBitTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    bool? colBoolean,
    List<bool>? colBooleanArray,
    String? colBit,
    List<String>? colBitArray,
    String? colBitvarying,
    List<String>? colBitvaryingArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBoolean != null) 'col_boolean': colBoolean.toString(),
      if (colBooleanArray != null)
        'col_boolean_array': colBooleanArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colBit != null) 'col_bit': colBit.toString(),
      if (colBitArray != null)
        'col_bit_array':
            colBitArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBitvarying != null) 'col_bitvarying': colBitvarying.toString(),
      if (colBitvaryingArray != null)
        'col_bitvarying_array': colBitvaryingArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    bool? colBoolean,
    List<bool>? colBooleanArray,
    String? colBit,
    List<String>? colBitArray,
    String? colBitvarying,
    List<String>? colBitvaryingArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBoolean != null) 'col_boolean': colBoolean.toString(),
      if (colBooleanArray != null)
        'col_boolean_array': colBooleanArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colBit != null) 'col_bit': colBit.toString(),
      if (colBitArray != null)
        'col_bit_array':
            colBitArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBitvarying != null) 'col_bitvarying': colBitvarying.toString(),
      if (colBitvaryingArray != null)
        'col_bitvarying_array': colBitvaryingArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory BooleanBitTypes.fromJson(Map<String, dynamic> json) {
    return BooleanBitTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colBoolean:
          json['col_boolean'] != null ? json['col_boolean'] as bool : false,
      colBooleanArray: json['col_boolean_array'] != null
          ? (json['col_boolean_array'] as List<dynamic>)
              .map((v) => v as bool)
              .toList()
          : <bool>[],
      colBit: json['col_bit'] != null ? json['col_bit'].toString() : '',
      colBitArray: json['col_bit_array'] != null
          ? (json['col_bit_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colBitvarying: json['col_bitvarying'] != null
          ? json['col_bitvarying'].toString()
          : '',
      colBitvaryingArray: json['col_bitvarying_array'] != null
          ? (json['col_bitvarying_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colBoolean != null) 'col_boolean': colBoolean,
      if (colBooleanArray != null) 'col_boolean_array': colBooleanArray,
      if (colBit != null) 'col_bit': colBit,
      if (colBitArray != null) 'col_bit_array': colBitArray,
      if (colBitvarying != null) 'col_bitvarying': colBitvarying,
      if (colBitvaryingArray != null)
        'col_bitvarying_array': colBitvaryingArray,
    };
  }
}

class CombinedTypesView implements SupadartClass<CombinedTypesView> {
  final String? numericId;
  final int? colInteger;
  final double? colDouble;
  final String? stringId;
  final String? colText;
  final String? colUuid;

  const CombinedTypesView({
    this.numericId,
    this.colInteger,
    this.colDouble,
    this.stringId,
    this.colText,
    this.colUuid,
  });

  static String get table_name => 'combined_types_view';
  static String get c_numericId => 'numeric_id';
  static String get c_colInteger => 'col_integer';
  static String get c_colDouble => 'col_double';
  static String get c_stringId => 'string_id';
  static String get c_colText => 'col_text';
  static String get c_colUuid => 'col_uuid';

  static List<CombinedTypesView> converter(List<Map<String, dynamic>> data) {
    return data.map(CombinedTypesView.fromJson).toList();
  }

  static CombinedTypesView converterSingle(Map<String, dynamic> data) {
    return CombinedTypesView.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? numericId,
    int? colInteger,
    double? colDouble,
    String? stringId,
    String? colText,
    String? colUuid,
  }) {
    return {
      if (numericId != null) 'numeric_id': numericId.toString(),
      if (colInteger != null) 'col_integer': colInteger.toString(),
      if (colDouble != null) 'col_double': colDouble.toString(),
      if (stringId != null) 'string_id': stringId.toString(),
      if (colText != null) 'col_text': colText.toString(),
      if (colUuid != null) 'col_uuid': colUuid.toString(),
    };
  }

  static Map<String, dynamic> update({
    String? numericId,
    int? colInteger,
    double? colDouble,
    String? stringId,
    String? colText,
    String? colUuid,
  }) {
    return {
      if (numericId != null) 'numeric_id': numericId.toString(),
      if (colInteger != null) 'col_integer': colInteger.toString(),
      if (colDouble != null) 'col_double': colDouble.toString(),
      if (stringId != null) 'string_id': stringId.toString(),
      if (colText != null) 'col_text': colText.toString(),
      if (colUuid != null) 'col_uuid': colUuid.toString(),
    };
  }

  factory CombinedTypesView.fromJson(Map<String, dynamic> json) {
    return CombinedTypesView(
      numericId:
          json['numeric_id'] != null ? json['numeric_id'].toString() : '',
      colInteger: json['col_integer'] != null ? json['col_integer'] as int : 0,
      colDouble: json['col_double'] != null
          ? double.tryParse(json['col_double'].toString())
          : 0.0,
      stringId: json['string_id'] != null ? json['string_id'].toString() : '',
      colText: json['col_text'] != null ? json['col_text'].toString() : '',
      colUuid: json['col_uuid'] != null ? json['col_uuid'].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (numericId != null) 'numeric_id': numericId,
      if (colInteger != null) 'col_integer': colInteger,
      if (colDouble != null) 'col_double': colDouble,
      if (stringId != null) 'string_id': stringId,
      if (colText != null) 'col_text': colText,
      if (colUuid != null) 'col_uuid': colUuid,
    };
  }
}

class MiscTypes implements SupadartClass<MiscTypes> {
  final String id;
  final String? colMoney;
  final List<String>? colMoneyArray;
  final String? colPgLsn;
  final List<String>? colPgLsnArray;
  final String? colPgSnapshot;
  final List<String>? colPgSnapshotArray;
  final String? colTsquery;
  final List<String>? colTsqueryArray;
  final String? colTsvector;
  final List<String>? colTsvectorArray;
  final String? colTxidSnapshot;
  final List<String>? colTxidSnapshotArray;

  const MiscTypes({
    required this.id,
    this.colMoney,
    this.colMoneyArray,
    this.colPgLsn,
    this.colPgLsnArray,
    this.colPgSnapshot,
    this.colPgSnapshotArray,
    this.colTsquery,
    this.colTsqueryArray,
    this.colTsvector,
    this.colTsvectorArray,
    this.colTxidSnapshot,
    this.colTxidSnapshotArray,
  });

  static String get table_name => 'misc_types';
  static String get c_id => 'id';
  static String get c_colMoney => 'col_money';
  static String get c_colMoneyArray => 'col_money_array';
  static String get c_colPgLsn => 'col_pg_lsn';
  static String get c_colPgLsnArray => 'col_pg_lsn_array';
  static String get c_colPgSnapshot => 'col_pg_snapshot';
  static String get c_colPgSnapshotArray => 'col_pg_snapshot_array';
  static String get c_colTsquery => 'col_tsquery';
  static String get c_colTsqueryArray => 'col_tsquery_array';
  static String get c_colTsvector => 'col_tsvector';
  static String get c_colTsvectorArray => 'col_tsvector_array';
  static String get c_colTxidSnapshot => 'col_txid_snapshot';
  static String get c_colTxidSnapshotArray => 'col_txid_snapshot_array';

  static List<MiscTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(MiscTypes.fromJson).toList();
  }

  static MiscTypes converterSingle(Map<String, dynamic> data) {
    return MiscTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    String? colMoney,
    List<String>? colMoneyArray,
    String? colPgLsn,
    List<String>? colPgLsnArray,
    String? colPgSnapshot,
    List<String>? colPgSnapshotArray,
    String? colTsquery,
    List<String>? colTsqueryArray,
    String? colTsvector,
    List<String>? colTsvectorArray,
    String? colTxidSnapshot,
    List<String>? colTxidSnapshotArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colMoney != null) 'col_money': colMoney.toString(),
      if (colMoneyArray != null)
        'col_money_array':
            colMoneyArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPgLsn != null) 'col_pg_lsn': colPgLsn.toString(),
      if (colPgLsnArray != null)
        'col_pg_lsn_array':
            colPgLsnArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPgSnapshot != null) 'col_pg_snapshot': colPgSnapshot.toString(),
      if (colPgSnapshotArray != null)
        'col_pg_snapshot_array': colPgSnapshotArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTsquery != null) 'col_tsquery': colTsquery.toString(),
      if (colTsqueryArray != null)
        'col_tsquery_array': colTsqueryArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTsvector != null) 'col_tsvector': colTsvector.toString(),
      if (colTsvectorArray != null)
        'col_tsvector_array': colTsvectorArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTxidSnapshot != null)
        'col_txid_snapshot': colTxidSnapshot.toString(),
      if (colTxidSnapshotArray != null)
        'col_txid_snapshot_array': colTxidSnapshotArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? colMoney,
    List<String>? colMoneyArray,
    String? colPgLsn,
    List<String>? colPgLsnArray,
    String? colPgSnapshot,
    List<String>? colPgSnapshotArray,
    String? colTsquery,
    List<String>? colTsqueryArray,
    String? colTsvector,
    List<String>? colTsvectorArray,
    String? colTxidSnapshot,
    List<String>? colTxidSnapshotArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colMoney != null) 'col_money': colMoney.toString(),
      if (colMoneyArray != null)
        'col_money_array':
            colMoneyArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPgLsn != null) 'col_pg_lsn': colPgLsn.toString(),
      if (colPgLsnArray != null)
        'col_pg_lsn_array':
            colPgLsnArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPgSnapshot != null) 'col_pg_snapshot': colPgSnapshot.toString(),
      if (colPgSnapshotArray != null)
        'col_pg_snapshot_array': colPgSnapshotArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTsquery != null) 'col_tsquery': colTsquery.toString(),
      if (colTsqueryArray != null)
        'col_tsquery_array': colTsqueryArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTsvector != null) 'col_tsvector': colTsvector.toString(),
      if (colTsvectorArray != null)
        'col_tsvector_array': colTsvectorArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTxidSnapshot != null)
        'col_txid_snapshot': colTxidSnapshot.toString(),
      if (colTxidSnapshotArray != null)
        'col_txid_snapshot_array': colTxidSnapshotArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory MiscTypes.fromJson(Map<String, dynamic> json) {
    return MiscTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colMoney: json['col_money'] != null ? json['col_money'].toString() : '',
      colMoneyArray: json['col_money_array'] != null
          ? (json['col_money_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colPgLsn: json['col_pg_lsn'] != null ? json['col_pg_lsn'].toString() : '',
      colPgLsnArray: json['col_pg_lsn_array'] != null
          ? (json['col_pg_lsn_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colPgSnapshot: json['col_pg_snapshot'] != null
          ? json['col_pg_snapshot'].toString()
          : '',
      colPgSnapshotArray: json['col_pg_snapshot_array'] != null
          ? (json['col_pg_snapshot_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colTsquery:
          json['col_tsquery'] != null ? json['col_tsquery'].toString() : '',
      colTsqueryArray: json['col_tsquery_array'] != null
          ? (json['col_tsquery_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colTsvector:
          json['col_tsvector'] != null ? json['col_tsvector'].toString() : '',
      colTsvectorArray: json['col_tsvector_array'] != null
          ? (json['col_tsvector_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colTxidSnapshot: json['col_txid_snapshot'] != null
          ? json['col_txid_snapshot'].toString()
          : '',
      colTxidSnapshotArray: json['col_txid_snapshot_array'] != null
          ? (json['col_txid_snapshot_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colMoney != null) 'col_money': colMoney,
      if (colMoneyArray != null) 'col_money_array': colMoneyArray,
      if (colPgLsn != null) 'col_pg_lsn': colPgLsn,
      if (colPgLsnArray != null) 'col_pg_lsn_array': colPgLsnArray,
      if (colPgSnapshot != null) 'col_pg_snapshot': colPgSnapshot,
      if (colPgSnapshotArray != null)
        'col_pg_snapshot_array': colPgSnapshotArray,
      if (colTsquery != null) 'col_tsquery': colTsquery,
      if (colTsqueryArray != null) 'col_tsquery_array': colTsqueryArray,
      if (colTsvector != null) 'col_tsvector': colTsvector,
      if (colTsvectorArray != null) 'col_tsvector_array': colTsvectorArray,
      if (colTxidSnapshot != null) 'col_txid_snapshot': colTxidSnapshot,
      if (colTxidSnapshotArray != null)
        'col_txid_snapshot_array': colTxidSnapshotArray,
    };
  }
}

class Books implements SupadartClass<Books> {
  final BigInt id;
  final String name;
  final String? description;
  final int price;
  final DateTime? createdAt;

  const Books({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.createdAt,
  });

  static String get table_name => 'books';
  static String get c_id => 'id';
  static String get c_name => 'name';
  static String get c_description => 'description';
  static String get c_price => 'price';
  static String get c_createdAt => 'created_at';

  static List<Books> converter(List<Map<String, dynamic>> data) {
    return data.map(Books.fromJson).toList();
  }

  static Books converterSingle(Map<String, dynamic> data) {
    return Books.fromJson(data);
  }

  static Map<String, dynamic> insert({
    BigInt? id,
    required String name,
    String? description,
    required int price,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      'name': name.toString(),
      if (description != null) 'description': description.toString(),
      'price': price.toString(),
      if (createdAt != null) 'created_at': createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> update({
    BigInt? id,
    String? name,
    String? description,
    int? price,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (name != null) 'name': name.toString(),
      if (description != null) 'description': description.toString(),
      if (price != null) 'price': price.toString(),
      if (createdAt != null) 'created_at': createdAt.toUtc().toString(),
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
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (createdAt != null) 'created_at': createdAt,
    };
  }
}

class GeometricTypes implements SupadartClass<GeometricTypes> {
  final String id;
  final String? colPoint;
  final List<String>? colPointArray;
  final String? colLine;
  final List<String>? colLineArray;
  final String? colLseg;
  final List<String>? colLsegArray;
  final String? colBox;
  final List<String>? colBoxArray;
  final String? colPath;
  final List<String>? colPathArray;
  final String? colPolygon;
  final List<String>? colPolygonArray;
  final String? colCircle;
  final List<String>? colCircleArray;

  const GeometricTypes({
    required this.id,
    this.colPoint,
    this.colPointArray,
    this.colLine,
    this.colLineArray,
    this.colLseg,
    this.colLsegArray,
    this.colBox,
    this.colBoxArray,
    this.colPath,
    this.colPathArray,
    this.colPolygon,
    this.colPolygonArray,
    this.colCircle,
    this.colCircleArray,
  });

  static String get table_name => 'geometric_types';
  static String get c_id => 'id';
  static String get c_colPoint => 'col_point';
  static String get c_colPointArray => 'col_point_array';
  static String get c_colLine => 'col_line';
  static String get c_colLineArray => 'col_line_array';
  static String get c_colLseg => 'col_lseg';
  static String get c_colLsegArray => 'col_lseg_array';
  static String get c_colBox => 'col_box';
  static String get c_colBoxArray => 'col_box_array';
  static String get c_colPath => 'col_path';
  static String get c_colPathArray => 'col_path_array';
  static String get c_colPolygon => 'col_polygon';
  static String get c_colPolygonArray => 'col_polygon_array';
  static String get c_colCircle => 'col_circle';
  static String get c_colCircleArray => 'col_circle_array';

  static List<GeometricTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(GeometricTypes.fromJson).toList();
  }

  static GeometricTypes converterSingle(Map<String, dynamic> data) {
    return GeometricTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    String? colPoint,
    List<String>? colPointArray,
    String? colLine,
    List<String>? colLineArray,
    String? colLseg,
    List<String>? colLsegArray,
    String? colBox,
    List<String>? colBoxArray,
    String? colPath,
    List<String>? colPathArray,
    String? colPolygon,
    List<String>? colPolygonArray,
    String? colCircle,
    List<String>? colCircleArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colPoint != null) 'col_point': colPoint.toString(),
      if (colPointArray != null)
        'col_point_array':
            colPointArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colLine != null) 'col_line': colLine.toString(),
      if (colLineArray != null)
        'col_line_array':
            colLineArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colLseg != null) 'col_lseg': colLseg.toString(),
      if (colLsegArray != null)
        'col_lseg_array':
            colLsegArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBox != null) 'col_box': colBox.toString(),
      if (colBoxArray != null)
        'col_box_array':
            colBoxArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPath != null) 'col_path': colPath.toString(),
      if (colPathArray != null)
        'col_path_array':
            colPathArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPolygon != null) 'col_polygon': colPolygon.toString(),
      if (colPolygonArray != null)
        'col_polygon_array': colPolygonArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colCircle != null) 'col_circle': colCircle.toString(),
      if (colCircleArray != null)
        'col_circle_array':
            colCircleArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? colPoint,
    List<String>? colPointArray,
    String? colLine,
    List<String>? colLineArray,
    String? colLseg,
    List<String>? colLsegArray,
    String? colBox,
    List<String>? colBoxArray,
    String? colPath,
    List<String>? colPathArray,
    String? colPolygon,
    List<String>? colPolygonArray,
    String? colCircle,
    List<String>? colCircleArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colPoint != null) 'col_point': colPoint.toString(),
      if (colPointArray != null)
        'col_point_array':
            colPointArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colLine != null) 'col_line': colLine.toString(),
      if (colLineArray != null)
        'col_line_array':
            colLineArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colLseg != null) 'col_lseg': colLseg.toString(),
      if (colLsegArray != null)
        'col_lseg_array':
            colLsegArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBox != null) 'col_box': colBox.toString(),
      if (colBoxArray != null)
        'col_box_array':
            colBoxArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPath != null) 'col_path': colPath.toString(),
      if (colPathArray != null)
        'col_path_array':
            colPathArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colPolygon != null) 'col_polygon': colPolygon.toString(),
      if (colPolygonArray != null)
        'col_polygon_array': colPolygonArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colCircle != null) 'col_circle': colCircle.toString(),
      if (colCircleArray != null)
        'col_circle_array':
            colCircleArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  factory GeometricTypes.fromJson(Map<String, dynamic> json) {
    return GeometricTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colPoint: json['col_point'] != null ? json['col_point'].toString() : '',
      colPointArray: json['col_point_array'] != null
          ? (json['col_point_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colLine: json['col_line'] != null ? json['col_line'].toString() : '',
      colLineArray: json['col_line_array'] != null
          ? (json['col_line_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colLseg: json['col_lseg'] != null ? json['col_lseg'].toString() : '',
      colLsegArray: json['col_lseg_array'] != null
          ? (json['col_lseg_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colBox: json['col_box'] != null ? json['col_box'].toString() : '',
      colBoxArray: json['col_box_array'] != null
          ? (json['col_box_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colPath: json['col_path'] != null ? json['col_path'].toString() : '',
      colPathArray: json['col_path_array'] != null
          ? (json['col_path_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colPolygon:
          json['col_polygon'] != null ? json['col_polygon'].toString() : '',
      colPolygonArray: json['col_polygon_array'] != null
          ? (json['col_polygon_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colCircle:
          json['col_circle'] != null ? json['col_circle'].toString() : '',
      colCircleArray: json['col_circle_array'] != null
          ? (json['col_circle_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colPoint != null) 'col_point': colPoint,
      if (colPointArray != null) 'col_point_array': colPointArray,
      if (colLine != null) 'col_line': colLine,
      if (colLineArray != null) 'col_line_array': colLineArray,
      if (colLseg != null) 'col_lseg': colLseg,
      if (colLsegArray != null) 'col_lseg_array': colLsegArray,
      if (colBox != null) 'col_box': colBox,
      if (colBoxArray != null) 'col_box_array': colBoxArray,
      if (colPath != null) 'col_path': colPath,
      if (colPathArray != null) 'col_path_array': colPathArray,
      if (colPolygon != null) 'col_polygon': colPolygon,
      if (colPolygonArray != null) 'col_polygon_array': colPolygonArray,
      if (colCircle != null) 'col_circle': colCircle,
      if (colCircleArray != null) 'col_circle_array': colCircleArray,
    };
  }
}

class EnumTypes implements SupadartClass<EnumTypes> {
// [supadart:has_enums]
  final String id;
  final MOOD? colMood;

  const EnumTypes({
    required this.id,
    this.colMood,
  });

  static String get table_name => 'enum_types';
  static String get c_id => 'id';
  static String get c_colMood => 'col_mood';

  static List<EnumTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(EnumTypes.fromJson).toList();
  }

  static EnumTypes converterSingle(Map<String, dynamic> data) {
    return EnumTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    required MOOD colMood,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      'col_mood': colMood.toString().split('.').last,
    };
  }

  static Map<String, dynamic> update({
    String? id,
    MOOD? colMood,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colMood != null) 'col_mood': colMood.toString().split('.').last,
    };
  }

  factory EnumTypes.fromJson(Map<String, dynamic> json) {
    return EnumTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colMood: json['col_mood'] != null
          ? MOOD.values.byName(json['col_mood'].toString())
          : MOOD.values.first,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colMood != null) 'col_mood': colMood,
    };
  }
}

class JsonTypes implements SupadartClass<JsonTypes> {
  final String id;
  final Map<String, dynamic>? colJson;
  final List<Map<String, dynamic>>? colJsonArray;
  final Map<String, dynamic>? colJsonb;
  final List<Map<String, dynamic>>? colJsonbArray;

  const JsonTypes({
    required this.id,
    this.colJson,
    this.colJsonArray,
    this.colJsonb,
    this.colJsonbArray,
  });

  static String get table_name => 'json_types';
  static String get c_id => 'id';
  static String get c_colJson => 'col_json';
  static String get c_colJsonArray => 'col_json_array';
  static String get c_colJsonb => 'col_jsonb';
  static String get c_colJsonbArray => 'col_jsonb_array';

  static List<JsonTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(JsonTypes.fromJson).toList();
  }

  static JsonTypes converterSingle(Map<String, dynamic> data) {
    return JsonTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    Map<String, dynamic>? colJson,
    List<Map<String, dynamic>>? colJsonArray,
    Map<String, dynamic>? colJsonb,
    List<Map<String, dynamic>>? colJsonbArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colJson != null) 'col_json': colJson,
      if (colJsonArray != null)
        'col_json_array': jsonEncode(colJsonArray)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
      if (colJsonb != null) 'col_jsonb': colJsonb,
      if (colJsonbArray != null)
        'col_jsonb_array': jsonEncode(colJsonbArray)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    Map<String, dynamic>? colJson,
    List<Map<String, dynamic>>? colJsonArray,
    Map<String, dynamic>? colJsonb,
    List<Map<String, dynamic>>? colJsonbArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colJson != null) 'col_json': colJson,
      if (colJsonArray != null)
        'col_json_array': jsonEncode(colJsonArray)
            .replaceAll('"', '\\"')
            .replaceAll("{", '"{')
            .replaceAll("}", '}"')
            .replaceAll("[", '{')
            .replaceAll("]", '}'),
      if (colJsonb != null) 'col_jsonb': colJsonb,
      if (colJsonbArray != null)
        'col_jsonb_array': jsonEncode(colJsonbArray)
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
      colJson: json['col_json'] != null
          ? json['col_json'] as Map<String, dynamic>
          : <String, dynamic>{},
      colJsonArray: json['col_json_array'] != null
          ? (json['col_json_array'] as List<dynamic>)
              .map((v) => v as Map<String, dynamic>)
              .toList()
          : <Map<String, dynamic>>[],
      colJsonb: json['col_jsonb'] != null
          ? json['col_jsonb'] as Map<String, dynamic>
          : <String, dynamic>{},
      colJsonbArray: json['col_jsonb_array'] != null
          ? (json['col_jsonb_array'] as List<dynamic>)
              .map((v) => v as Map<String, dynamic>)
              .toList()
          : <Map<String, dynamic>>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colJson != null) 'col_json': colJson,
      if (colJsonArray != null) 'col_json_array': colJsonArray,
      if (colJsonb != null) 'col_jsonb': colJsonb,
      if (colJsonbArray != null) 'col_jsonb_array': colJsonbArray,
    };
  }
}

class BinaryXmlTypes implements SupadartClass<BinaryXmlTypes> {
  final String id;
  final String? colBytea;
  final List<String>? colByteaArray;
  final String? colXml;
  final List<String>? colXmlArray;

  const BinaryXmlTypes({
    required this.id,
    this.colBytea,
    this.colByteaArray,
    this.colXml,
    this.colXmlArray,
  });

  static String get table_name => 'binary_xml_types';
  static String get c_id => 'id';
  static String get c_colBytea => 'col_bytea';
  static String get c_colByteaArray => 'col_bytea_array';
  static String get c_colXml => 'col_xml';
  static String get c_colXmlArray => 'col_xml_array';

  static List<BinaryXmlTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(BinaryXmlTypes.fromJson).toList();
  }

  static BinaryXmlTypes converterSingle(Map<String, dynamic> data) {
    return BinaryXmlTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    String? colBytea,
    List<String>? colByteaArray,
    String? colXml,
    List<String>? colXmlArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBytea != null) 'col_bytea': colBytea.toString(),
      if (colByteaArray != null)
        'col_bytea_array':
            colByteaArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colXml != null) 'col_xml': colXml.toString(),
      if (colXmlArray != null)
        'col_xml_array':
            colXmlArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? colBytea,
    List<String>? colByteaArray,
    String? colXml,
    List<String>? colXmlArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBytea != null) 'col_bytea': colBytea.toString(),
      if (colByteaArray != null)
        'col_bytea_array':
            colByteaArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colXml != null) 'col_xml': colXml.toString(),
      if (colXmlArray != null)
        'col_xml_array':
            colXmlArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
    };
  }

  factory BinaryXmlTypes.fromJson(Map<String, dynamic> json) {
    return BinaryXmlTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colBytea: json['col_bytea'] != null ? json['col_bytea'].toString() : '',
      colByteaArray: json['col_bytea_array'] != null
          ? (json['col_bytea_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colXml: json['col_xml'] != null ? json['col_xml'].toString() : '',
      colXmlArray: json['col_xml_array'] != null
          ? (json['col_xml_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colBytea != null) 'col_bytea': colBytea,
      if (colByteaArray != null) 'col_bytea_array': colByteaArray,
      if (colXml != null) 'col_xml': colXml,
      if (colXmlArray != null) 'col_xml_array': colXmlArray,
    };
  }
}

class NetworkTypes implements SupadartClass<NetworkTypes> {
  final String id;
  final String? colCidr;
  final List<String>? colCidrArray;
  final String? colInet;
  final List<String>? colInetArray;
  final String? colMacaddr;
  final List<String>? colMacaddrArray;
  final String? colMacaddr8;
  final List<String>? colMacaddr8Array;

  const NetworkTypes({
    required this.id,
    this.colCidr,
    this.colCidrArray,
    this.colInet,
    this.colInetArray,
    this.colMacaddr,
    this.colMacaddrArray,
    this.colMacaddr8,
    this.colMacaddr8Array,
  });

  static String get table_name => 'network_types';
  static String get c_id => 'id';
  static String get c_colCidr => 'col_cidr';
  static String get c_colCidrArray => 'col_cidr_array';
  static String get c_colInet => 'col_inet';
  static String get c_colInetArray => 'col_inet_array';
  static String get c_colMacaddr => 'col_macaddr';
  static String get c_colMacaddrArray => 'col_macaddr_array';
  static String get c_colMacaddr8 => 'col_macaddr8';
  static String get c_colMacaddr8Array => 'col_macaddr8_array';

  static List<NetworkTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(NetworkTypes.fromJson).toList();
  }

  static NetworkTypes converterSingle(Map<String, dynamic> data) {
    return NetworkTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    String? colCidr,
    List<String>? colCidrArray,
    String? colInet,
    List<String>? colInetArray,
    String? colMacaddr,
    List<String>? colMacaddrArray,
    String? colMacaddr8,
    List<String>? colMacaddr8Array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colCidr != null) 'col_cidr': colCidr.toString(),
      if (colCidrArray != null)
        'col_cidr_array':
            colCidrArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colInet != null) 'col_inet': colInet.toString(),
      if (colInetArray != null)
        'col_inet_array':
            colInetArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colMacaddr != null) 'col_macaddr': colMacaddr.toString(),
      if (colMacaddrArray != null)
        'col_macaddr_array': colMacaddrArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colMacaddr8 != null) 'col_macaddr8': colMacaddr8.toString(),
      if (colMacaddr8Array != null)
        'col_macaddr8_array': colMacaddr8Array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    String? colCidr,
    List<String>? colCidrArray,
    String? colInet,
    List<String>? colInetArray,
    String? colMacaddr,
    List<String>? colMacaddrArray,
    String? colMacaddr8,
    List<String>? colMacaddr8Array,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colCidr != null) 'col_cidr': colCidr.toString(),
      if (colCidrArray != null)
        'col_cidr_array':
            colCidrArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colInet != null) 'col_inet': colInet.toString(),
      if (colInetArray != null)
        'col_inet_array':
            colInetArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colMacaddr != null) 'col_macaddr': colMacaddr.toString(),
      if (colMacaddrArray != null)
        'col_macaddr_array': colMacaddrArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colMacaddr8 != null) 'col_macaddr8': colMacaddr8.toString(),
      if (colMacaddr8Array != null)
        'col_macaddr8_array': colMacaddr8Array
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory NetworkTypes.fromJson(Map<String, dynamic> json) {
    return NetworkTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colCidr: json['col_cidr'] != null ? json['col_cidr'].toString() : '',
      colCidrArray: json['col_cidr_array'] != null
          ? (json['col_cidr_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colInet: json['col_inet'] != null ? json['col_inet'].toString() : '',
      colInetArray: json['col_inet_array'] != null
          ? (json['col_inet_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colMacaddr:
          json['col_macaddr'] != null ? json['col_macaddr'].toString() : '',
      colMacaddrArray: json['col_macaddr_array'] != null
          ? (json['col_macaddr_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
      colMacaddr8:
          json['col_macaddr8'] != null ? json['col_macaddr8'].toString() : '',
      colMacaddr8Array: json['col_macaddr8_array'] != null
          ? (json['col_macaddr8_array'] as List<dynamic>)
              .map((v) => v as String)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colCidr != null) 'col_cidr': colCidr,
      if (colCidrArray != null) 'col_cidr_array': colCidrArray,
      if (colInet != null) 'col_inet': colInet,
      if (colInetArray != null) 'col_inet_array': colInetArray,
      if (colMacaddr != null) 'col_macaddr': colMacaddr,
      if (colMacaddrArray != null) 'col_macaddr_array': colMacaddrArray,
      if (colMacaddr8 != null) 'col_macaddr8': colMacaddr8,
      if (colMacaddr8Array != null) 'col_macaddr8_array': colMacaddr8Array,
    };
  }
}

class NumericTypes implements SupadartClass<NumericTypes> {
  final String id;
  final BigInt? colBigint;
  final List<BigInt>? colBigintArray;
  final BigInt? colBigserial;
  final List<BigInt>? colBigserialArray;
  final int? colInteger;
  final List<int>? colIntegerArray;
  final int? colSmallint;
  final List<int>? colSmallintArray;
  final int? colSmallserial;
  final List<int>? colSmallserialArray;
  final int? colSerial;
  final List<int>? colSerialArray;
  final double? colDouble;
  final List<double>? colDoubleArray;
  final double? colReal;
  final List<double>? colRealArray;
  final num? colNumeric;
  final List<num>? colNumericArray;

  const NumericTypes({
    required this.id,
    this.colBigint,
    this.colBigintArray,
    this.colBigserial,
    this.colBigserialArray,
    this.colInteger,
    this.colIntegerArray,
    this.colSmallint,
    this.colSmallintArray,
    this.colSmallserial,
    this.colSmallserialArray,
    this.colSerial,
    this.colSerialArray,
    this.colDouble,
    this.colDoubleArray,
    this.colReal,
    this.colRealArray,
    this.colNumeric,
    this.colNumericArray,
  });

  static String get table_name => 'numeric_types';
  static String get c_id => 'id';
  static String get c_colBigint => 'col_bigint';
  static String get c_colBigintArray => 'col_bigint_array';
  static String get c_colBigserial => 'col_bigserial';
  static String get c_colBigserialArray => 'col_bigserial_array';
  static String get c_colInteger => 'col_integer';
  static String get c_colIntegerArray => 'col_integer_array';
  static String get c_colSmallint => 'col_smallint';
  static String get c_colSmallintArray => 'col_smallint_array';
  static String get c_colSmallserial => 'col_smallserial';
  static String get c_colSmallserialArray => 'col_smallserial_array';
  static String get c_colSerial => 'col_serial';
  static String get c_colSerialArray => 'col_serial_array';
  static String get c_colDouble => 'col_double';
  static String get c_colDoubleArray => 'col_double_array';
  static String get c_colReal => 'col_real';
  static String get c_colRealArray => 'col_real_array';
  static String get c_colNumeric => 'col_numeric';
  static String get c_colNumericArray => 'col_numeric_array';

  static List<NumericTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(NumericTypes.fromJson).toList();
  }

  static NumericTypes converterSingle(Map<String, dynamic> data) {
    return NumericTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    BigInt? colBigint,
    List<BigInt>? colBigintArray,
    BigInt? colBigserial,
    List<BigInt>? colBigserialArray,
    int? colInteger,
    List<int>? colIntegerArray,
    int? colSmallint,
    List<int>? colSmallintArray,
    int? colSmallserial,
    List<int>? colSmallserialArray,
    int? colSerial,
    List<int>? colSerialArray,
    double? colDouble,
    List<double>? colDoubleArray,
    double? colReal,
    List<double>? colRealArray,
    num? colNumeric,
    List<num>? colNumericArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBigint != null) 'col_bigint': colBigint.toString(),
      if (colBigintArray != null)
        'col_bigint_array':
            colBigintArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBigserial != null) 'col_bigserial': colBigserial.toString(),
      if (colBigserialArray != null)
        'col_bigserial_array': colBigserialArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colInteger != null) 'col_integer': colInteger.toString(),
      if (colIntegerArray != null)
        'col_integer_array': colIntegerArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSmallint != null) 'col_smallint': colSmallint.toString(),
      if (colSmallintArray != null)
        'col_smallint_array': colSmallintArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSmallserial != null) 'col_smallserial': colSmallserial.toString(),
      if (colSmallserialArray != null)
        'col_smallserial_array': colSmallserialArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSerial != null) 'col_serial': colSerial.toString(),
      if (colSerialArray != null)
        'col_serial_array':
            colSerialArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colDouble != null) 'col_double': colDouble.toString(),
      if (colDoubleArray != null)
        'col_double_array':
            colDoubleArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colReal != null) 'col_real': colReal.toString(),
      if (colRealArray != null)
        'col_real_array':
            colRealArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colNumeric != null) 'col_numeric': colNumeric.toString(),
      if (colNumericArray != null)
        'col_numeric_array': colNumericArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    BigInt? colBigint,
    List<BigInt>? colBigintArray,
    BigInt? colBigserial,
    List<BigInt>? colBigserialArray,
    int? colInteger,
    List<int>? colIntegerArray,
    int? colSmallint,
    List<int>? colSmallintArray,
    int? colSmallserial,
    List<int>? colSmallserialArray,
    int? colSerial,
    List<int>? colSerialArray,
    double? colDouble,
    List<double>? colDoubleArray,
    double? colReal,
    List<double>? colRealArray,
    num? colNumeric,
    List<num>? colNumericArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colBigint != null) 'col_bigint': colBigint.toString(),
      if (colBigintArray != null)
        'col_bigint_array':
            colBigintArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colBigserial != null) 'col_bigserial': colBigserial.toString(),
      if (colBigserialArray != null)
        'col_bigserial_array': colBigserialArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colInteger != null) 'col_integer': colInteger.toString(),
      if (colIntegerArray != null)
        'col_integer_array': colIntegerArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSmallint != null) 'col_smallint': colSmallint.toString(),
      if (colSmallintArray != null)
        'col_smallint_array': colSmallintArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSmallserial != null) 'col_smallserial': colSmallserial.toString(),
      if (colSmallserialArray != null)
        'col_smallserial_array': colSmallserialArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colSerial != null) 'col_serial': colSerial.toString(),
      if (colSerialArray != null)
        'col_serial_array':
            colSerialArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colDouble != null) 'col_double': colDouble.toString(),
      if (colDoubleArray != null)
        'col_double_array':
            colDoubleArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colReal != null) 'col_real': colReal.toString(),
      if (colRealArray != null)
        'col_real_array':
            colRealArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colNumeric != null) 'col_numeric': colNumeric.toString(),
      if (colNumericArray != null)
        'col_numeric_array': colNumericArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory NumericTypes.fromJson(Map<String, dynamic> json) {
    return NumericTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colBigint: json['col_bigint'] != null
          ? BigInt.tryParse(json['col_bigint'].toString()) as BigInt
          : BigInt.from(0),
      colBigintArray: json['col_bigint_array'] != null
          ? (json['col_bigint_array'] as List<dynamic>)
              .map((v) => BigInt.tryParse(v.toString()) as BigInt)
              .toList()
          : <BigInt>[],
      colBigserial: json['col_bigserial'] != null
          ? BigInt.tryParse(json['col_bigserial'].toString()) as BigInt
          : BigInt.from(0),
      colBigserialArray: json['col_bigserial_array'] != null
          ? (json['col_bigserial_array'] as List<dynamic>)
              .map((v) => BigInt.tryParse(v.toString()) as BigInt)
              .toList()
          : <BigInt>[],
      colInteger: json['col_integer'] != null ? json['col_integer'] as int : 0,
      colIntegerArray: json['col_integer_array'] != null
          ? (json['col_integer_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      colSmallint:
          json['col_smallint'] != null ? json['col_smallint'] as int : 0,
      colSmallintArray: json['col_smallint_array'] != null
          ? (json['col_smallint_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      colSmallserial:
          json['col_smallserial'] != null ? json['col_smallserial'] as int : 0,
      colSmallserialArray: json['col_smallserial_array'] != null
          ? (json['col_smallserial_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      colSerial: json['col_serial'] != null ? json['col_serial'] as int : 0,
      colSerialArray: json['col_serial_array'] != null
          ? (json['col_serial_array'] as List<dynamic>)
              .map((v) => v as int)
              .toList()
          : <int>[],
      colDouble: json['col_double'] != null
          ? double.tryParse(json['col_double'].toString())
          : 0.0,
      colDoubleArray: json['col_double_array'] != null
          ? (json['col_double_array'] as List<dynamic>)
              .map((v) => double.tryParse(v.toString()) as double)
              .toList()
          : <double>[],
      colReal: json['col_real'] != null
          ? double.tryParse(json['col_real'].toString())
          : 0.0,
      colRealArray: json['col_real_array'] != null
          ? (json['col_real_array'] as List<dynamic>)
              .map((v) => double.tryParse(v.toString()) as double)
              .toList()
          : <double>[],
      colNumeric: json['col_numeric'] != null
          ? num.tryParse(json['col_numeric'].toString())
          : 0,
      colNumericArray: json['col_numeric_array'] != null
          ? (json['col_numeric_array'] as List<dynamic>)
              .map((v) => num.tryParse(v.toString()) as num)
              .toList()
          : <num>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colBigint != null) 'col_bigint': colBigint,
      if (colBigintArray != null) 'col_bigint_array': colBigintArray,
      if (colBigserial != null) 'col_bigserial': colBigserial,
      if (colBigserialArray != null) 'col_bigserial_array': colBigserialArray,
      if (colInteger != null) 'col_integer': colInteger,
      if (colIntegerArray != null) 'col_integer_array': colIntegerArray,
      if (colSmallint != null) 'col_smallint': colSmallint,
      if (colSmallintArray != null) 'col_smallint_array': colSmallintArray,
      if (colSmallserial != null) 'col_smallserial': colSmallserial,
      if (colSmallserialArray != null)
        'col_smallserial_array': colSmallserialArray,
      if (colSerial != null) 'col_serial': colSerial,
      if (colSerialArray != null) 'col_serial_array': colSerialArray,
      if (colDouble != null) 'col_double': colDouble,
      if (colDoubleArray != null) 'col_double_array': colDoubleArray,
      if (colReal != null) 'col_real': colReal,
      if (colRealArray != null) 'col_real_array': colRealArray,
      if (colNumeric != null) 'col_numeric': colNumeric,
      if (colNumericArray != null) 'col_numeric_array': colNumericArray,
    };
  }
}

class DatetimeTypes implements SupadartClass<DatetimeTypes> {
  final String id;
  final DateTime? colDate;
  final List<DateTime>? colDateArray;
  final DateTime? colTime;
  final List<DateTime>? colTimeArray;
  final DateTime? colTimetz;
  final List<DateTime>? colTimetzArray;
  final DateTime? colTimestamp;
  final List<DateTime>? colTimestampArray;
  final DateTime? colTimestamptz;
  final List<DateTime>? colTimestamptzArray;
  final Duration? colInterval;
  final List<Duration>? colIntervalArray;

  const DatetimeTypes({
    required this.id,
    this.colDate,
    this.colDateArray,
    this.colTime,
    this.colTimeArray,
    this.colTimetz,
    this.colTimetzArray,
    this.colTimestamp,
    this.colTimestampArray,
    this.colTimestamptz,
    this.colTimestamptzArray,
    this.colInterval,
    this.colIntervalArray,
  });

  static String get table_name => 'datetime_types';
  static String get c_id => 'id';
  static String get c_colDate => 'col_date';
  static String get c_colDateArray => 'col_date_array';
  static String get c_colTime => 'col_time';
  static String get c_colTimeArray => 'col_time_array';
  static String get c_colTimetz => 'col_timetz';
  static String get c_colTimetzArray => 'col_timetz_array';
  static String get c_colTimestamp => 'col_timestamp';
  static String get c_colTimestampArray => 'col_timestamp_array';
  static String get c_colTimestamptz => 'col_timestamptz';
  static String get c_colTimestamptzArray => 'col_timestamptz_array';
  static String get c_colInterval => 'col_interval';
  static String get c_colIntervalArray => 'col_interval_array';

  static List<DatetimeTypes> converter(List<Map<String, dynamic>> data) {
    return data.map(DatetimeTypes.fromJson).toList();
  }

  static DatetimeTypes converterSingle(Map<String, dynamic> data) {
    return DatetimeTypes.fromJson(data);
  }

  static Map<String, dynamic> insert({
    String? id,
    DateTime? colDate,
    List<DateTime>? colDateArray,
    DateTime? colTime,
    List<DateTime>? colTimeArray,
    DateTime? colTimetz,
    List<DateTime>? colTimetzArray,
    DateTime? colTimestamp,
    List<DateTime>? colTimestampArray,
    DateTime? colTimestamptz,
    List<DateTime>? colTimestamptzArray,
    Duration? colInterval,
    List<Duration>? colIntervalArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colDate != null) 'col_date': colDate.toIso8601String(),
      if (colDateArray != null)
        'col_date_array':
            colDateArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTime != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(colTime),
      if (colTimeArray != null)
        'col_time_array':
            colTimeArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTimetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(colTimetz),
      if (colTimetzArray != null)
        'col_timetz_array':
            colTimetzArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTimestamp != null) 'col_timestamp': colTimestamp.toIso8601String(),
      if (colTimestampArray != null)
        'col_timestamp_array': colTimestampArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTimestamptz != null)
        'col_timestamptz': colTimestamptz.toUtc().toString(),
      if (colTimestamptzArray != null)
        'col_timestamptz_array': colTimestamptzArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colInterval != null) 'col_interval': colInterval.toString(),
      if (colIntervalArray != null)
        'col_interval_array': colIntervalArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  static Map<String, dynamic> update({
    String? id,
    DateTime? colDate,
    List<DateTime>? colDateArray,
    DateTime? colTime,
    List<DateTime>? colTimeArray,
    DateTime? colTimetz,
    List<DateTime>? colTimetzArray,
    DateTime? colTimestamp,
    List<DateTime>? colTimestampArray,
    DateTime? colTimestamptz,
    List<DateTime>? colTimestamptzArray,
    Duration? colInterval,
    List<Duration>? colIntervalArray,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (colDate != null) 'col_date': colDate.toIso8601String(),
      if (colDateArray != null)
        'col_date_array':
            colDateArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTime != null)
        'col_time': DateFormat('HH:mm:ss.SSS').format(colTime),
      if (colTimeArray != null)
        'col_time_array':
            colTimeArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTimetz != null)
        'col_timetz': DateFormat('HH:mm:ss zzzz').format(colTimetz),
      if (colTimetzArray != null)
        'col_timetz_array':
            colTimetzArray.toString().replaceAll("[", "{").replaceAll("]", "}"),
      if (colTimestamp != null) 'col_timestamp': colTimestamp.toIso8601String(),
      if (colTimestampArray != null)
        'col_timestamp_array': colTimestampArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colTimestamptz != null)
        'col_timestamptz': colTimestamptz.toUtc().toString(),
      if (colTimestamptzArray != null)
        'col_timestamptz_array': colTimestamptzArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
      if (colInterval != null) 'col_interval': colInterval.toString(),
      if (colIntervalArray != null)
        'col_interval_array': colIntervalArray
            .toString()
            .replaceAll("[", "{")
            .replaceAll("]", "}"),
    };
  }

  factory DatetimeTypes.fromJson(Map<String, dynamic> json) {
    return DatetimeTypes(
      id: json['id'] != null ? json['id'].toString() : '',
      colDate: json['col_date'] != null
          ? DateTime.tryParse(json['col_date'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      colDateArray: json['col_date_array'] != null
          ? (json['col_date_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      colTime: json['col_time'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_time'].toString()}")
              as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      colTimeArray: json['col_time_array'] != null
          ? (json['col_time_array'] as List<dynamic>)
              .map((v) =>
                  DateTime.tryParse("1970-01-01T${v.toString()}") as DateTime)
              .toList()
          : <DateTime>[],
      colTimetz: json['col_timetz'] != null
          ? DateTime.tryParse("1970-01-01T${json['col_timetz'].toString()}")
              as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      colTimetzArray: json['col_timetz_array'] != null
          ? (json['col_timetz_array'] as List<dynamic>)
              .map((v) =>
                  DateTime.tryParse("1970-01-01T${v.toString()}") as DateTime)
              .toList()
          : <DateTime>[],
      colTimestamp: json['col_timestamp'] != null
          ? DateTime.tryParse(json['col_timestamp'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      colTimestampArray: json['col_timestamp_array'] != null
          ? (json['col_timestamp_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      colTimestamptz: json['col_timestamptz'] != null
          ? DateTime.tryParse(json['col_timestamptz'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
      colTimestamptzArray: json['col_timestamptz_array'] != null
          ? (json['col_timestamptz_array'] as List<dynamic>)
              .map((v) => DateTime.tryParse(v.toString()) as DateTime)
              .toList()
          : <DateTime>[],
      colInterval: json['col_interval'] != null
          ? json['col_interval'] as Duration
          : Duration(),
      colIntervalArray: json['col_interval_array'] != null
          ? (json['col_interval_array'] as List<dynamic>)
              .map((v) => v as Duration)
              .toList()
          : <Duration>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (colDate != null) 'col_date': colDate,
      if (colDateArray != null) 'col_date_array': colDateArray,
      if (colTime != null) 'col_time': colTime,
      if (colTimeArray != null) 'col_time_array': colTimeArray,
      if (colTimetz != null) 'col_timetz': colTimetz,
      if (colTimetzArray != null) 'col_timetz_array': colTimetzArray,
      if (colTimestamp != null) 'col_timestamp': colTimestamp,
      if (colTimestampArray != null) 'col_timestamp_array': colTimestampArray,
      if (colTimestamptz != null) 'col_timestamptz': colTimestamptz,
      if (colTimestamptzArray != null)
        'col_timestamptz_array': colTimestamptzArray,
      if (colInterval != null) 'col_interval': colInterval,
      if (colIntervalArray != null) 'col_interval_array': colIntervalArray,
    };
  }
}
