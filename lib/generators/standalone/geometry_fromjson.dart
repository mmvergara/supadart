const geometryFromJsonExtension = r'''
extension GeometryFromJson on Geometry {
  /// Decodes a PostGIS value as returned by PostgREST. PostGIS casts
  /// geometry to json as a GeoJSON object, while geography has no json cast
  /// and arrives as a hex-encoded EWKB string.
  static Geometry fromJson(dynamic value) => value is String
      ? GeometryBuilder.decodeHex(value, format: WKB.geometryExtended)
      : GeometryBuilder.parse(jsonEncode(value));
}
''';
