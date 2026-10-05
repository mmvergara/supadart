import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:supadart/generators/index.dart';
import 'package:supadart/generators/standalone/enums.dart';
import 'package:supadart/generators/swagger/column.dart';
import 'package:supadart/generators/swagger/swagger.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../../bin/supadart.dart' show extractOptions, setupArgParser;
import '../support/generate.dart';

JsonbModelConfig _jsonbModel(
        {bool isArray = false, String column = 'col_jsonb'}) =>
    JsonbModelConfig(
      schema: 'public',
      tableName: 'json_types',
      columnName: column,
      dartType: 'Meta',
      importPath: 'package:app/meta.dart',
      isArray: isArray,
    );

void main() {
  group('output layout', () {
    test('single file holds every table and the shared header', () {
      final files = generateWith();
      expect(files.keys, ['generated_classes.dart']);
      final code = files['generated_classes.dart']!;
      expect(code, contains('abstract class SupadartClass<T>'));
      expect(code, contains('class NumericTypes implements'));
      expect(code, contains('class Profiles implements'));
    });

    test('separated writes one file per table plus header and exports', () {
      final files = generateWith(isSeparated: true);
      final tables = readJsonFixture(swaggerFixturePath)['definitions'] as Map;
      expect(files.keys, hasLength(tables.length + 2));
      expect(files.keys,
          containsAll(['supadart_header.dart', 'supadart_exports.dart']));
      expect(files['numeric_types.dart'], contains('class NumericTypes '));
      expect(files['numeric_types.dart'],
          contains("import 'supadart_header.dart';"));
      expect(files['supadart_exports.dart'],
          contains("export 'numeric_types.dart';"));
    });

    test('dart imports supabase, flutter imports supabase_flutter', () {
      expect(generateWith(isDart: true)['generated_classes.dart'],
          contains("import 'package:supabase/supabase.dart';"));
      final flutter = generateWith(isDart: false)['generated_classes.dart']!;
      expect(flutter,
          contains("import 'package:supabase_flutter/supabase_flutter.dart';"));
      expect(flutter, isNot(contains('package:supabase/supabase.dart')));
    });

    test('client extensions cover every table and bucket', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(code, contains("get numeric_types => from('numeric_types');"));
      expect(code,
          contains("get combined_types_view => from('combined_types_view');"));
      expect(code, contains("StorageFileApi get avatars => from('avatars');"));
      expect(
          code, contains("StorageFileApi get documents => from('documents');"));
    });
  });

  group('enums', () {
    DatabaseSwagger parse(Map<String, List<String>> enums) =>
        DatabaseSwagger.fromJson(
            readJsonFixture(swaggerFixturePath), enums, false);

    test('reads enum values from the schema', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(code, contains('enum MOOD {'));
      expect(code, contains("happy('happy'),"));
      expect(code, contains("angry('angry');"));
      expect(code, contains('final MOOD colMood;'));
      expect(code, contains('final List<MOOD> colMoodArray;'));
    });

    test('takes enums used only in arrays from the config', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(code, contains("USERS('USERS'),"));
      expect(code, contains('final List<USERGROUP> userGroups;'));
      expect(parse(testEnums).warnings, isEmpty);
    });

    test('accepts config keys with a public. prefix', () {
      final swagger = parse({
        'public.usergroup': ['USERS', 'ADMIN', 'MODERATOR']
      });
      expect(swagger.enums.keys,
          ['public.mood', 'public.task_status', 'public.usergroup']);
      expect(swagger.warnings, isEmpty);
    });

    test('maps unconfigured enum arrays to List<String> with a warning', () {
      final code = generateWith(enums: {})['generated_classes.dart']!;
      expect(code, isNot(contains('enum USERGROUP')));
      expect(code, contains('final List<String> userGroups;'));
      expect(
          code,
          contains(
              "'user_groups': userGroups.map((e) => e.toString()).toList()"));

      final warnings = parse({}).warnings;
      expect(warnings, hasLength(1));
      expect(warnings.single, contains('usergroup'));
      expect(warnings.single, contains('profiles.user_groups'));
      expect(warnings.single,
          contains('SELECT unnest(enum_range(NULL::public."usergroup"))'));
    });

    test('prefers schema values over the config, with a warning', () {
      final swagger = parse({
        ...testEnums,
        'mood': ['happy', 'sad'],
      });
      expect(swagger.enums['public.mood'],
          ['happy', 'sad', 'neutral', 'excited', 'angry']);
      expect(swagger.warnings, hasLength(1));
      expect(swagger.warnings.single, contains('mood'));
    });

    test('names constants for labels that are not Dart identifiers', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(code, contains("inProgress('in-progress'),"));
      expect(code, contains("onHold('on hold'),"));
      expect(code, contains("Done('Done'),"));
      expect(code, contains("default_('default'),"));
      expect(code, contains("v2fa('2fa'),"));
      expect(code, contains("value_('value'),"));
      expect(code, contains(r"itS1('it\'s \$1');"));
    });

    test('keeps constant names unique', () {
      expect(enumConstantNames(['in-progress', 'inProgress', 'in progress']),
          ['inProgress', 'inProgress2', 'inProgress3']);
      expect(enumConstantNames(['_hidden', '!!', 'index']),
          ['hidden', 'value1', 'index_']);
    });
  });

  group('schemas', () {
    const both = ['public', 'inventory'];

    test('prefixes names outside the primary schema', () {
      final code = generateWith(schemas: both)['generated_classes.dart']!;
      expect(code, contains('class Profiles implements'));
      expect(code, contains('class InventoryProfiles implements'));
      expect(code, contains('class InventoryItems implements'));
      expect(code, contains('enum MOOD {'));
      expect(code, contains('enum INVENTORY_MOOD {'));
      expect(code, contains("calm('calm'),"));
      expect(code, contains('final MOOD? ownerMood;'));
      expect(code, contains('final INVENTORY_MOOD? warehouseMood;'));
      expect(
          code, contains('final List<INVENTORY_ITEM_STATUS>? statusHistory;'));
    });

    test('client getters select the schema', () {
      final code = generateWith(schemas: both)['generated_classes.dart']!;
      expect(code, contains("get profiles => from('profiles');"));
      expect(
          code,
          contains(
              "get inventory_profiles => schema('inventory').from('profiles');"));
      expect(code, contains("static String get schema_name => 'inventory';"));
      expect(code, contains("static String get table_name => 'items';"));
    });

    test('a single non-public schema keeps plain names', () {
      final code =
          generateWith(schemas: ['inventory'])['generated_classes.dart']!;
      expect(code, contains('class Items implements'));
      expect(code, contains("get items => schema('inventory').from('items');"));
      expect(code, contains('enum MOOD {'));
      expect(code, contains("busy('busy');"));
      // Types from public are still resolved, but prefixed.
      expect(code, contains('final PUBLIC_MOOD? ownerMood;'));
      expect(code, isNot(contains('class NumericTypes')));
    });

    test('separated mode writes a file per schema-prefixed class', () {
      final files = generateWith(schemas: both, isSeparated: true);
      expect(files.keys,
          containsAll(['profiles.dart', 'inventory_profiles.dart']));
      expect(files['supadart_exports.dart'],
          contains("export 'inventory_items.dart';"));
    });

    test('mappings take schema.table keys, plain keys for the primary', () {
      final code = generateWith(
          schemas: both,
          mappings: 'inventory.items: stock_item\n'
              'profiles: user_profile\n'
              'items: ignored')['generated_classes.dart']!;
      expect(code, contains('class StockItem implements'));
      expect(code, contains('class UserProfile implements'));
      expect(code, contains('class InventoryProfiles implements'));
      expect(code, isNot(contains('class Ignored')));
    });

    test('rejects tables that would share a class name', () {
      expect(
          () => generateWith(
              schemas: both, mappings: 'inventory.profiles: profiles'),
          throwsA(isA<NameClashException>().having((e) => e.message, 'message',
              contains('public.profiles, inventory.profiles'))));
    });

    test('config enums are in the primary schema unless qualified', () {
      final inventory = readJsonFixture(swaggerFixturePaths['inventory']!);
      final items = (inventory['definitions'] as Map)['items'] as Map;
      // Without the status column, item_status is only used in an array.
      (items['properties'] as Map).remove('status');
      DatabaseSwagger parse(Map<String, List<String>> enums) =>
          DatabaseSwagger.fromSchemas({
            'public': readJsonFixture(swaggerFixturePath),
            'inventory': inventory,
          }, enums, false);

      final warning = parse(testEnums).warnings.single;
      expect(warning, contains('inventory.item_status'));
      expect(warning, contains('inventory.items.status_history'));
      expect(warning, contains('    inventory.item_status: [...]'));
      expect(warning,
          contains('SELECT unnest(enum_range(NULL::inventory."item_status"))'));

      final swagger = parse({
        ...testEnums,
        'inventory.item_status': ['a', 'b'],
      });
      expect(swagger.warnings, isEmpty);
      expect(swagger.enums['inventory.item_status'], ['a', 'b']);
      expect(swagger.enums['public.usergroup'], isNotNull);
    });
  });

  group('mappings', () {
    const mappings = 'profiles: user_profile\nnumeric_types: numbers';

    test('renames classes but keeps table names', () {
      final code = generateWith(mappings: mappings)['generated_classes.dart']!;
      expect(code,
          contains('class UserProfile implements SupadartClass<UserProfile>'));
      expect(code, contains('class Numbers implements'));
      expect(code, isNot(contains('class Profiles ')));
      expect(code, contains("static String get table_name => 'profiles';"));
      expect(code, contains("get profiles => from('profiles');"));
    });

    test('renames files and exports in separated mode', () {
      final files = generateWith(mappings: mappings, isSeparated: true);
      expect(files.keys, containsAll(['user_profile.dart', 'numbers.dart']));
      expect(files.keys, isNot(contains('profiles.dart')));
      expect(files['supadart_exports.dart'],
          contains("export 'user_profile.dart';"));
      expect(
          files['supadart_exports.dart'], isNot(contains("'profiles.dart'")));
    });
  });

  group('exclude', () {
    for (final method in ['New', 'toJson', 'copyWith']) {
      test('drops $method and nothing else', () {
        final all = generateWith()['generated_classes.dart']!;
        final code = generateWith(exclude: [method])['generated_classes.dart']!;
        final signature = {
          'New': 'static Object New({',
          'toJson': 'Map<String, dynamic> toJson()',
          'copyWith': 'Profiles copyWith({',
        }[method]!;

        expect(all, contains(signature));
        expect(code, isNot(contains(signature)));
        for (final kept in [
          'factory Profiles.fromJson',
          'static Map<String, dynamic> insert({',
          'static Map<String, dynamic> update({'
        ]) {
          expect(code, contains(kept));
        }
      });
    }
  });

  group('jsonbToDynamic', () {
    test('types jsonb as dynamic and leaves json alone', () {
      final code =
          generateWith(jsonbToDynamic: true)['generated_classes.dart']!;
      expect(code, contains('final dynamic colJsonb;'));
      expect(code, contains('final List<dynamic>? colJsonbArray;'));
      expect(code, contains('final Map<String, dynamic>? colJson;'));
      expect(
          code,
          contains(
              "colJsonb: jsonn['col_jsonb'] != null ? jsonn['col_jsonb'] as dynamic : null"));
    });

    test('is off by default', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(code, contains('final Map<String, dynamic>? colJsonb;'));
    });
  });

  group('jsonb models', () {
    test('types the column with the model and imports it', () {
      final code = generateWith(jsonbModels: {
        'public.json_types.col_jsonb': _jsonbModel(),
      })['generated_classes.dart']!;
      expect(code, contains("import 'package:app/meta.dart';"));
      expect(code, contains('final Meta? colJsonb;'));
      expect(
          code,
          contains(
              "Meta.fromJson(jsonn['col_jsonb'] as Map<String, dynamic>)"));
      expect(code, contains("'col_jsonb': colJsonb.toJson()"));
      // Other jsonb columns are untouched.
      expect(code, contains('final Map<String, dynamic>? colJson;'));
    });

    test('maps arrays to List<Model>', () {
      final code = generateWith(jsonbModels: {
        'public.json_types.col_jsonb_array':
            _jsonbModel(column: 'col_jsonb_array'),
      })['generated_classes.dart']!;
      expect(code, contains('final List<Meta>? colJsonbArray;'));
      expect(code,
          contains('.map((v) => Meta.fromJson(v as Map<String, dynamic>))'));
      expect(code, contains("colJsonbArray.map((e) => e.toJson()).toList()"));
    });

    test('exports the model from the header in separated mode', () {
      final files = generateWith(isSeparated: true, jsonbModels: {
        'public.json_types.col_jsonb': _jsonbModel(),
      });
      expect(files['supadart_header.dart'],
          contains("export 'package:app/meta.dart';"));
    });

    test('ignores configs for other tables', () {
      final code = generateWith(jsonbModels: {
        'public.other_table.col_jsonb': _jsonbModel(),
      })['generated_classes.dart']!;
      expect(code, contains('final Map<String, dynamic>? colJsonb;'));
    });
  });

  group('postGIS', () {
    test('imports geobase and types geometry columns', () {
      final code = generateWith(
          swaggerJson: swaggerWithPostGIS(),
          isPostGIS: true)['generated_classes.dart']!;
      expect(code, contains("import 'package:geobase/geobase.dart';"));
      expect(code, contains('final Geometry location;'));
      expect(code, contains('final Geometry? area;'));
      expect(code, contains('final List<Geometry>? route;'));
      expect(code, contains('GeometryFromJson.fromJson('));
      expect(code, contains('extension GeometryFromJson on Geometry'));
      expect(code, contains("import 'dart:convert';"));
      expect(
          code, contains('location.toBytesHex(format: WKB.geometryExtended)'));
    });

    // PostGIS casts geometry to json as GeoJSON, geography arrives as hex
    // EWKB. Captured from PostgREST against PostGIS 3.3.
    test('fromJson decodes GeoJSON geometry and hex geography', () async {
      const dir = '.dart_tool/supadart_postgis_runtime';
      final files =
          generateWith(swaggerJson: swaggerWithPostGIS(), isPostGIS: true)
            ..['main.dart'] = r'''
import 'dart:convert';
import 'package:geobase/geobase.dart';
import 'generated_classes.dart';

void main() {
  final row = jsonDecode('{"id":"a","location":{"type":"Point","crs":{"type":"name","properties":{"name":"EPSG:4326"}},"coordinates":[-85.9,32.85]},"area":"0101000020E61000009A999999997955C0CDCCCCCCCC6C4040","route":[{"type":"LineString","coordinates":[[0,0],[1,2]]}]}') as Map<String, dynamic>;
  final p = Places.fromJson(row);
  final location = p.location as Point;
  final area = p.area as Point;
  print([location.position.x, location.position.y, area.position.x,
      area.position.y, p.route!.single.runtimeType].join(' '));
}
''';
      for (final MapEntry(key: name, value: code) in files.entries) {
        File('$dir/$name')
          ..createSync(recursive: true)
          ..writeAsStringSync(code);
      }
      final result = await Process.run(
          Platform.resolvedExecutable, ['run', '$dir/main.dart']);
      Directory(dir).deleteSync(recursive: true);
      expect(result.exitCode, 0, reason: '${result.stdout}${result.stderr}');
      expect('${result.stdout}'.trim(), '-85.9 32.85 -85.9 32.85 LineString');
    }, timeout: const Timeout(Duration(minutes: 1)));

    test('does not import geobase when off', () {
      expect(generateWith()['generated_classes.dart'],
          isNot(contains('package:geobase')));
    });

    test('exports geobase from the header in separated mode', () {
      final files = generateWith(
          swaggerJson: swaggerWithPostGIS(),
          isPostGIS: true,
          isSeparated: true);
      expect(files['supadart_header.dart'],
          contains("export 'package:geobase/geobase.dart';"));
    });
  });

  group('extractOptions', () {
    Map<String, dynamic> options(List<String> args,
            {String yaml = 'dart: true', Map<String, String> env = const {}}) =>
        extractOptions(setupArgParser().parse(args), loadYaml(yaml) as YamlMap,
            env: DotEnv()..addAll(env));

    test('defaults', () {
      final o = options([], yaml: '{}');
      expect(o['url'], '');
      expect(o['apiKey'], '');
      expect(o['isDart'], false);
      expect(o['isSeparated'], false);
      expect(o['output'], './lib/models/');
      expect(o['exclude'], isEmpty);
      expect(o['isPostGIS'], false);
      expect(o['jsonbToDynamic'], false);
      expect(o['schemas'], ['public']);
    });

    test('schemas come from the CLI, else the yaml', () {
      expect(options([], yaml: 'schemas: [public, inventory]')['schemas'],
          ['public', 'inventory']);
      expect(options([], yaml: 'schemas: inventory')['schemas'], ['inventory']);
      expect(
          options(['-s', 'inventory, public,inventory'],
              yaml: 'schemas: [public]')['schemas'],
          ['inventory', 'public']);
      expect(
          options(['--schema', 'a', '--schema', 'b'])['schemas'], ['a', 'b']);
    });

    test('reads every yaml option', () {
      final o = options([], yaml: '''
SUPABASE_URL: https://yaml.supabase.co
SUPABASE_API_KEY: yaml_key
dart: true
separated: true
output: out/
postGIS: true
jsonbToDynamic: true
exclude: [New, copyWith]
mappings:
  profiles: user_profile
enums:
  mood: [happy, sad]
''');
      expect(o['url'], 'https://yaml.supabase.co');
      expect(o['apiKey'], 'yaml_key');
      expect(o['isDart'], true);
      expect(o['isSeparated'], true);
      expect(o['output'], 'out/');
      expect(o['isPostGIS'], true);
      expect(o['jsonbToDynamic'], true);
      expect(o['exclude'], ['New', 'copyWith']);
      expect((o['mappings'] as YamlMap)['profiles'], 'user_profile');
      expect(o['mapOfEnums'], {
        'mood': ['happy', 'sad']
      });
    });

    test('CLI flags beat env, env beats yaml', () {
      const yaml = 'SUPABASE_URL: yaml_url\nSUPABASE_API_KEY: yaml_key';
      const env = {'SUPABASE_URL': 'env_url', 'SUPABASE_API_KEY': 'env_key'};

      expect(options([], yaml: yaml)['url'], 'yaml_url');
      expect(options([], yaml: yaml, env: env)['url'], 'env_url');
      expect(options([], yaml: yaml, env: env)['apiKey'], 'env_key');
      final cli =
          options(['-u', 'cli_url', '-k', 'cli_key'], yaml: yaml, env: env);
      expect(cli['url'], 'cli_url');
      expect(cli['apiKey'], 'cli_key');
    });

    test('falls back to SUPABASE_ANON_KEY', () {
      expect(options([], yaml: 'SUPABASE_ANON_KEY: old_yaml')['apiKey'],
          'old_yaml');
      expect(options([], env: {'SUPABASE_ANON_KEY': 'old_env'})['apiKey'],
          'old_env');
      expect(
          options([],
              yaml: 'SUPABASE_ANON_KEY: old',
              env: {'SUPABASE_API_KEY': 'new'})['apiKey'],
          'new');
    });

    test('parses jsonb model configs and skips invalid ones', () {
      final o = options([], yaml: '''
jsonb:
  public.json_types.col_jsonb:
    type: Meta
    import: package:app/meta.dart
  public.json_types.col_jsonb_array:
    type: Meta
    import: package:app/meta.dart
    isArray: true
  bad_key:
    type: Meta
    import: x.dart
  public.json_types.col_json:
    type: Meta
''');
      final models = o['jsonbModels'] as Map<String, JsonbModelConfig>;
      expect(models.keys,
          ['public.json_types.col_jsonb', 'public.json_types.col_jsonb_array']);
      final single = models['public.json_types.col_jsonb']!;
      expect(single.tableName, 'json_types');
      expect(single.columnName, 'col_jsonb');
      expect(single.dartType, 'Meta');
      expect(single.importPath, 'package:app/meta.dart');
      expect(single.isArray, isFalse);
      expect(models['public.json_types.col_jsonb_array']!.isArray, isTrue);
    });
  });
}
