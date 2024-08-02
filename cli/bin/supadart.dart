import 'dart:io';
import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supadart/generator/generator.dart';
import 'package:supadart/generator/swagger.dart';

const String version = 'v1.3.8';
const String red = '\x1B[31m'; // Red text
const String green = '\x1B[32m'; // Green text
const String blue = '\x1B[34m'; // Blue text
const String reset = '\x1B[0m'; // Reset to default color
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
            'Output folder path, add ./ prefix      -- (default: "./lib/models/")')
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

  bool isFlutter = results['dart'] ? false : true;
  bool isSeperated = results['seperated'] ? true : false;

  String? url;
  String? anonKey;
  var envPath = results['env-path'] ?? '.env';
  var env = DotEnv(includePlatformEnvironment: true)..load([envPath]);

  if (results['url'] != null && results['key'] != null) {
    url = results['url'];
    anonKey = results['key'];
  } else {
    url = env['SUPABASE_URL'];
    anonKey = env['SUPABASE_ANON_KEY'];
  }

  if (url == null || anonKey == null) {
    print(
        "Please provide --url and --key or Set SUPABASE_URL and SUPABASE_ANON_KEY in .env file");
    print('use -h or --help for help');
    exit(1);
  }

  final databaseSwagger = await fetchDatabaseSwagger(url, anonKey);
  if (databaseSwagger == null) {
    exit(1);
  }

  final files = generateModelFiles(databaseSwagger, isFlutter, isSeperated);
  await generateAndFormatFiles(files, results['output'] ?? './lib/models/');
}

Future<void> generateAndFormatFiles(
    List<GeneratedFile> files, String folderPath) async {
  await Future.wait(files.map((file) async {
    final filePath = folderPath + file.fileName;
    final fileToGenerate = File(filePath);

    // Create file if it doesn't exist else overwrite it
    await fileToGenerate.create(recursive: true);
    await fileToGenerate.writeAsString(file.fileContent);

    // Format the file
    await formatCode(filePath);
    stdout.write('$green 🎯 Generated: $filePath $reset');
  }));
}

Future<void> formatCode(String filePath) async {
  try {
    ProcessResult result = await Process.run('dart', ['format', filePath]);
    if (result.exitCode != 0) {
      stdout.write('$red Failed to Format $filePath $reset\n');
    } else {
      stdout.write('$blue Formatted $reset\n');
    }
  } catch (e) {
    print('Failed to format code: $e');
  }
}
