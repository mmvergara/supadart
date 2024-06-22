// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:supabase/supabase.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:intl/intl.dart';

class Books {
  BigInt id;
  String name;
  String? description;
  int price;
  DateTime created_at;

  Books({
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

class Test_table {
  BigInt bigintx;
  BigInt bigserialx;
  String? bitx;
  String? bitvaryingx;
  bool? booleanx;
  String? boxx;
  String? byteax;
  String? characterx;
  String? charactervaryingx;
  String? cidrx;
  String? circlex;
  DateTime? datex;
  double? doublex;
  String? inetx;
  int? integerx;
  Duration? intervalx;
  Map<String, dynamic>? jsonx;
  Map<String, dynamic>? jsonbx;
  String? linex;
  String? lsegx;
  String? macaddrx;
  String? macaddr8x;
  String? moneyx;
  num? numericx;
  String? pathx;
  String? pg_lsnx;
  String? pg_snapshotx;
  String? pointx;
  String? polygonx;
  double? realx;
  int? smallintx;
  int smallserialx;
  int serialx;
  String? textx;
  DateTime? timex;
  DateTime? timetzx;
  DateTime? timestampx;
  DateTime? timestamptzx;
  String? tsqueryx;
  String? tsvectorx;
  String? txid_snapshotx;
  String? uuidx;
  String? xmlx;
  int? cleanup;

  Test_table({
    required this.bigintx,
    required this.bigserialx,
    this.bitx,
    this.bitvaryingx,
    this.booleanx,
    this.boxx,
    this.byteax,
    this.characterx,
    this.charactervaryingx,
    this.cidrx,
    this.circlex,
    this.datex,
    this.doublex,
    this.inetx,
    this.integerx,
    this.intervalx,
    this.jsonx,
    this.jsonbx,
    this.linex,
    this.lsegx,
    this.macaddrx,
    this.macaddr8x,
    this.moneyx,
    this.numericx,
    this.pathx,
    this.pg_lsnx,
    this.pg_snapshotx,
    this.pointx,
    this.polygonx,
    this.realx,
    this.smallintx,
    required this.smallserialx,
    required this.serialx,
    this.textx,
    this.timex,
    this.timetzx,
    this.timestampx,
    this.timestamptzx,
    this.tsqueryx,
    this.tsvectorx,
    this.txid_snapshotx,
    this.uuidx,
    this.xmlx,
    this.cleanup,
  });

  static String get table_name => 'test_table';
  static String get c_bigintx => 'bigintx';
  static String get c_bigserialx => 'bigserialx';
  static String get c_bitx => 'bitx';
  static String get c_bitvaryingx => 'bitvaryingx';
  static String get c_booleanx => 'booleanx';
  static String get c_boxx => 'boxx';
  static String get c_byteax => 'byteax';
  static String get c_characterx => 'characterx';
  static String get c_charactervaryingx => 'charactervaryingx';
  static String get c_cidrx => 'cidrx';
  static String get c_circlex => 'circlex';
  static String get c_datex => 'datex';
  static String get c_doublex => 'doublex';
  static String get c_inetx => 'inetx';
  static String get c_integerx => 'integerx';
  static String get c_intervalx => 'intervalx';
  static String get c_jsonx => 'jsonx';
  static String get c_jsonbx => 'jsonbx';
  static String get c_linex => 'linex';
  static String get c_lsegx => 'lsegx';
  static String get c_macaddrx => 'macaddrx';
  static String get c_macaddr8x => 'macaddr8x';
  static String get c_moneyx => 'moneyx';
  static String get c_numericx => 'numericx';
  static String get c_pathx => 'pathx';
  static String get c_pg_lsnx => 'pg_lsnx';
  static String get c_pg_snapshotx => 'pg_snapshotx';
  static String get c_pointx => 'pointx';
  static String get c_polygonx => 'polygonx';
  static String get c_realx => 'realx';
  static String get c_smallintx => 'smallintx';
  static String get c_smallserialx => 'smallserialx';
  static String get c_serialx => 'serialx';
  static String get c_textx => 'textx';
  static String get c_timex => 'timex';
  static String get c_timetzx => 'timetzx';
  static String get c_timestampx => 'timestampx';
  static String get c_timestamptzx => 'timestamptzx';
  static String get c_tsqueryx => 'tsqueryx';
  static String get c_tsvectorx => 'tsvectorx';
  static String get c_txid_snapshotx => 'txid_snapshotx';
  static String get c_uuidx => 'uuidx';
  static String get c_xmlx => 'xmlx';
  static String get c_cleanup => 'cleanup';
  static Map<String, dynamic> insert({
    BigInt? bigintx,
    BigInt? bigserialx,
    String? bitx,
    String? bitvaryingx,
    bool? booleanx,
    String? boxx,
    String? byteax,
    String? characterx,
    String? charactervaryingx,
    String? cidrx,
    String? circlex,
    DateTime? datex,
    double? doublex,
    String? inetx,
    int? integerx,
    Duration? intervalx,
    Map<String, dynamic>? jsonx,
    Map<String, dynamic>? jsonbx,
    String? linex,
    String? lsegx,
    String? macaddrx,
    String? macaddr8x,
    String? moneyx,
    num? numericx,
    String? pathx,
    String? pg_lsnx,
    String? pg_snapshotx,
    String? pointx,
    String? polygonx,
    double? realx,
    int? smallintx,
    int? smallserialx,
    int? serialx,
    String? textx,
    DateTime? timex,
    DateTime? timetzx,
    DateTime? timestampx,
    DateTime? timestamptzx,
    String? tsqueryx,
    String? tsvectorx,
    String? txid_snapshotx,
    String? uuidx,
    String? xmlx,
    int? cleanup,
  }) {
    return {
      if (bigintx != null) 'bigintx': bigintx.toString(),
      if (bigserialx != null) 'bigserialx': bigserialx.toString(),
      if (bitx != null) 'bitx': bitx.toString(),
      if (bitvaryingx != null) 'bitvaryingx': bitvaryingx.toString(),
      if (booleanx != null) 'booleanx': booleanx.toString(),
      if (boxx != null) 'boxx': boxx.toString(),
      if (byteax != null) 'byteax': byteax.toString(),
      if (characterx != null) 'characterx': characterx.toString(),
      if (charactervaryingx != null)
        'charactervaryingx': charactervaryingx.toString(),
      if (cidrx != null) 'cidrx': cidrx.toString(),
      if (circlex != null) 'circlex': circlex.toString(),
      if (datex != null) 'datex': datex.toIso8601String(),
      if (doublex != null) 'doublex': doublex.toString(),
      if (inetx != null) 'inetx': inetx.toString(),
      if (integerx != null) 'integerx': integerx.toString(),
      if (intervalx != null) 'intervalx': intervalx.toString(),
      if (jsonx != null) 'jsonx': jsonx,
      if (jsonbx != null) 'jsonbx': jsonbx,
      if (linex != null) 'linex': linex.toString(),
      if (lsegx != null) 'lsegx': lsegx.toString(),
      if (macaddrx != null) 'macaddrx': macaddrx.toString(),
      if (macaddr8x != null) 'macaddr8x': macaddr8x.toString(),
      if (moneyx != null) 'moneyx': moneyx.toString(),
      if (numericx != null) 'numericx': numericx.toString(),
      if (pathx != null) 'pathx': pathx.toString(),
      if (pg_lsnx != null) 'pg_lsnx': pg_lsnx.toString(),
      if (pg_snapshotx != null) 'pg_snapshotx': pg_snapshotx.toString(),
      if (pointx != null) 'pointx': pointx.toString(),
      if (polygonx != null) 'polygonx': polygonx.toString(),
      if (realx != null) 'realx': realx.toString(),
      if (smallintx != null) 'smallintx': smallintx.toString(),
      if (smallserialx != null) 'smallserialx': smallserialx.toString(),
      if (serialx != null) 'serialx': serialx.toString(),
      if (textx != null) 'textx': textx.toString(),
      if (timex != null) 'timex': DateFormat('HH:mm:ss.SSS').format(timex),
      if (timetzx != null)
        'timetzx': DateFormat('HH:mm:ss zzzz').format(timetzx),
      if (timestampx != null) 'timestampx': timestampx.toIso8601String(),
      if (timestamptzx != null) 'timestamptzx': timestamptzx.toUtc().toString(),
      if (tsqueryx != null) 'tsqueryx': tsqueryx.toString(),
      if (tsvectorx != null) 'tsvectorx': tsvectorx.toString(),
      if (txid_snapshotx != null) 'txid_snapshotx': txid_snapshotx.toString(),
      if (uuidx != null) 'uuidx': uuidx.toString(),
      if (xmlx != null) 'xmlx': xmlx.toString(),
      if (cleanup != null) 'cleanup': cleanup.toString(),
    };
  }

  static Map<String, dynamic> update({
    BigInt? bigintx,
    BigInt? bigserialx,
    String? bitx,
    String? bitvaryingx,
    bool? booleanx,
    String? boxx,
    String? byteax,
    String? characterx,
    String? charactervaryingx,
    String? cidrx,
    String? circlex,
    DateTime? datex,
    double? doublex,
    String? inetx,
    int? integerx,
    Duration? intervalx,
    Map<String, dynamic>? jsonx,
    Map<String, dynamic>? jsonbx,
    String? linex,
    String? lsegx,
    String? macaddrx,
    String? macaddr8x,
    String? moneyx,
    num? numericx,
    String? pathx,
    String? pg_lsnx,
    String? pg_snapshotx,
    String? pointx,
    String? polygonx,
    double? realx,
    int? smallintx,
    int? smallserialx,
    int? serialx,
    String? textx,
    DateTime? timex,
    DateTime? timetzx,
    DateTime? timestampx,
    DateTime? timestamptzx,
    String? tsqueryx,
    String? tsvectorx,
    String? txid_snapshotx,
    String? uuidx,
    String? xmlx,
    int? cleanup,
  }) {
    return {
      if (bigintx != null) 'bigintx': bigintx.toString(),
      if (bigserialx != null) 'bigserialx': bigserialx.toString(),
      if (bitx != null) 'bitx': bitx.toString(),
      if (bitvaryingx != null) 'bitvaryingx': bitvaryingx.toString(),
      if (booleanx != null) 'booleanx': booleanx.toString(),
      if (boxx != null) 'boxx': boxx.toString(),
      if (byteax != null) 'byteax': byteax.toString(),
      if (characterx != null) 'characterx': characterx.toString(),
      if (charactervaryingx != null)
        'charactervaryingx': charactervaryingx.toString(),
      if (cidrx != null) 'cidrx': cidrx.toString(),
      if (circlex != null) 'circlex': circlex.toString(),
      if (datex != null) 'datex': datex.toIso8601String(),
      if (doublex != null) 'doublex': doublex.toString(),
      if (inetx != null) 'inetx': inetx.toString(),
      if (integerx != null) 'integerx': integerx.toString(),
      if (intervalx != null) 'intervalx': intervalx.toString(),
      if (jsonx != null) 'jsonx': jsonx,
      if (jsonbx != null) 'jsonbx': jsonbx,
      if (linex != null) 'linex': linex.toString(),
      if (lsegx != null) 'lsegx': lsegx.toString(),
      if (macaddrx != null) 'macaddrx': macaddrx.toString(),
      if (macaddr8x != null) 'macaddr8x': macaddr8x.toString(),
      if (moneyx != null) 'moneyx': moneyx.toString(),
      if (numericx != null) 'numericx': numericx.toString(),
      if (pathx != null) 'pathx': pathx.toString(),
      if (pg_lsnx != null) 'pg_lsnx': pg_lsnx.toString(),
      if (pg_snapshotx != null) 'pg_snapshotx': pg_snapshotx.toString(),
      if (pointx != null) 'pointx': pointx.toString(),
      if (polygonx != null) 'polygonx': polygonx.toString(),
      if (realx != null) 'realx': realx.toString(),
      if (smallintx != null) 'smallintx': smallintx.toString(),
      if (smallserialx != null) 'smallserialx': smallserialx.toString(),
      if (serialx != null) 'serialx': serialx.toString(),
      if (textx != null) 'textx': textx.toString(),
      if (timex != null) 'timex': DateFormat('HH:mm:ss.SSS').format(timex),
      if (timetzx != null)
        'timetzx': DateFormat('HH:mm:ss zzzz').format(timetzx),
      if (timestampx != null) 'timestampx': timestampx.toIso8601String(),
      if (timestamptzx != null) 'timestamptzx': timestamptzx.toUtc().toString(),
      if (tsqueryx != null) 'tsqueryx': tsqueryx.toString(),
      if (tsvectorx != null) 'tsvectorx': tsvectorx.toString(),
      if (txid_snapshotx != null) 'txid_snapshotx': txid_snapshotx.toString(),
      if (uuidx != null) 'uuidx': uuidx.toString(),
      if (xmlx != null) 'xmlx': xmlx.toString(),
      if (cleanup != null) 'cleanup': cleanup.toString(),
    };
  }

  factory Test_table.fromJson(Map<String, dynamic> json) {
    return Test_table(
      bigintx: BigInt.parse(json['bigintx'].toString()),
      bigserialx: BigInt.parse(json['bigserialx'].toString()),
      bitx: json['bitx'] != null ? json['bitx'] as String : null,
      bitvaryingx:
          json['bitvaryingx'] != null ? json['bitvaryingx'] as String : null,
      booleanx: json['booleanx'] != null ? json['booleanx'] as bool : null,
      boxx: json['boxx'] != null ? json['boxx'] as String : null,
      byteax: json['byteax'] != null ? json['byteax'] as String : null,
      characterx:
          json['characterx'] != null ? json['characterx'] as String : null,
      charactervaryingx: json['charactervaryingx'] != null
          ? json['charactervaryingx'] as String
          : null,
      cidrx: json['cidrx'] != null ? json['cidrx'] as String : null,
      circlex: json['circlex'] != null ? json['circlex'] as String : null,
      datex: json['datex'] != null
          ? DateTime.tryParse(json['datex'].toString())
          : null,
      doublex: json['doublex'] != null
          ? double.tryParse(json['doublex'].toString())
          : null,
      inetx: json['inetx'] != null ? json['inetx'] as String : null,
      integerx: json['integerx'] != null ? json['integerx'] as int : null,
      intervalx:
          json['intervalx'] != null ? json['intervalx'] as Duration : null,
      jsonx:
          json['jsonx'] != null ? json['jsonx'] as Map<String, dynamic> : null,
      jsonbx: json['jsonbx'] != null
          ? json['jsonbx'] as Map<String, dynamic>
          : null,
      linex: json['linex'] != null ? json['linex'] as String : null,
      lsegx: json['lsegx'] != null ? json['lsegx'] as String : null,
      macaddrx: json['macaddrx'] != null ? json['macaddrx'] as String : null,
      macaddr8x: json['macaddr8x'] != null ? json['macaddr8x'] as String : null,
      moneyx: json['moneyx'] != null ? json['moneyx'] as String : null,
      numericx: json['numericx'] != null
          ? num.tryParse(json['numericx'].toString())
          : null,
      pathx: json['pathx'] != null ? json['pathx'] as String : null,
      pg_lsnx: json['pg_lsnx'] != null ? json['pg_lsnx'] as String : null,
      pg_snapshotx:
          json['pg_snapshotx'] != null ? json['pg_snapshotx'] as String : null,
      pointx: json['pointx'] != null ? json['pointx'] as String : null,
      polygonx: json['polygonx'] != null ? json['polygonx'] as String : null,
      realx: json['realx'] != null
          ? double.tryParse(json['realx'].toString())
          : null,
      smallintx: json['smallintx'] != null ? json['smallintx'] as int : null,
      smallserialx: json['smallserialx'] as int,
      serialx: json['serialx'] as int,
      textx: json['textx'] != null ? json['textx'] as String : null,
      timex: json['timex'] != null
          ? DateTime.tryParse("1970-01-01T${json['timex'].toString()}")
          : null,
      timetzx: json['timetzx'] != null
          ? DateTime.tryParse("1970-01-01T${json['timetzx'].toString()}")
          : null,
      timestampx: json['timestampx'] != null
          ? DateTime.tryParse(json['timestampx'].toString())
          : null,
      timestamptzx: json['timestamptzx'] != null
          ? DateTime.tryParse(json['timestamptzx'].toString())
          : null,
      tsqueryx: json['tsqueryx'] != null ? json['tsqueryx'] as String : null,
      tsvectorx: json['tsvectorx'] != null ? json['tsvectorx'] as String : null,
      txid_snapshotx: json['txid_snapshotx'] != null
          ? json['txid_snapshotx'] as String
          : null,
      uuidx: json['uuidx'] != null ? json['uuidx'] as String : null,
      xmlx: json['xmlx'] != null ? json['xmlx'] as String : null,
      cleanup: json['cleanup'] != null ? json['cleanup'] as int : null,
    );
  }
}

extension TypeSafeTable on SupabaseClient {
  SupabaseQueryBuilder get books {
    return from('books');
  }

  SupabaseQueryBuilder get test_table {
    return from('test_table');
  }
}
