import 'dart:convert';
import 'package:http/http.dart' as http;
import '../swagger/swagger.dart';

Future<DatabaseSwagger?> fetchDatabaseSwagger(
    String url, String anonKey) async {
  final response = await http.get(Uri.parse('$url/rest/v1/?apikey=$anonKey'));
  String responseBody = "";
  if (response.statusCode == 200) {
    return DatabaseSwagger.fromJson(jsonDecode(response.body));
  } else {
    print("Error Fetching Supabase Swagger");
    responseBody = response.body;
  }

  print("Trying without the api key...");
  final response2 = await http.get(Uri.parse('$url/rest/v1/'));
  if (response2.statusCode == 200) {
    print("Fetched Supabase Swagger!");
    return DatabaseSwagger.fromJson(jsonDecode(response.body));
  }

  print(responseBody);
  return null;
}
