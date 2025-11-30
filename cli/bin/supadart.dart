import 'dart:io';

import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supadart/config_init.dart';
import 'package:supadart/generators/index.dart';
import 'package:supadart/generators/storage/fetch_storage.dart';
import 'package:supadart/generators/swagger/column.dart';
import 'package:supadart/generators/utils/fetch_swagger.dart';
import 'package:yaml/yaml.dart';

const String version = 'v1.9.0';
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
  final yamlConfig = await loadYamlConfig(results);
  if (yamlConfig == null) {
    print('Failed to load yaml config');
    exit(1);
  }
  final options = extractOptions(results, yamlConfig);

  if (!validateOptions(options)) {
    print('use -h or --help for help');
    exit(1);
  }

  printConfiguration(options);

  await generateModels(options);
}

ArgParser setupArgParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Show usage information',
    )
    ..addFlag(
      'init',
      abbr: 'i',
      negatable: false,
      help: 'Initialize config file supadart.yaml',
    )
    ..addOption(
      'config',
      abbr: 'c',
      help:
          'Specify a path to config file of yaml   (default: ./supadart.yaml)',
    )
    ..addOption(
      'url',
      abbr: "u",
      help: 'Supabase URL                            (if not set in yaml)',
    )
    ..addOption(
      'key',
      abbr: "k",
      help: 'Supabase API KEY                        (if not set in yaml)',
    )
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

Future<YamlMap?> loadYamlConfig(ArgResults results) async {
  final configPath = results['config'] ?? 'supadart.yaml';
  final configFile = File(configPath);
  try {
    final configContent = await configFile.readAsString();
    print("Config file found");
    return loadYaml(configContent);
  } catch (e) {
    print(
      "${red}You need to create a config file use --init command to generate one$reset",
    );
    return null;
  }
}

Map<String, dynamic> extractOptions(ArgResults results, YamlMap config) {
  // check if env values are set for SUPABASE_URL and SUPABASE_API_KEY
  var env = DotEnv(includePlatformEnvironment: true)..load();
  if (env['SUPABASE_URL'] != null && env['SUPABASE_API_KEY'] != null) {
    print("Using .env file for SUPABASE_URL and SUPABASE_API_KEY");
  }

  // Extract enums as a Map<String, List<String>> from config['enums']
  Map<String, List<String>> enums = {};
  if (config.containsKey('enums')) {
    if (config['enums'] != null) {
      (config['enums'] as Map).forEach((enumName, value) {
        if (value is List) {
          enums["public.$enumName"] = List<String>.from(value);
        }
      });
    }
  }

  // Extract JSONB model configs from config['jsonb']
  // Format: schema.table.column: { type: DartType, import: 'path' }
  Map<String, JsonbModelConfig> jsonbModels = {};
  if (config.containsKey('jsonb')) {
    if (config['jsonb'] != null) {
      (config['jsonb'] as Map).forEach((key, value) {
        final parts = key.toString().split('.');
        if (parts.length != 3) {
          print(
              '${red}Warning: Invalid jsonb key format "$key". Expected format: schema.table.column$reset');
          return;
        }
        if (value['type'] == null || value['import'] == null) {
          print(
              '${red}Warning: jsonb config for "$key" missing type or import$reset');
          return;
        }
        final schema = parts[0];
        final tableName = parts[1];
        final columnName = parts[2];
        jsonbModels[key] = JsonbModelConfig(
          schema: schema,
          tableName: tableName,
          columnName: columnName,
          dartType: value['type'],
          importPath: value['import'],
          isArray: value['isArray'] ?? false,
        );
      });
    }
  }

  return {
    'url':
        results['url'] ?? env['SUPABASE_URL'] ?? config['SUPABASE_URL'] ?? '',
    'apiKey':
        results['key'] ??
        env['SUPABASE_API_KEY'] ??
        config['SUPABASE_API_KEY'] ??
        // Fallback to old key names for backward compatibility
        env['SUPABASE_ANON_KEY'] ??
        config['SUPABASE_ANON_KEY'] ??
        '',
    'isSeparated': config['separated'] ?? false,
    'isDart': config['dart'] ?? false,
    'output': config['output'] ?? './lib/models/',
    'mappings': config['mappings'],
    'exclude': List<String>.from(config['exclude'] ?? []),
    'mapOfEnums': enums,
    'isPostGIS': config['postGIS'] ?? false,
    'jsonbToDynamic': config['jsonbToDynamic'] ?? false,
    'jsonbModels': jsonbModels,
  };
}

bool validateOptions(Map<String, dynamic> options) {
  if (options['url'].isEmpty || options['apiKey'].isEmpty) {
    print(
      "${red}Please Provide the url and key for your supabase instance... You can",
    );
    print("1. Use a .env file to specify SUPABASE_URL and SUPABASE_API_KEY");
    print("2. Set SUPABASE_URL and SUPABASE_API_KEY in .yaml config file");
    print(
      "3. Specificy --url and --key in the cli (ex. supadart -u <url> -k <key>) $reset",
    );
    return false;
  }
  return true;
}

void printConfiguration(Map<String, dynamic> options) {
  print('==============================');
  print('URL:            ${options['url']}');
  print('API KEY:        ${options['apiKey'].substring(0, 25)}...');
  print('Output:         ${options['output']}');
  print('Separated:      ${options['isSeparated']}');
  print('Dart:           ${options['isDart']}');
  print('Mappings:       ${options['mappings']}');
  print('Excluded:       ${options['exclude']}');
  print('Enums:          ${options['mapOfEnums']}');
  print('PostGIS:        ${options['isPostGIS']}');
  print('JsonbToDynamic: ${options['jsonbToDynamic']}');
  print('JsonbModels:    ${(options['jsonbModels'] as Map).keys.toList()}');
  print('==============================');
}

Future<void> generateModels(Map<String, dynamic> options) async {
  print("Fetching database schema...");
  final databaseSwagger = await fetchDatabaseSwagger(
    options['url'],
    options['apiKey'],
    options['mapOfEnums'],
    options['jsonbToDynamic'],
    jsonbModels: options['jsonbModels'],
  );

  if (databaseSwagger == null) {
    print('Failed to fetch database');
    exit(1);
  }

  final storageList = await fetchStorageList(options['url'], options['apiKey']);
  if (storageList == null) {
    print('Failed to fetch storage');
    exit(1);
  }

  print('Generating models...');
  final stopwatch = Stopwatch()..start();
  final files = supadartRun(
    databaseSwagger,
    storageList,
    options['isDart'],
    options['isSeparated'],
    options['mappings'],
    options['exclude'],
    options['mapOfEnums'],
    options['isPostGIS'],
    options['jsonbToDynamic'],
    jsonbModels: options['jsonbModels'],
  );

  await generateAndFormatFiles(files, options['output']);

  stopwatch.stop();
  final elapsed = stopwatch.elapsedMilliseconds;
  print('$green🎉 Done! ${elapsed}ms $reset');
}

class Config {
  final String url;
  final String apiKey;
  final bool isSeparated;
  final bool isDart;
  final String output;

  Config({
    required this.url,
    required this.apiKey,
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
        "Config file not found or couldn't be read. Using CLI arguments only.",
      );
    }

    String url = cliArgs['url'] ?? yamlConfig['supabase_url'] ?? '';
    String apiKey =
        cliArgs['key'] ??
        yamlConfig['supabase_api_key'] ??
        yamlConfig['supabase_anon_key'] ??
        '';

    if (url.isEmpty || apiKey.isEmpty) {
      print(
        "Please provide --url and --key or set supabase_url and supabase_api_key in the YAML file",
      );
      print('Use -h or --help for help');
      exit(1);
    }

    return Config(
      url: url,
      apiKey: apiKey,
      isSeparated: cliArgs['separated'] ?? yamlConfig['separated'] ?? false,
      isDart: cliArgs['dart'] ?? yamlConfig['dart'] ?? false,
      output: cliArgs['output'] ?? yamlConfig['output'] ?? './lib/models/',
    );
  }
}

Future<void> generateAndFormatFiles(
  List<GeneratedFile> files,
  String folderPath,
) async {
  await Future.wait(
    files.map((file) async {
      // file.fileName includes .dart extension
      final filePath = folderPath + file.fileName;
      final fileToGenerate = File(filePath);

      // Create file if it doesn't exist else overwrite it
      await fileToGenerate.create(recursive: true);
      await fileToGenerate.writeAsString(file.fileContent);

      // Format the file
      await formatCode(filePath);
      print('$green🎯 Generated: $filePath $reset');
    }),
  );
}

Future<void> formatCode(String filePath) async {
  try {
    await Process.run('dart', ['format', filePath]);
  } catch (e) {
    print('Failed to format code: $e');
  }
}
