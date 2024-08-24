String generateConverterMethod(String className) {
  return '''
static List<$className> converter(List<Map<String, dynamic>> data) {
  return data.map($className.fromJson).toList();
}
''';
}

String generateConverterSingleMethod(String className) {
  return '''
static $className converterSingle(Map<String, dynamic> data) {
  return $className.fromJson(data);
}
''';
}
