const String supadartAbstractClass = '''
abstract class SupadartClass<T> {
  static Map<String, dynamic> insert(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  static Map<String, dynamic> update(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  factory SupadartClass.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  static converter(List<Map<String, dynamic>> data) {
    throw UnimplementedError();
  }

  static converterSingle(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
    
}
''';
