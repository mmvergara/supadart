import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

const String version = 'v1.3.1';
// const String baseUrl =
// 'https://supabase-schema-dart-class-generator.vercel.app/api/generate/';

const String baseUrl = 'http://localhost:3000/api/generate/';
void main(List<String> arguments) async {
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
        help:
            'Output file path      -- (default: lib/generated_classes.dart or lib/models/*classname.dart if --seperated is enabled)')
    ..addFlag('dart',
        abbr: 'd',
        negatable: false,
        help: 'Enable if you are not using Flutter, just normal Dart project')
    ..addFlag('seperated',
        negatable: false,
        abbr: 's',
        help: 'Generate Seperate files for each classes')
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
  bool isSeperated = results['seperated'] ?? false;

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

  final requestUrl = Uri.parse(baseUrl).replace(queryParameters: {
    'SUPABASE_URL': url,
    'SUPABASE_ANON_KEY': anonKey,
    if (isDart) 'dart': 'true',
    if (isSeperated) 'seperated': 'true',
  });

  final jsonResponse = await fetchGeneratedClasses(requestUrl);

  if (isSeperated) {
    Map<String, dynamic>? codeOutput =
        jsonResponse['data'] as Map<String, dynamic>?;
    if (codeOutput == null) {
      print('Failed to generate classes');
      exit(1);
    }

    String outputPath = results['output'] ?? 'lib/models/';
    codeOutput.forEach((className, classCode) {
      // Create if not exists
      File file = File('$outputPath$className.dart');
      file.createSync(recursive: true);
      file.writeAsStringSync(classCode.toString());

      print("*** Generated $outputPath$className.dart ***");
    });
  } else {
    String? codeOutput = jsonResponse['data'] as String?;
    if (codeOutput == null) {
      print('Failed to generate classes');
      exit(1);
    }

    String outputPath = results['output'] ?? 'lib/generated_classes.dart';
    // Create if not exists
    File file = File(outputPath);
    file.createSync(recursive: true);
    file.writeAsStringSync(codeOutput);

    print("*** Classes generated successfully ***");
    print("*** Output: $outputPath ***");
  }
}

Future<dynamic> fetchGeneratedClasses(
  Uri requestUrl,
) {
  return http.get(requestUrl).then((response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error fetching data from API");
      return null;
    }
  });
}
