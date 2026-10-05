/// The database schemas models are generated from.
///
/// The first is the primary schema: its tables and types keep their plain
/// names. Those of other schemas are prefixed with their schema, so
/// `inventory.items` becomes `InventoryItems` and `inventory.mood` becomes
/// `INVENTORY_MOOD`.
class Schemas {
  final List<String> names;

  /// [names] must not be empty.
  const Schemas(this.names);

  static const defaults = Schemas(['public']);

  String get primary => names.first;

  /// [name] in [schema], prefixed with the schema unless it is the primary.
  String localName(String schema, String name) =>
      schema == primary ? name : '${schema}_$name';

  /// [localName] of `schema.name`.
  String localNameOf(String qualifiedName) {
    final (schema, name) = split(qualifiedName);
    return localName(schema, name);
  }

  /// `schema.type` for a user-defined type in `public` or one of [names]
  /// (`inventory.mood[]` → `inventory.mood`), or null for any other format.
  String? userTypeName(String? format) {
    if (format == null) return null;
    final name = format.replaceAll('[]', '').replaceAll('"', '');
    final dot = name.indexOf('.');
    if (dot < 0) return null;
    final schema = name.substring(0, dot);
    return schema == 'public' || names.contains(schema) ? name : null;
  }

  /// [typeName] qualified with the primary schema unless it names a schema.
  String qualify(String typeName) =>
      typeName.contains('.') ? typeName : '$primary.$typeName';

  /// The name to give `schema.type` in supadart.yaml.
  String configName(String qualifiedName) {
    final (schema, name) = split(qualifiedName);
    return schema == primary ? name : qualifiedName;
  }

  /// Splits `schema.name` into its parts.
  static (String, String) split(String qualifiedName) {
    final dot = qualifiedName.indexOf('.');
    return (qualifiedName.substring(0, dot), qualifiedName.substring(dot + 1));
  }
}
