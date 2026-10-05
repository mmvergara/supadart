import 'dart:io';

import 'package:supadart/generators/swagger/column.dart';
import 'package:test/test.dart';

import '../support/generate.dart';

/// Generated code for each variant is written under .dart_tool, where it
/// resolves this package's dependencies, and type-checked with the analyzer.
///
/// supabase_flutter is not a dependency of this package, so Flutter output has
/// its import swapped for package:supabase, which supabase_flutter re-exports.
const _root = '.dart_tool/supadart_compile';

const _meta = '''
class Meta {
  final String name;
  const Meta(this.name);
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(json['name'] as String);
  Map<String, dynamic> toJson() => {'name': name};
}
''';

final _variants = <String, Map<String, String> Function()>{
  'dart_single': () => generateWith(),
  'dart_separated': () => generateWith(isSeparated: true),
  'flutter_single': () => generateWith(isDart: false),
  'flutter_separated': () => generateWith(isDart: false, isSeparated: true),
  'mappings_and_exclude': () => generateWith(
      isSeparated: true,
      mappings: 'profiles: user_profile\nnumeric_types: numbers',
      exclude: ['New', 'toJson', 'copyWith']),
  // Enum arrays without config fall back to List<String>.
  'no_config_enums': () => generateWith(enums: {}),
  'jsonb_to_dynamic': () => generateWith(jsonbToDynamic: true),
  'jsonb_models': () => {
        'meta.dart': _meta,
        ...generateWith(jsonbModels: {
          for (final (column, isArray) in [
            ('col_jsonb', false),
            ('col_jsonb_array', true),
          ])
            'public.json_types.$column': JsonbModelConfig(
                schema: 'public',
                tableName: 'json_types',
                columnName: column,
                dartType: 'Meta',
                importPath: 'meta.dart',
                isArray: isArray),
        }),
      },
  'postgis': () =>
      generateWith(swaggerJson: swaggerWithPostGIS(), isPostGIS: true),
};

void main() {
  test('generated code type-checks for every option combination', () async {
    final root = Directory(_root);
    if (root.existsSync()) root.deleteSync(recursive: true);

    for (final MapEntry(key: variant, value: generate) in _variants.entries) {
      for (final MapEntry(key: name, value: code) in generate().entries) {
        File('$_root/$variant/$name')
          ..createSync(recursive: true)
          ..writeAsStringSync(code.replaceAll(
              'package:supabase_flutter/supabase_flutter.dart',
              'package:supabase/supabase.dart'));
      }
    }

    final result = await Process.run(
        Platform.resolvedExecutable, ['analyze', '--fatal-warnings', _root]);
    final issues = '${result.stdout}'
        .split('\n')
        .where((l) => l.contains(RegExp(r'^\s*(error|warning) - ')))
        .toList();
    expect(issues, isEmpty, reason: '${result.stdout}${result.stderr}');
    expect(result.exitCode, 0, reason: '${result.stderr}');

    root.deleteSync(recursive: true);
  }, timeout: const Timeout(Duration(minutes: 2)));
}
