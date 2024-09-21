import 'dart:io';
import 'package:args/args.dart';
import 'package:supadart/config_init.dart';
import 'package:supadart/generators/index.dart';
import 'package:supadart/generators/utils/fetch_swagger.dart';
import 'package:yaml/yaml.dart';

const String version = 'v1.6.2';
const String red = '\x1B[31m';
const String green = '\x1B[32m';
const String blue = '\x1B[34m';
const String reset = '\x1B[0m';

void main(List<String> arguments) async {
  final parser = setupArgParser();
  final results = parser.parse(arguments);

  if (results['help'] || results['version']) {
    handleHelpAndVersion(parser, results);
    return;
  }

  if (results['init']) {
    await configFileInit('supadart.yaml');
    return;
  }

  print("🚀 Supadart $version");

  final config = await loadYamlConfig(results);
  final options = extractOptions(results, config);

  if (!validateOptions(options)) {
    print('use -h or --help for help');
    exit(1);
  }

  printConfiguration(options);

  await generateModels(options);
}

ArgParser setupArgParser() {
  return ArgParser()
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Show usage information')
    ..addFlag('init',
        abbr: 'i',
        negatable: false,
        help: 'Initialize config file supadart.yaml')
    ..addOption('config',
        abbr: 'c', help: 'Path to config file of yaml (default: supadart.yaml)')
    ..addOption('url', abbr: "u", help: 'Supabase URL')
    ..addOption('key', abbr: "k", help: 'Supabase ANON KEY')
    ..addOption('output', abbr: 'o', help: 'Output file path, add ./ prefix')
    ..addOption('exclude',
        abbr: 'e', help: 'Select methods to exclude ex.  "toJson,copyWith"')
    ..addFlag('dart',
        abbr: 'd', negatable: false, help: 'Generation for pure Dart project')
    ..addFlag('separated',
        abbr: 's', negatable: false, help: 'Separated files for each classes')
    ..addFlag('version', abbr: 'v', negatable: false, help: version);
}

void handleHelpAndVersion(ArgParser parser, ArgResults results) {
  if (results['help']) {
    print('Usage: dart script.dart [options]');
    print(parser.usage);
  } else if (results['version']) {
    print(version);
  }
  exit(0);
}

Future<YamlMap> loadYamlConfig(ArgResults results) async {
  final configPath = results['config'] ?? 'supadart.yaml';
  final configFile = File(configPath);
  try {
    final configContent = await configFile.readAsString();
    print("Config file found");
    return loadYaml(configContent);
  } catch (e) {
    print("Using CLI arguments only");
    return YamlMap();
  }
}

Map<String, dynamic> extractOptions(ArgResults results, YamlMap config) {
  return {
    'url': results['url'] ?? config['supabase_url'] ?? '',
    'anonKey': results['key'] ?? config['supabase_anon_key'] ?? '',
    'isSeparated': results['separated'] ? true : config['separated'] ?? false,
    'isDart': results['dart'] ? true : config['dart'] ?? false,
    'output': results['output'] ?? config['output'] ?? './lib/models/',
    'mappings': config['mappings'],
    'exclude': results['exclude']?.split(',') ??
        List<String>.from(config['exclude'] ?? [])
  };
}

bool validateOptions(Map<String, dynamic> options) {
  if (options['url'].isEmpty || options['anonKey'].isEmpty) {
    print(
        "Please provide --url and --key or set supabase_url and supabase_anon_key in .yaml file");
    return false;
  }
  return true;
}

void printConfiguration(Map<String, dynamic> options) {
  print('==============================');
  print('URL:         ${options['url']}');
  print('ANON KEY:    ${options['anonKey'].substring(0, 25)}...');
  print('Output:      ${options['output']}');
  print('Separated:   ${options['isSeparated']}');
  print('Dart:        ${options['isDart']}');
  print('Mappings:    ${options['mappings']}');
  print('Excluded:    ${options['exclude']}');
  print('==============================');
}

Future<void> generateModels(Map<String, dynamic> options) async {
  print("Fetching database schema...");
  final databaseSwagger =
      await fetchDatabaseSwagger(options['url'], options['anonKey']);
  if (databaseSwagger == null) {
    print('Failed to fetch database');
    exit(1);
  }

  print('Generating models...');
  final stopwatch = Stopwatch()..start();
  final files = supadartRun(
    databaseSwagger,
    options['isDart'],
    options['isSeparated'],
    options['mappings'],
    options['exclude'],
  );

  await generateAndFormatFiles(files, options['output']);

  stopwatch.stop();
  final elapsed = stopwatch.elapsedMilliseconds;
  print('$green🎉 Done! ${elapsed}ms $reset');
}

class Config {
  final String url;
  final String anonKey;
  final bool isSeparated;
  final bool isDart;
  final String output;

  Config({
    required this.url,
    required this.anonKey,
    required this.isSeparated,
    required this.isDart,
    required this.output,
  });

  static Future<Config> load(Map<String, dynamic> cliArgs) async {
    final configPath = cliArgs['config'] ?? 'config.yaml';
    final configFile = File(configPath);

    Map<String, dynamic> yamlConfig = {};
    try {
      final configContent = await configFile.readAsString();
      yamlConfig = loadYaml(configContent) as Map<String, dynamic>;
      print("Config file found and loaded");
    } catch (e) {
      print(
          "Config file not found or couldn't be read. Using CLI arguments only.");
    }

    String url = cliArgs['url'] ?? yamlConfig['supabase_url'] ?? '';
    String anonKey = cliArgs['key'] ?? yamlConfig['supabase_anon_key'] ?? '';

    if (url.isEmpty || anonKey.isEmpty) {
      print(
          "Please provide --url and --key or set supabase_url and supabase_anon_key in the YAML file");
      print('Use -h or --help for help');
      exit(1);
    }

    return Config(
      url: url,
      anonKey: anonKey,
      isSeparated: cliArgs['separated'] ?? yamlConfig['separated'] ?? false,
      isDart: cliArgs['dart'] ?? yamlConfig['dart'] ?? false,
      output: cliArgs['output'] ?? yamlConfig['output'] ?? './lib/models/',
    );
  }
}

Future<void> generateAndFormatFiles(
    List<GeneratedFile> files, String folderPath) async {
  await Future.wait(files.map((file) async {
    // file.fileName includes .dart extension
    final filePath = folderPath + file.fileName;
    final fileToGenerate = File(filePath);

    // Create file if it doesn't exist else overwrite it
    await fileToGenerate.create(recursive: true);
    await fileToGenerate.writeAsString(file.fileContent);

    // Format the file
    await formatCode(filePath);
    print('$green🎯 Generated: $filePath $reset');
  }));
}

Future<void> formatCode(String filePath) async {
  try {
    await Process.run('dart', ['format', filePath]);
  } catch (e) {
    print('Failed to format code: $e');
  }
}
