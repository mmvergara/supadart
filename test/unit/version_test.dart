import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../../bin/supadart.dart' show version;

void main() {
  test('--version matches pubspec.yaml', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    expect(version, 'v${pubspec['version']}');
  });

  test('CHANGELOG.md has an entry for the current version', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    final changelog = File('CHANGELOG.md').readAsStringSync();
    expect(changelog, startsWith('## ${pubspec['version']}\n'));
  });
}
