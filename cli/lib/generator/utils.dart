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

String tableNameToClassName(String name) => snakeCasingToPascalCasing(name);

String classNameToFileName(String name) =>
    '${pascalCasingToSnakeCasing(name)}.dart';
