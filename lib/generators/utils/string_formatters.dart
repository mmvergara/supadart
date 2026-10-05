import 'package:yaml/yaml.dart';

import '../swagger/schemas.dart';

/// The class name for table [name] in [schema]. [mappings] keys are
/// `schema.table`, or just `table` for the primary schema.
String tableNameToClassName(String schema, String name, YamlMap? mappings,
    [Schemas schemas = Schemas.defaults]) {
  final mapped = mappings?['$schema.$name'] ??
      (schema == schemas.primary ? (mappings?[name]) : null);
  return snakeCasingToPascalCasing(mapped ?? schemas.localName(schema, name));
}

String snakeCasingToCamelCasing(String input) {
  int i = 0;
  return input.split('_').map((String word) {
    if (i++ == 0) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join('');
}

String snakeCasingToPascalCasing(String name) {
  return name
      .split("_")
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join("");
}

String pascalCasingToSnakeCasing(String name) {
  return name
      .split(RegExp(r"(?=[A-Z])"))
      .map((word) => word.toLowerCase())
      .join("_");
}

/// [value] as a single-quoted Dart string literal.
String dartStringLiteral(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
  return "'$escaped'";
}

String classNameToFileName(String name) =>
    '${pascalCasingToSnakeCasing(name)}.dart';
