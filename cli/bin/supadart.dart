import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    exit(1);
  }

  String? codeOutput = await getGeneratedClasses(url, anonKey);
  if (codeOutput == null) {
    print('Failed to generate classes');
    exit(1);
  }

  // output to /lib/generated_classes.dart
  File file = File('lib/generated_classes.dart');
  file.writeAsStringSync(codeOutput);

  print("*** Classes generated successfully ***");
  print("Output: lib/generated_classes.dart");
}

Future<String?> getGeneratedClasses(
    String supabaseUrl, String supabaseAnonKey) async {
  String url =
      "https://supabase-schema-dart-class-generator.vercel.app/api/generate?SUPABASE_URL=$supabaseUrl&SUPABASE_ANON_KEY=$supabaseAnonKey";
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        print('An error occurred: ${jsonResponse['error']}');
        return null;
      }
      return jsonResponse['data'];
    } else {
      print('HTTP request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e) {
    print('An error occurred: $e');
    return null;
  }
}
