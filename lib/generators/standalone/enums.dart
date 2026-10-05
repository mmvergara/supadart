import '../utils/string_formatters.dart';

/// Generates a Dart enum for each Postgres enum in [enums], keyed by type name.
///
/// Each constant keeps its database label in `value`, so labels that are not
/// valid Dart identifiers (`in-progress`, `2fa`, `default`) still round-trip.
String generateEnums(Map<String, List<String>> enums) {
  final code = StringBuffer();
  enums.forEach((typeName, labels) {
    final name = enumDartName(typeName);
    final constants = enumConstantNames(labels);
    code.writeln('enum $name {');
    final constantList = [
      for (var i = 0; i < labels.length; i++)
        '${constants[i]}(${dartStringLiteral(labels[i])})'
    ];
    code.writeln('${constantList.join(',\n')};');
    code.writeln('const $name(this.value);');
    code.writeln();
    code.writeln('/// The label as stored in the database.');
    code.writeln('final String value;');
    code.writeln();
    code.writeln('static $name fromValue(String value) =>');
    code.writeln('values.firstWhere((e) => e.value == value);');
    code.writeln('}');
    code.writeln();
  });
  return code.toString();
}

/// The Dart type name for the Postgres enum [typeName] (`mood` → `MOOD`).
String enumDartName(String typeName) {
  final name = typeName.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9_]'), '_');
  return name.startsWith(RegExp(r'[0-9]')) ? 'ENUM_$name' : name;
}

/// Dart constant names for enum [labels], in order and without duplicates.
List<String> enumConstantNames(List<String> labels) {
  final used = <String>{};
  return [
    for (var i = 0; i < labels.length; i++)
      _unique(_constantName(labels[i], i), used)
  ];
}

String _unique(String base, Set<String> used) {
  var name = base;
  for (var n = 2; !used.add(name); n++) {
    name = '$base$n';
  }
  return name;
}

/// Labels that are already valid public identifiers are kept as is. Others
/// are camelCased from their alphanumeric words (`in-progress` → `inProgress`).
String _constantName(String label, int index) {
  var name = label;
  if (!RegExp(r'^[A-Za-z$][A-Za-z0-9_$]*$').hasMatch(name)) {
    final words =
        label.split(RegExp(r'[^A-Za-z0-9]+')).where((w) => w.isNotEmpty);
    if (words.isEmpty) return 'value$index';
    name = words.first +
        words.skip(1).map((w) => w[0].toUpperCase() + w.substring(1)).join();
    if (name.startsWith(RegExp(r'[0-9]'))) name = 'v$name';
  }
  return _reservedNames.contains(name) ? '${name}_' : name;
}

/// Names an enum constant cannot take: Dart reserved words and members of
/// the generated enum.
const _reservedNames = {
  'assert', 'await', 'break', 'case', 'catch', 'class', 'const', 'continue',
  'default', 'do', 'else', 'enum', 'extends', 'false', 'final', 'finally',
  'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return', 'super',
  'switch', 'this', 'throw', 'true', 'try', 'var', 'void', 'while', 'with',
  'yield',
  // Members of every enum, and of the ones generated above.
  'values', 'index', 'name', 'hashCode', 'runtimeType', 'toString',
  'noSuchMethod', 'value', 'fromValue',
};
