// This class is copied from https://github.com/supabase/supabase-flutter
// and is used to generate the storage client extension
// We need to keep it here to avoid having to add the supabase package as a dependency
class Bucket {
  final String id;
  final String name;
  final String owner;
  final String createdAt;
  final String updatedAt;
  final bool public;
  final int? fileSizeLimit;
  final List<String>? allowedMimeTypes;

  const Bucket({
    required this.id,
    required this.name,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.public,
    this.fileSizeLimit,
    this.allowedMimeTypes,
  });

  Bucket.fromJson(Map<String, dynamic> json)
      : id = (json)['id'] as String,
        name = json['name'] as String,
        owner = json['owner'] as String,
        createdAt = json['created_at'] as String,
        updatedAt = json['updated_at'] as String,
        public = json['public'] as bool,
        fileSizeLimit = json['file_size_limit'] as int?,
        allowedMimeTypes = json['allowed_mime_types'] == null
            ? null
            : List<String>.from(json['allowed_mime_types'] as List);
}

class Storage {
  final List<Bucket> buckets;

  Storage(this.buckets);

  factory Storage.fromJson(List<dynamic> json) {
    return Storage(
      json.map((bucket) => Bucket.fromJson(bucket)).toList(),
    );
  }
}
