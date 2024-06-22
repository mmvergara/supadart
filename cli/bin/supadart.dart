import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  const String version = 'v1.2.0';

  final parser = ArgParser()
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Show usage information')
    ..addOption('env-path',
        abbr: "e", help: 'Path to the .env file -- (default: .env)')
    ..addOption('url',
        abbr: "u",
        help: 'Supabase URL          -- (default: .env SUPABASE_URL)')
    ..addOption('key',
        abbr: "k",
        help: 'Supabase ANON KEY     -- (default: .env SUPABASE_ANON_KEY)')
    ..addOption('output',
        abbr: 'o',
        help: 'Output file path      -- (default: lib/generated_classes.dart)')
    ..addFlag('dart',
        abbr: 'd',
        negatable: false,
        help: 'Enable if you are not using Flutter, just normal Dart project')
    ..addFlag('version', abbr: 'v', negatable: false, help: version);

  final results = parser.parse(arguments);

  if (results['help']) {
    print('Usage: dart script.dart [options]');
    print(parser.usage);
    exit(0);
  }

  if (results['version']) {
    print(version);
    exit(0);
  }

  bool isDart = results['dart'] ?? false;

  String? url;
  String? anonKey;

  if (results['url'] != null && results['key'] != null) {
    url = results['url'];
    anonKey = results['key'];
  } else {
    var envPath = results['env-path'] ?? '.env';
    var env = DotEnv(includePlatformEnvironment: true)..load([envPath]);

    url = env['SUPABASE_URL'];
    anonKey = env['SUPABASE_ANON_KEY'];
  }

  if (url == null || anonKey == null) {
    print(
        "Please provide --url and --key or Set SUPABASE_URL and SUPABASE_ANON_KEY in .env file");

    //print help
    print('use -h or --help for help');

    exit(1);
  }

  String? codeOutput = await getGeneratedClasses(url, anonKey, isDart);
  if (codeOutput == null) {
    print('Failed to generate classes');
    exit(1);
  }

  String outputPath = results['output'] ?? 'lib/generated_classes.dart';
  File file = File(outputPath);
  file.writeAsStringSync(codeOutput);

  print("*** Classes generated successfully ***");
  print("*** Output: $outputPath ***");
}

Future<String?> getGeneratedClasses(
    String supabaseUrl, String supabaseAnonKey, bool isDart) async {
  String url =
      "https://supabase-schema-dart-class-generator.vercel.app/api/generate?SUPABASE_URL=$supabaseUrl&SUPABASE_ANON_KEY=$supabaseAnonKey";

  if (isDart) {
    url += "&dart=true";
  }

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
