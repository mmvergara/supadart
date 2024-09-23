import '../storage/storage.dart';
import '../swagger/swagger.dart';

String generateClientExtension(DatabaseSwagger swagger) {
  final code = StringBuffer('extension SupadartClient on SupabaseClient {\n');
  swagger.definitions.forEach((tableName, _) {
    code.write(
        "SupabaseQueryBuilder get ${tableName.toLowerCase()} => from('$tableName');\n");
  });
  code.write('}\n');
  return code.toString();
}

String generateStorageClientExtension(Storage storageList) {
  final code = StringBuffer(
      'extension SupadartStorageClient on SupabaseStorageClient {\n');
  storageList.buckets.forEach((bucket) {
    code.write(
        "StorageFileApi get ${bucket.name} => from('${bucket.name}');\n");
  });
  code.write('}\n');
  return code.toString();
}
