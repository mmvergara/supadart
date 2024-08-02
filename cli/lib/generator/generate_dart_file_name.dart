String generateDartFileName(String tableName) {
  // Remove any non-alphanumeric characters and replace them with an empty string
  String fileName = tableName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), "");

  // Convert the file name to lowercase
  fileName = fileName.toLowerCase();

  return fileName;
}
