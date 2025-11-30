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
# 1. Use a .env file to specify SUPABASE_URL and SUPABASE_API_KEY
# 2. Specify --url and --key in the CLI (ex. supadart -u <url> -k <key>)
SUPABASE_URL: 
SUPABASE_API_KEY:


# Enums in your database? map them here (Case Sensitive)
# Please take a look at the documentation to see how to work with enums
enums:
  # mood: [happy, sad, neutral, excited, angry]

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

# Optional, used to exclude methods from generated classes, comment out to include them
exclude:
  # - toJson
  - copyWith
  - New

# Optional, enables support for PostGIS types
# Requires the geobase package
postGIS: false

# Optional, map jsonb fields to dynamic instead of Map<String, dynamic>
# Set to true to enable (default: false)
jsonbToDynamic: false

# Optional, map JSONB columns to custom Dart model types
# Format: schema.table.column (e.g., public.users.profile_data)
# Each entry requires 'type' (Dart class name) and 'import' (import path)
# The model must have a fromJson(Map<String, dynamic>) factory and toJson() method
jsonb:
  # public.users.profile_data:
  #   type: UserProfile
  #   import: 'package:my_app/models/user_profile.dart'
  # public.orders.metadata:
  #   type: OrderMetadata
  #   import: 'package:my_app/models/order_metadata.dart'

''');

  print('Config file created at $path, please fill the fields');
}
