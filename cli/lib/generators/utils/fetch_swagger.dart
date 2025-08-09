import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../swagger/swagger.dart';

Future<DatabaseSwagger?> fetchDatabaseSwagger(String url, String anonKey,
    Map<String, List<String>> mapOfEnums, bool jsonbToDynamic,
    {String? schema}) async {
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    url = "https://$url"; // Default to HTTPS if no scheme is provided
  }

  // Prepare headers with accept-profile if schema is provided
  Map<String, String>? headers;
  if (schema != null && schema.isNotEmpty) {
    headers = {'accept-profile': schema};
  }

  try {
    // First attempt with API key in header
    final response =
        await _secureRequest('$url/rest/v1/?apikey=$anonKey', headers: headers);
    if (response.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response.body), mapOfEnums, jsonbToDynamic);
    }

    // Second attempt without API key
    print("Trying without the API key...");
    final response2 = await _secureRequest('$url/rest/v1/', headers: headers);
    if (response2.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response2.body), mapOfEnums, jsonbToDynamic);
    }

    // Third attempt with API key in header
    print("Trying with the API key in header...");
    final headersWithApiKey = headers ?? <String, String>{};
    headersWithApiKey['apikey'] = anonKey;
    final response3 =
        await _secureRequest('$url/rest/v1/', headers: headersWithApiKey);
    if (response3.statusCode == 200) {
      return DatabaseSwagger.fromJson(
          jsonDecode(response3.body), mapOfEnums, jsonbToDynamic);
    }

    print(
        "Failed to fetch Supabase Swagger. Status code: ${response3.statusCode}");
    print("Response body: ${response3.body}");
  } catch (e) {
    print("Error fetching Supabase Swagger: $e");
  }

  return null;
}

Future<http.Response> _secureRequest(String url,
    {bool allowHttpFallback = true, Map<String, String>? headers}) async {
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
    if (headers != null) {
      headers.forEach((key, value) {
        request.headers.set(key, value);
      });
    }

    final response = await request.close();

    return http.Response(
      await response.transform(utf8.decoder).join(),
      response.statusCode,
    );
  } on SocketException catch (e) {
    print("SocketException occurred: $e");
    if (url.startsWith("https://") && allowHttpFallback) {
      print("Attempting to fallback to HTTP...");
      return await _secureRequest(url.replaceFirst("https://", "http://"),
          allowHttpFallback: false, headers: headers);
    }
    rethrow;
  }
}
