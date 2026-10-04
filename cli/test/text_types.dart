import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import 'models/generated_classes.dart';
import 'utils.dart';

// Types supadart passes through as String. Values are written in the form
// Postgres prints them back, so a read returns exactly what was inserted.

Future<void> performTextTypesTest(SupabaseClient supabase) async {
  group('geometric types', () {
    test('insert and read', () async {
      await cleanup(supabase, supabase.geometric_types);
      await supabase.geometric_types.insert(GeometricTypes.insert(
        id: uuidx,
        colPoint: '(1,2)',
        colPointArray: ['(1,2)', '(3,4)'],
        colLine: '{1,2,3}',
        colLineArray: ['{1,2,3}'],
        colLseg: '[(1,2),(3,4)]',
        colLsegArray: ['[(1,2),(3,4)]'],
        colBox: '(3,4),(1,2)',
        colBoxArray: ['(3,4),(1,2)'],
        colPath: '((1,2),(3,4))',
        colPathArray: ['[(1,2),(3,4)]'],
        colPolygon: '((1,2),(3,4),(5,6))',
        colPolygonArray: ['((1,2),(3,4),(5,6))'],
        colCircle: '<(1,2),3>',
        colCircleArray: ['<(1,2),3>'],
      ));

      final row =
          await _readOne(supabase.geometric_types, GeometricTypes.converter);
      expect(row.colPoint, '(1,2)');
      expect(row.colPointArray, ['(1,2)', '(3,4)']);
      expect(row.colLine, '{1,2,3}');
      expect(row.colLineArray, ['{1,2,3}']);
      expect(row.colLseg, '[(1,2),(3,4)]');
      expect(row.colBox, '(3,4),(1,2)');
      expect(row.colBoxArray, ['(3,4),(1,2)']);
      expect(row.colPath, '((1,2),(3,4))');
      expect(row.colPathArray, ['[(1,2),(3,4)]']);
      expect(row.colPolygon, '((1,2),(3,4),(5,6))');
      expect(row.colCircle, '<(1,2),3>');
      expect(row.colCircleArray, ['<(1,2),3>']);
      _expectJsonRoundTrip(row.toJson(), GeometricTypes.fromJson);
    });

    test('update', () async {
      await supabase.geometric_types
          .update(GeometricTypes.update(colPoint: '(5,6)', colBox: null))
          .eq(GeometricTypes.c_id, uuidx);
      final row =
          await _readOne(supabase.geometric_types, GeometricTypes.converter);
      expect(row.colPoint, '(5,6)');
      // update() drops nulls, so it cannot clear a column.
      expect(row.colBox, '(3,4),(1,2)');
    });
  });

  group('network types', () {
    test('insert and read', () async {
      await cleanup(supabase, supabase.network_types);
      await supabase.network_types.insert(NetworkTypes.insert(
        id: uuidx,
        colCidr: '192.168.0.0/24',
        colCidrArray: ['192.168.0.0/24', '10.0.0.0/8'],
        colInet: '192.168.0.1',
        colInetArray: ['192.168.0.1', '::1'],
        colMacaddr: '08:00:2b:01:02:03',
        colMacaddrArray: ['08:00:2b:01:02:03'],
        colMacaddr8: '08:00:2b:01:02:03:04:05',
        colMacaddr8Array: ['08:00:2b:01:02:03:04:05'],
      ));

      final row =
          await _readOne(supabase.network_types, NetworkTypes.converter);
      expect(row.colCidr, '192.168.0.0/24');
      expect(row.colCidrArray, ['192.168.0.0/24', '10.0.0.0/8']);
      expect(row.colInet, '192.168.0.1');
      expect(row.colInetArray, ['192.168.0.1', '::1']);
      expect(row.colMacaddr, '08:00:2b:01:02:03');
      expect(row.colMacaddrArray, ['08:00:2b:01:02:03']);
      expect(row.colMacaddr8, '08:00:2b:01:02:03:04:05');
      expect(row.colMacaddr8Array, ['08:00:2b:01:02:03:04:05']);
      _expectJsonRoundTrip(row.toJson(), NetworkTypes.fromJson);
    });

    test('update', () async {
      await supabase.network_types
          .update(NetworkTypes.update(colInet: '10.1.2.3'))
          .eq(NetworkTypes.c_id, uuidx);
      final row =
          await _readOne(supabase.network_types, NetworkTypes.converter);
      expect(row.colInet, '10.1.2.3');
    });
  });

  group('binary and xml types', () {
    test('insert and read', () async {
      await cleanup(supabase, supabase.binary_xml_types);
      await supabase.binary_xml_types.insert(BinaryXmlTypes.insert(
        id: uuidx,
        colBytea: r'\xdeadbeef',
        colByteaArray: [r'\xdeadbeef', r'\x00'],
        colXml: '<a>1</a>',
        colXmlArray: ['<a>1</a>', '<b/>'],
      ));

      final row =
          await _readOne(supabase.binary_xml_types, BinaryXmlTypes.converter);
      expect(row.colBytea, r'\xdeadbeef');
      expect(row.colByteaArray, [r'\xdeadbeef', r'\x00']);
      expect(row.colXml, '<a>1</a>');
      expect(row.colXmlArray, ['<a>1</a>', '<b/>']);
      _expectJsonRoundTrip(row.toJson(), BinaryXmlTypes.fromJson);
    });

    test('update', () async {
      await supabase.binary_xml_types
          .update(BinaryXmlTypes.update(colBytea: r'\xcafe'))
          .eq(BinaryXmlTypes.c_id, uuidx);
      final row =
          await _readOne(supabase.binary_xml_types, BinaryXmlTypes.converter);
      expect(row.colBytea, r'\xcafe');
    });
  });

  group('misc types', () {
    test('insert and read', () async {
      await cleanup(supabase, supabase.misc_types);
      await supabase.misc_types.insert(MiscTypes.insert(
        id: uuidx,
        colMoney: r'$12.34',
        colMoneyArray: [r'$12.34', r'$0.50'],
        colPgLsn: '16/B374D848',
        colPgLsnArray: ['16/B374D848'],
        colPgSnapshot: '10:20:10,14,15',
        colPgSnapshotArray: ['10:20:10,14,15'],
        colTsquery: "'fat' & 'rat'",
        colTsqueryArray: ["'fat' & 'rat'"],
        colTsvector: "'a' 'cat' 'fat'",
        colTsvectorArray: ["'a' 'cat' 'fat'"],
        colTxidSnapshot: '10:20:10,14,15',
        colTxidSnapshotArray: ['10:20:10,14,15'],
      ));

      final row = await _readOne(supabase.misc_types, MiscTypes.converter);
      expect(row.colMoney, r'$12.34');
      expect(row.colMoneyArray, [r'$12.34', r'$0.50']);
      expect(row.colPgLsn, '16/B374D848');
      expect(row.colPgSnapshot, '10:20:10,14,15');
      expect(row.colTsquery, "'fat' & 'rat'");
      expect(row.colTsvector, "'a' 'cat' 'fat'");
      expect(row.colTsvectorArray, ["'a' 'cat' 'fat'"]);
      expect(row.colTxidSnapshotArray, ['10:20:10,14,15']);
      _expectJsonRoundTrip(row.toJson(), MiscTypes.fromJson);
    });

    test('update', () async {
      await supabase.misc_types
          .update(MiscTypes.update(colMoney: r'$99.00'))
          .eq(MiscTypes.c_id, uuidx);
      final row = await _readOne(supabase.misc_types, MiscTypes.converter);
      expect(row.colMoney, r'$99.00');
    });
  });

  group('vector', () {
    final vector = '[${List.filled(1536, '0.5').join(',')}]';

    test('insert and read', () async {
      await supabase.embeddings.delete().not('embedding', 'is', null);
      await supabase.embeddings.insert(Embeddings.insert(embedding: vector));

      final rows = await supabase.embeddings
          .select()
          .withConverter(Embeddings.converter);
      expect(rows, hasLength(1));
      expect(rows.single.embedding, vector);
      _expectJsonRoundTrip(rows.single.toJson(), Embeddings.fromJson);
    });
  });
}

Future<T> _readOne<T>(SupabaseQueryBuilder table,
        List<T> Function(List<Map<String, dynamic>>) converter) =>
    table
        .select()
        .eq('id', uuidx)
        .single()
        .withConverter((data) => converter([data]).single);

void _expectJsonRoundTrip(Map<String, dynamic> json,
    SupadartClass<dynamic> Function(Map<String, dynamic>) fromJson) {
  expect((fromJson(json) as dynamic).toJson(), json);
}
