import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'storage.dart';

Future<Storage?> fetchStorageList(String url, String apiKey) async {
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    url = "https://$url"; // Default to HTTPS if no scheme is provided
  }
  try {
    // First attempt with API key
    final response = await _secureRequest('$url/storage/v1/bucket/', apiKey);
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

Future<http.Response> _secureRequest(String url, String apiKey,
    {bool allowHttpFallback = true}) async {
  // New publishable/secret keys use 'apikey' header
  // Old JWT-based anon/service_role keys use 'Authorization: Bearer' header
  // For compatibility, send both
  var headers = {
    'apikey': apiKey,
    'Authorization': 'Bearer $apiKey',
  };

  try {
    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  } on HandshakeException catch (e) {
    print("HandshakeException occurred: $e");
    print("Attempting with a custom HTTP client...");

    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(url);
    final request = await httpClient.getUrl(uri);
    final response = await request.close();

    return http.Response(
      await response.transform(utf8.decoder).join(),
      response.statusCode,
    );
  } on SocketException catch (e) {
    print("SocketException occurred: $e");
    if (url.startsWith("https://") && allowHttpFallback) {
      print("Attempting to fallback to HTTP...");
      return await _secureRequest(
          url.replaceFirst("https://", "http://"), apiKey,
          allowHttpFallback: false);
    }
    rethrow;
  }
}
