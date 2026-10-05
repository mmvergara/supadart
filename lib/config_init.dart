import 'dart:io';

Future<void> configFileInit(String path) async {
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

# SUPABASE_API_KEY must be a secret key (sb_secret_...) or the legacy service_role key.
# Hosted projects no longer expose the schema to anon/publishable keys:
# https://supabase.com/changelog/42949-breaking-change-removing-access-to-openapi-spec-via-the-anon-key
# Keep the secret key out of your app and out of git. Prefer one of:
# 1. A gitignored .env file with SUPABASE_URL and SUPABASE_API_KEY
# 2. --url and --key in the CLI (ex. supadart -u <url> -k <key>)
SUPABASE_URL: 
SUPABASE_API_KEY:


# Optional, the schemas to generate from (default: public). Each must be
# exposed through the Data API. The first keeps plain names; tables and enums of
# the others are prefixed with their schema (inventory.items -> InventoryItems).
schemas:
  - public

# Optional, enums are read from your database automatically.
# Only enums used solely in array columns (e.g. mood[]) need listing here;
# supadart warns about any it cannot find. Values are case sensitive.
# Names without a schema are in the first schema (e.g. inventory.status).
enums:
  # mood: [happy, sad, neutral, excited, angry]

# Optional, where to place the generated classes files default: ./lib/models/
output: lib/models/
# Set to true, if you want to generate separated files for each classes
separated: false
# Set to true, if you are not using Flutter, just normal Dart project
dart: false

# Optional, used to map table names to class names(case-sensitive)
# Use schema.table keys for tables outside the first schema
mappings:
  # books: book
  # categories: category
  # children: child
  # people: person
  # inventory.items: item

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
# Optional: 'isArray: true' if the jsonb field contains a JSON array [{...}, {...}]
# The model must have a fromJson(Map<String, dynamic>) factory and toJson() method
jsonb:
  # Single object:
  # public.users.profile_data:
  #   type: UserProfile
  #   import: 'package:my_app/models/user_profile.dart'
  #
  # Array of objects (jsonb containing [{...}, {...}]):
  # public.users.tags:
  #   type: Tag
  #   import: 'package:my_app/models/tag.dart'
  #   isArray: true

''');

  print('Config file created at $path, please fill the fields');
}
