import 'package:supabase/supabase.dart';

class Storage {
  final List<Bucket> buckets;

  Storage(this.buckets);

  factory Storage.fromJson(List<dynamic> json) {
    return Storage(
      json.map((bucket) => Bucket.fromJson(bucket)).toList(),
    );
  }
}
