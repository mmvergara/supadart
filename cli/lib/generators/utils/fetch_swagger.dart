import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../swagger/swagger.dart';

Future<DatabaseSwagger?> fetchDatabaseSwagger(String url, String apiKey,
    Map<String, List<String>> mapOfEnums, bool jsonbToDynamic) async {
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    url = "https://$url"; // Default to HTTPS if no scheme is provided
  }

  try {
    // First attempt with API key
    // Use both query param (for compatibility) and headers (new standard)
    final response = await _secureRequest('$url/rest/v1/', apiKey);
    if (response.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response.body), mapOfEnums, jsonbToDynamic);
    }

    // Second attempt without API key (for open/public APIs)
    print("Trying without the API key...");
    final response2 = await _secureRequestNoAuth('$url/rest/v1/');
    if (response2.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response2.body), mapOfEnums, jsonbToDynamic);
    }

    print(
        "Failed to fetch Supabase Swagger. Status code: ${response2.statusCode}");
    print("Response body: ${response2.body}");
  } catch (e) {
    print("Error fetching Supabase Swagger: $e");
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
    return await http.get(Uri.parse(url), headers: headers);
  } on HandshakeException catch (e) {
    print("HandshakeException occurred: $e");
    print("Attempting with a custom HTTP client...");

    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(url);
    final request = await httpClient.getUrl(uri);
    
    // Add headers to the request
    headers.forEach((key, value) {
      request.headers.add(key, value);
    });
    
    final response = await request.close();

    return http.Response(
      await response.transform(utf8.decoder).join(),
      response.statusCode,
    );
  } on SocketException catch (e) {
    print("SocketException occurred: $e");
    if (url.startsWith("https://") && allowHttpFallback) {
      print("Attempting to fallback to HTTP...");
      return await _secureRequest(url.replaceFirst("https://", "http://"), apiKey,
          allowHttpFallback: false);
    }
    rethrow;
  }
}

Future<http.Response> _secureRequestNoAuth(String url,
    {bool allowHttpFallback = true}) async {
  try {
    return await http.get(Uri.parse(url));
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
      return await _secureRequestNoAuth(url.replaceFirst("https://", "http://"),
          allowHttpFallback: false);
    }
    rethrow;
  }
}
