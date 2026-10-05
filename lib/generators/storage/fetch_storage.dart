import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/supabase_request.dart';
import 'storage.dart';

Future<Storage?> fetchStorageList(String url, String apiKey,
    {http.Client? client}) async {
  url = withScheme(url);
  try {
    // First attempt with API key
    final response = await supabaseGet('$url/storage/v1/bucket/',
        apiKey: apiKey, client: client);
    if (response.statusCode == 200) {
      return Storage.fromJson(jsonDecode(response.body));
    }
    print(
        "Failed to fetch Supabase storage information. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
  } catch (e) {
    print("Error fetching Supabase storage information: $e");
  }
  return null;
}
