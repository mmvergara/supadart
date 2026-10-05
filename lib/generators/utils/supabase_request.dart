import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Prefixes [url] with `https://` when it has no scheme.
String withScheme(String url) {
  if (url.startsWith("http://") || url.startsWith("https://")) return url;
  return "https://$url"; // Default to HTTPS if no scheme is provided
}

/// GETs [url], authenticating with [apiKey] when given.
///
/// Retries with a lenient TLS client on a handshake failure, and over plain
/// HTTP once on a socket failure.
Future<http.Response> supabaseGet(String url,
    {String? apiKey,
    bool allowHttpFallback = true,
    http.Client? client}) async {
  // New publishable/secret keys use 'apikey' header
  // Old JWT-based anon/service_role keys use 'Authorization: Bearer' header
  // For compatibility, send both
  final headers = apiKey == null
      ? <String, String>{}
      : {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'};

  try {
    return await (client?.get ?? http.get)(Uri.parse(url), headers: headers);
  } on HandshakeException catch (e) {
    print("HandshakeException occurred: $e");
    print("Attempting with a custom HTTP client...");

    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final request = await httpClient.getUrl(Uri.parse(url));
    headers.forEach(request.headers.add);
    final response = await request.close();

    return http.Response(
      await response.transform(utf8.decoder).join(),
      response.statusCode,
    );
  } on SocketException catch (e) {
    print("SocketException occurred: $e");
    if (url.startsWith("https://") && allowHttpFallback) {
      print("Attempting to fallback to HTTP...");
      return await supabaseGet(url.replaceFirst("https://", "http://"),
          apiKey: apiKey, allowHttpFallback: false, client: client);
    }
    rethrow;
  }
}
