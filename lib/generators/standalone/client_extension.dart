import '../storage/storage.dart';
import '../swagger/swagger.dart';

String generateClientExtension(DatabaseSwagger swagger) {
  final code = StringBuffer('extension SupadartClient on SupabaseClient {\n');
  for (final table in swagger.tables) {
    final getter =
        swagger.schemas.localName(table.schema, table.name).toLowerCase();
    // The client queries public unless told otherwise.
    final client = table.schema == 'public' ? '' : "schema('${table.schema}').";
    code.write(
        "SupabaseQueryBuilder get $getter => ${client}from('${table.name}');\n");
  }
  code.write('}\n');
  return code.toString();
}

String generateStorageClientExtension(Storage storageList) {
  final code = StringBuffer(
      'extension SupadartStorageClient on SupabaseStorageClient {\n');
  for (final bucket in storageList.buckets) {
    code.write(
        "StorageFileApi get ${bucket.name} => from('${bucket.name}');\n");
  }
  code.write('}\n');
  return code.toString();
}
