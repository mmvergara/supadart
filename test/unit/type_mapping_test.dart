import 'package:supadart/generators/swagger/column.dart';
import 'package:supadart/generators/swagger/utils.dart';
import 'package:test/test.dart';

import '../models/generated_classes.dart';

/// Postgres type → Dart type, as reported by PostgREST's `format` field.
const _dartTypes = {
  // Integers, including the aliases PostgREST reports for domains.
  'smallint': 'int', 'integer': 'int', 'int2': 'int', 'int4': 'int',
  'int32': 'int', 'bigint': 'BigInt', 'int8': 'BigInt', 'int64': 'BigInt',
  'smallint[]': 'List<int>', 'integer[]': 'List<int>', 'int2[]': 'List<int>',
  'int4[]': 'List<int>', 'int32[]': 'List<int>', 'bigint[]': 'List<BigInt>',
  'int8[]': 'List<BigInt>', 'int64[]': 'List<BigInt>',
  // Floating point and arbitrary precision.
  'real': 'double', 'double precision': 'double', 'numeric': 'num',
  'real[]': 'List<double>', 'double precision[]': 'List<double>',
  'numeric[]': 'List<num>',
  'boolean': 'bool', 'boolean[]': 'List<bool>',
  // Date and time.
  'date': 'DateTime', 'time without time zone': 'DateTime',
  'time with time zone': 'DateTime', 'timestamp without time zone': 'DateTime',
  'timestamp with time zone': 'DateTime', 'date[]': 'List<DateTime>',
  'timestamp with time zone[]': 'List<DateTime>',
  'interval': 'Duration', 'interval[]': 'List<Duration>',
  // JSON.
  'json': 'Map<String, dynamic>', 'jsonb': 'Map<String, dynamic>',
  'json[]': 'List<Map<String, dynamic>>',
  'jsonb[]': 'List<Map<String, dynamic>>',
  // PostGIS, prefixed with the schema the extension lives in.
  'extensions.geometry': 'Geometry',
  'extensions.geometry(Point,4326)': 'Geometry',
  'extensions.geography[]': 'List<Geometry>',
  // Everything else is passed through as text.
  'text': 'String', 'uuid': 'String', 'character varying': 'String',
  'bytea': 'String', 'inet': 'String', 'point': 'String', 'money': 'String',
  'xml': 'String', 'tsvector': 'String', 'bit varying': 'String',
  'text[]': 'List<String>', 'inet[]': 'List<String>',
};

// Rows below are verbatim PostgREST responses from the local test schema.
const _uuid = '00000000-0000-0000-0000-000000000001';

void main() {
  group('postgresFormatToDartType', () {
    _dartTypes.forEach((format, dartType) {
      test('$format → $dartType',
          () => expect(postgresFormatToDartType(format, false), dartType));
    });

    test('jsonbToDynamic only affects jsonb', () {
      expect(postgresFormatToDartType('jsonb', true), 'dynamic');
      expect(postgresFormatToDartType('jsonb[]', true), 'List<dynamic>');
      expect(postgresFormatToDartType('json', true), 'Map<String, dynamic>');
    });
  });

  group('Column.dartType', () {
    Column column(String format,
            {Map<String, List<String>> enums = const {}}) =>
        Column.fromJson('c', {'format': format}, [], enums);

    test('maps user-defined enums to the uppercased type name', () {
      final enums = {
        'mood': ['happy']
      };
      expect(column('public.mood', enums: enums).dartType, 'MOOD');
      expect(column('public.mood', enums: enums).isEnum, isTrue);
      expect(column('public.mood[]', enums: enums).dartType, 'List<MOOD>');
      expect(
          column('public."Order-Status"', enums: {
            'Order-Status': ['a']
          }).dartType,
          'ORDER_STATUS');
    });

    test('maps user-defined types without enum values to String', () {
      expect(column('public.citext').dartType, 'String');
      expect(column('public.mood[]').dartType, 'List<String>');
      expect(column('public.mood[]').isUnresolvedUserType, isTrue);
      expect(column('public.vector(3)').isUnresolvedUserType, isFalse);
    });

    test('maps pgvector to String', () {
      expect(column('public.vector(1536)').dartType, 'String');
    });

    test('maps PostGIS installed in public to Geometry', () {
      expect(column('public.geometry(Point,4326)').dartType, 'Geometry');
    });

    test('uses the jsonb model type when one is configured', () {
      final col = Column.fromJson('meta', {'format': 'jsonb'}, [], {},
          schema: 'public',
          tableName: 't',
          jsonbModels: {
            'public.t.meta': JsonbModelConfig(
                schema: 'public',
                tableName: 't',
                columnName: 'meta',
                dartType: 'Meta',
                importPath: 'meta.dart')
          });
      expect(col.dartType, 'Meta');
    });

    test('nullability follows the required list', () {
      final required = Column.fromJson('a', {'format': 'text'}, ['a'], {});
      final optional = Column.fromJson('a', {'format': 'text'}, [], {});
      expect(required.isNullable, isFalse);
      expect(optional.isNullable, isTrue);
    });

    test('a default makes a required column optional on insert', () {
      final col =
          Column.fromJson('a', {'format': 'text', 'default': 'x'}, ['a'], {});
      expect(col.isRequiredInInsert, isFalse);
      expect(col.isRequired, isFalse);
    });

    test('primary keys are not required in insert', () {
      final col = Column.fromJson(
          'id', {'format': 'uuid', 'description': 'Note:\n<pk/>'}, ['id'], {});
      expect(col.isPrimaryKey, isTrue);
      expect(col.isRequired, isFalse);
    });
  });

  group('fromJson on PostgREST output', () {
    test('numeric', () {
      final row = NumericTypes.fromJson({
        'id': _uuid,
        'col_bigint': 9223372036854775807,
        'col_bigint_array': [1, 9223372036854775807],
        'col_integer': 2147483647,
        'col_integer_array': [1, 2],
        'col_smallint': 32767,
        'col_smallint_array': [1, 2],
        'col_double': 1.5,
        'col_double_array': [1.5, 2.5],
        'col_real': 1.25,
        'col_real_array': [1.25],
        'col_numeric': 12.5,
        'col_numeric_array': [1.1, 2.2],
      });
      expect(row.colBigint, BigInt.parse('9223372036854775807'));
      expect(row.colBigintArray,
          [BigInt.one, BigInt.parse('9223372036854775807')]);
      expect(row.colInteger, 2147483647);
      expect(row.colIntegerArray, [1, 2]);
      expect(row.colSmallint, 32767);
      expect(row.colSmallintArray, [1, 2]);
      expect(row.colDouble, 1.5);
      expect(row.colDoubleArray, [1.5, 2.5]);
      expect(row.colReal, 1.25);
      expect(row.colRealArray, [1.25]);
      expect(row.colNumeric, 12.5);
      expect(row.colNumericArray, [1.1, 2.2]);
    });

    test('string', () {
      final row = StringTypes.fromJson({
        'id': _uuid,
        'col_uuid': '00000000-0000-0000-0000-0000000000aa',
        'col_uuid_array': ['00000000-0000-0000-0000-0000000000aa'],
        'col_character': 'a',
        'col_character_array': ['a', 'b'],
        'col_charactervarying': 'hello',
        'col_charactervarying_array': ['hi', 'there'],
        'col_text': 'text',
        'col_text_array': ['x', 'y'],
      });
      expect(row.colUuid, '00000000-0000-0000-0000-0000000000aa');
      expect(row.colCharacterArray, ['a', 'b']);
      expect(row.colCharactervarying, 'hello');
      expect(row.colTextArray, ['x', 'y']);
    });

    test('date and time', () {
      final row = DatetimeTypes.fromJson({
        'id': _uuid,
        'col_date': '2024-01-02',
        'col_date_array': ['2024-01-02'],
        'col_time': '13:14:15.123',
        'col_time_array': ['13:14:15'],
        'col_timetz': '13:14:15+02',
        'col_timetz_array': ['13:14:15+02'],
        'col_timestamp': '2024-01-02T03:04:05.678',
        'col_timestamp_array': ['2024-01-02T03:04:05'],
        'col_timestamptz': '2024-01-02T01:04:05+00:00',
        'col_timestamptz_array': ['2024-01-02T01:04:05+00:00'],
        'col_interval': '50:02:02',
        'col_interval_array': ['00:00:05'],
      });
      expect(row.colDate, DateTime(2024, 1, 2));
      expect(row.colDateArray, [DateTime(2024, 1, 2)]);
      expect(row.colTime, DateTime(1970, 1, 1, 13, 14, 15, 123));
      expect(row.colTimeArray, [DateTime(1970, 1, 1, 13, 14, 15)]);
      expect(row.colTimetz!.toUtc(), DateTime.utc(1970, 1, 1, 11, 14, 15));
      expect(row.colTimetzArray!.single.toUtc(),
          DateTime.utc(1970, 1, 1, 11, 14, 15));
      expect(row.colTimestamp, DateTime(2024, 1, 2, 3, 4, 5, 678));
      expect(row.colTimestampArray, [DateTime(2024, 1, 2, 3, 4, 5)]);
      expect(row.colTimestamptz, DateTime.utc(2024, 1, 2, 1, 4, 5));
      expect(row.colTimestamptz!.isUtc, isTrue);
      expect(row.colTimestamptzArray, [DateTime.utc(2024, 1, 2, 1, 4, 5)]);
      expect(
          row.colInterval, const Duration(hours: 50, minutes: 2, seconds: 2));
      expect(row.colIntervalArray, [const Duration(seconds: 5)]);
    });

    // Intervals as Postgres prints them with the default IntervalStyle.
    for (final (text, duration) in [
      ('1 day 02:03:04', Duration(days: 1, hours: 2, minutes: 3, seconds: 4)),
      ('3 days', Duration(days: 3)),
      ('-1 days +02:00:00', Duration(hours: -22)),
      ('1 year 2 mons', Duration(days: 365 + 60, hours: 6)),
      ('00:00:00.5', Duration(milliseconds: 500)),
      ('00:00:00.123456', Duration(microseconds: 123456)),
      ('-00:00:01.5', Duration(milliseconds: -1500)),
    ]) {
      test('interval "$text"', () {
        final row = DatetimeTypes.fromJson({'id': _uuid, 'col_interval': text});
        expect(row.colInterval, duration);
      });
    }

    test('interval in an unsupported format throws', () {
      expect(() => DatetimeTypes.fromJson({'id': _uuid, 'col_interval': 'P1D'}),
          throwsFormatException);
    });

    test('boolean and bit', () {
      final row = BooleanBitTypes.fromJson({
        'id': _uuid,
        'col_boolean': true,
        'col_boolean_array': [true, false],
        'col_bit': '1',
        'col_bit_array': ['1', '0'],
        'col_bitvarying': '101',
        'col_bitvarying_array': ['101', '11'],
      });
      expect(row.colBoolean, isTrue);
      expect(row.colBooleanArray, [true, false]);
      expect(row.colBit, '1');
      expect(row.colBitArray, ['1', '0']);
      expect(row.colBitvarying, '101');
    });

    test('json', () {
      final row = JsonTypes.fromJson({
        'id': _uuid,
        'col_json': {'a': 1},
        'col_jsonb': {
          'b': [1, 2]
        },
      });
      expect(row.colJson, {'a': 1});
      expect(row.colJsonb, {
        'b': [1, 2]
      });
    });

    test('json[] holding objects', () {
      final row = JsonTypes.fromJson({
        'id': _uuid,
        'col_json_array': [
          {'a': 1}
        ],
        'col_jsonb_array': [
          {'b': 2}
        ],
      });
      expect(row.colJsonArray, [
        {'a': 1}
      ]);
      expect(row.colJsonbArray, [
        {'b': 2}
      ]);
    });

    test('json[] written by older supadart versions as strings', () {
      final row = JsonTypes.fromJson({
        'id': _uuid,
        'col_jsonb_array': ['{"b":2}'],
      });
      expect(row.colJsonbArray, [
        {'b': 2}
      ]);
    });

    test('geometric, network, binary and misc types stay as text', () {
      final geo = GeometricTypes.fromJson({
        'id': _uuid,
        'col_point': '(1,2)',
        'col_point_array': ['(1,2)', '(3,4)'],
        'col_box': '(3,4),(1,2)',
        'col_circle': '<(1,2),3>',
      });
      expect(geo.colPoint, '(1,2)');
      expect(geo.colPointArray, ['(1,2)', '(3,4)']);
      expect(geo.colBox, '(3,4),(1,2)');
      expect(geo.colCircle, '<(1,2),3>');

      final net = NetworkTypes.fromJson({
        'id': _uuid,
        'col_inet': '192.168.0.1',
        'col_inet_array': ['192.168.0.1', '::1'],
        'col_macaddr8': '08:00:2b:01:02:03:04:05',
      });
      expect(net.colInet, '192.168.0.1');
      expect(net.colInetArray, ['192.168.0.1', '::1']);
      expect(net.colMacaddr8, '08:00:2b:01:02:03:04:05');

      final bin = BinaryXmlTypes.fromJson({
        'id': _uuid,
        'col_bytea': r'\xdeadbeef',
        'col_xml_array': ['<a>1</a>'],
      });
      expect(bin.colBytea, r'\xdeadbeef');
      expect(bin.colXmlArray, ['<a>1</a>']);

      final misc = MiscTypes.fromJson({
        'id': _uuid,
        'col_money': r'$12.34',
        'col_tsvector': "'a' 'cat' 'fat'",
        'col_pg_lsn_array': ['16/B374D848'],
      });
      expect(misc.colMoney, r'$12.34');
      expect(misc.colTsvector, "'a' 'cat' 'fat'");
      expect(misc.colPgLsnArray, ['16/B374D848']);
    });

    test('enums', () {
      final row = EnumTypes.fromJson({
        'id': _uuid,
        'col_mood': 'sad',
        'col_mood_array': ['happy', 'angry'],
      });
      expect(row.colMood, MOOD.sad);
      expect(row.colMoodArray, [MOOD.happy, MOOD.angry]);
    });

    test('enum labels that are not Dart identifiers', () {
      final row = EnumLabelTypes.fromJson({
        'id': _uuid,
        'col_status': 'in-progress',
        'col_status_array': [r"it's $1", '2fa', 'default'],
      });
      expect(row.colStatus, TASK_STATUS.inProgress);
      expect(row.colStatusNullable, isNull);
      expect(row.colStatusArray,
          [TASK_STATUS.itS1, TASK_STATUS.v2fa, TASK_STATUS.default_]);
      expect(() => TASK_STATUS.fromValue('unknown'), throwsStateError);
    });

    test('vector', () {
      final row = Embeddings.fromJson({'embedding': '[0.5,0.25]'});
      expect(row.embedding, '[0.5,0.25]');
    });

    test('null in a nullable column stays null', () {
      final row = NumericTypes.fromJson({'id': _uuid});
      expect(row.colBigint, isNull);
      expect(row.colIntegerArray, isNull);
      expect(row.colNumeric, isNull);
    });

    test('missing values in non-null columns fall back to a default', () {
      final row = Profiles.fromJson({});
      expect(row.id, '');
      expect(row.userGroups, isEmpty);
      expect(EnumTypes.fromJson({}).colMood, MOOD.values.first);
    });
  });

  group('toJson produces what PostgREST accepts', () {
    test('bigint and numeric are sent as strings to keep precision', () {
      final json = NumericTypes(
        id: _uuid,
        colBigint: BigInt.parse('9223372036854775807'),
        colBigintArray: [BigInt.one],
        colNumeric: 1.5,
        colInteger: 7,
        colReal: 1.25,
      ).toJson();
      expect(json['col_bigint'], '9223372036854775807');
      expect(json['col_bigint_array'], ['1']);
      expect(json['col_numeric'], '1.5');
      expect(json['col_integer'], 7);
      expect(json['col_real'], 1.25);
    });

    test('null fields are omitted', () {
      expect(NumericTypes(id: _uuid).toJson(), {'id': _uuid});
    });

    test('timestamptz is sent in UTC, timestamp as-is', () {
      final json = DatetimeTypes(
        id: _uuid,
        colTimestamptz: DateTime.utc(2024, 1, 2, 1, 4, 5),
        colTimestamp: DateTime(2024, 1, 2, 3, 4, 5),
        colTime: DateTime(1970, 1, 1, 13, 14, 15, 123),
        colDate: DateTime(2024, 1, 2),
      ).toJson();
      expect(json['col_timestamptz'], '2024-01-02T01:04:05.000Z');
      expect(json['col_timestamp'], '2024-01-02T03:04:05.000');
      expect(json['col_time'], '13:14:15.123');
      expect(json['col_date'], startsWith('2024-01-02'));
    });

    test('enums are sent by name', () {
      final json = EnumTypes(
          id: _uuid,
          colMood: MOOD.excited,
          colMoodArray: [MOOD.sad, MOOD.happy]).toJson();
      expect(json['col_mood'], 'excited');
      expect(json['col_mood_array'], ['sad', 'happy']);
    });

    test('enums are sent by their database label', () {
      final json = EnumLabelTypes(
          id: _uuid,
          colStatus: TASK_STATUS.onHold,
          colStatusArray: [TASK_STATUS.value_, TASK_STATUS.itS1]).toJson();
      expect(json['col_status'], 'on hold');
      expect(json['col_status_array'], ['value', r"it's $1"]);
    });

    test('json[] elements are sent as JSON values, not strings', () {
      expect(
          JsonTypes.insert(colJsonbArray: [
            {'b': 2}
          ]),
          {
            'col_jsonb_array': [
              {'b': 2}
            ]
          });
    });

    test('insert only includes what was passed', () {
      expect(Profiles.insert(firstName: 'Ada', userGroups: [USERGROUP.ADMIN]), {
        'first_name': 'Ada',
        'user_groups': ['ADMIN']
      });
    });
  });
}
