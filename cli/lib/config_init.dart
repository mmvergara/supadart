import 'dart:io';

configFileInit(String path) async {
  // Create a new file
  File file = File(path);

  // Check if the file already exists
  if (await file.exists()) {
    // Prompt the user to overwrite the file
    print('Config file already exists. Do you want to overwrite it? (yes/no)');
    final userInput = stdin.readLineSync();
    if (userInput != null &&
        (userInput.toLowerCase() == 'yes' || userInput.toLowerCase() == 'y')) {
      print('Overwriting the file...');
    } else {
      print('File not overwritten.');
      exit(0);
    }
  }

  // Write to the file
  file.writeAsStringSync('''

# Don't want to expose your supabase credentials? you have two options
# Use a .env file
# Specify --url and --key in the CLI (ex. supadart -u <url> -k <key>)
supabase_url: https://xxx.supabase.co
supabase_anon_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


# Optional, where to place the generated classes files default: ./lib/models/
output: lib/models/
# Set to true, if you want to generate separated files for each classes
separated: false
# Set to true, if you are not using Flutter, just normal Dart project
dart: false
# Optional, used to map table names to class names(case-sensitive)
mappings:
  # books: book
  # categories: category
  # children: child
  # people: person
# Do you have a column that is array of enum type (enum[]) type? If yes, you need to specify the enums
enums:
  # mood: [happy, sad, neutral, excited, angry]
# Optional, used to exclude methods from generated classes
exclude:
  # - toJson
  # - copyWith

''');

  print('Config file created at $path, please fill the fields');
}
