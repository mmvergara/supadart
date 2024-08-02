String snakeCasingToPascaleCasing(String name) {
  return name
      .split("_")
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join("");
}

String classNameToFileName(String className) {
  // Remove any non-alphanumeric characters and replace them with an empty string
  String fileName = className.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

  // Convert the file name to lowercase
  fileName = "${fileName.toLowerCase()}.dart";

  return fileName;
}
