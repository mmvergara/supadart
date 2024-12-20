String generateEnums(Map<String, List<String>> mapOfEnums) {
  final code = StringBuffer();
  mapOfEnums.forEach((enumName, enumValues) {
    code.write(
        "enum ${enumName.split(".").last.toUpperCase().replaceAll('"', "")} { ${enumValues.map((e) => e.toLowerCase()).join(", ")} }\n");
  });
  return code.toString();
}
