import 'dart:io';

import 'package:test/test.dart';

import '../support/generate.dart';

/// Generates code from the checked-in swagger/storage fixtures and compares it
/// with the checked-in output. After an intended generator change, refresh the
/// goldens with `tool/test_integration.sh --update` and review the diff.
void main() {
  for (final config in goldenConfigs) {
    group('golden: ${config.name}', () {
      late Map<String, String> generated;

      setUpAll(() async {
        generated = await generateFromFixtures(config);
      });

      test('produces the expected set of files', () {
        final onDisk = Directory(config.goldenDir)
            .listSync()
            .whereType<File>()
            .map((f) => f.uri.pathSegments.last)
            .toSet();
        expect(generated.keys.toSet(), onDisk);
      });

      test('matches the checked-in output', () {
        for (final entry in generated.entries) {
          final golden = File('${config.goldenDir}${entry.key}');
          expect(entry.value, golden.readAsStringSync(),
              reason: '${golden.path} is out of date');
        }
      });
    });
  }
}
