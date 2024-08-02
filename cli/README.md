# Supabase Schema Dart Class Generator

This is a simple command line tool that generates dart classes from your Supabase schema.

## Installation

```bash
# 🎯 Active from pub.dev
dart pub global activate supadart
```

```bash
# 🚀 Run via
supadart
# or
dart pub global run supadart
```

## Generate Classes

```bash
# If you have a .env file in the root of your project
supadart

# If you have a .env file in a different location
supadart -e path/to/.env

# If you dont have a .env file specify the Supabase URL and ANON KEY
supadart -u <your-supabase-url> -k <your-supabase-anon-key>
```

> Note: If you are not using Flutter, just normal Dart project, add `-d` option

## Options

```bash
-h, --help         Show usage information
-e, --env-path     Path to the .env file -- (default: .env)
-u, --url          Supabase URL          -- (default: .env SUPABASE_URL)
-k, --key          Supabase ANON KEY     -- (default: .env SUPABASE_ANON_KEY)
-o, --output       Output file path      -- (default: "lib/generated_classes.dart" or "lib/models/" if --seperated is enabled)
-d, --dart         Enable if you are not using Flutter, just normal Dart project
-s, --seperated    Generate Seperate files for each classes
    --server-url   Custom server URL (e.g., http://localhost:3000)
-v, --version      v1.3.2
```
