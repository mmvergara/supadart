import 'package:dotenv/dotenv.dart';
import 'package:supadart/generators/swagger/column.dart';
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
    test('declares a Dart enum per configured Postgres enum', () {
      final code = generateWith()['generated_classes.dart']!;
      expect(
          code, contains('enum MOOD { happy, sad, neutral, excited, angry }'));
      expect(code, contains('enum USERGROUP { USERS, ADMIN, MODERATOR }'));
      expect(code, contains('final MOOD colMood;'));
      expect(code, contains('final List<USERGROUP> userGroups;'));
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
      expect(code, contains('GeometryBuilder.decodeHex('));
      expect(
          code, contains('location.toBytesHex(format: WKB.geometryExtended)'));
    });

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
        'public.mood': ['happy', 'sad']
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
