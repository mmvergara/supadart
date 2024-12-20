String generateEnums(Map<String, List<String>> mapOfEnums) {
  final code = StringBuffer();
  mapOfEnums.forEach((enumName, enumValues) {
    code.write(
        "enum ${enumName.split(".").last.toUpperCase().replaceAll('"', "")} { ${enumValues.join(", ")} }\n");
  });
  return code.toString();
}
