# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

supadart is a Dart CLI that reads a Supabase project's PostgREST OpenAPI (swagger) schema and generates typesafe Dart/Flutter model classes, a `SupabaseClient` extension, enums, and storage bucket helpers. `DEV_SETUP.MD` and `TESTING.md` are the authoritative docs for development and testing.

## Commands

```bash
dart pub get
dart format --output=none --set-exit-if-changed .   # CI formatting check
dart analyze --fatal-warnings                        # CI analysis (strict-casts, strict-raw-types)

dart test                                   # unit + golden + compile tests; integration tests auto-skip without SUPABASE_URL/SUPABASE_API_KEY
dart test test/unit/golden_test.dart        # single file
dart test --name "interval"                 # tests matching a name
dart test --exclude-tags integration        # what CI's unit job runs

tool/test_integration.sh            # start local Supabase (Docker), db reset, run everything
tool/test_integration.sh --update   # same, but first refresh test/fixtures, test/models and test/goldens

dart run bin/supadart.dart --url <url> --key <secret_key>   # run the CLI from source
```

The local Supabase project in `supabase/` uses its own `project_id` and ports 56420-56429. If the `supabase` CLI isn't installed, the script falls back to `npx supabase` (override with `SUPABASE_CLI`).

## Architecture

Pipeline: `bin/supadart.dart` → fetch → parse → generate → write + `dart format`.

1. **Config** (`bin/supadart.dart` `extractOptions`): precedence is CLI flags > `.env`/environment > `supadart.yaml`. Options: `schemas`, `mappings`, `exclude`, `enums`, `jsonb` (typed JSONB models keyed `schema.table.column`), `jsonbToDynamic`, `postGIS`, `dart` (vs Flutter imports), `separated`, `output`. The `Config` class at the bottom of that file is unused legacy code.
2. **Fetch** (`lib/generators/utils/fetch_swagger.dart`, `storage/fetch_storage.dart`): GETs `/rest/v1/` once per schema using the `Accept-Profile` header, and `/storage/v1/bucket/`. Requires a secret/service_role key; `lib/key_check.dart` detects anon/publishable keys.
3. **Parse** (`lib/generators/swagger/`): `DatabaseSwagger.fromSchemas` → `Table` → `Column`. Column metadata is recovered from swagger: `format` is the Postgres type, the description carries `<pk/>` and the `[supadart:serial]` marker, and `required` drives nullability. Enum values come from swagger for non-array columns only; array-only enums must be listed in `supadart.yaml` (a warning is emitted). `Schemas` handles multi-schema naming: the first schema keeps plain names, the others are prefixed (`inventory.items` → `InventoryItems`, enum `INVENTORY_MOOD`).
4. **Generate** (`lib/generators/index.dart` `supadartRun`): checks Dart name clashes, builds one class per table/view (`class/class.dart` composes `from_json`, `generate_map`/`to_json`, `insert`, `update`, `copy_with`, `new`, `converters`), plus standalone pieces (`standalone/`). Imports such as `intl`, `dart:convert`, and the `DurationFromString`/`GeometryFromJson` helpers are added by string-sniffing the generated class code. Output is either a single `generated_classes.dart` or one file per class plus `supadart_header.dart` and `supadart_exports.dart`.

### Type mapping touches several places

Adding or changing a Postgres type usually means editing all of these consistently:
- `swagger/utils.dart` `postgresFormatToDartType`: Dart field type
- `class/from_json.dart` `decodeFromJson`: decoding, plus `dartTypeDefaultNullValue` for non-nullable fallbacks (column-selection queries fill missing columns with these defaults)
- `class/generate_map.dart` `encodeToJson`: encoding for insert/update/toJson

Typed JSONB models and enums are handled before the format switch in each. Unknown types fall back to `String`.

## Testing workflow

- Golden output lives in `test/models/generated_classes.dart` (Dart, single file, also used by the integration runtime tests) and `test/goldens/flutter_separated/`. Generator inputs come from `test/fixtures/swagger.json` and `storage.json`.
- After changing the generator or `supabase/migrations/`, run `tool/test_integration.sh --update` and review the golden diff. Commit the goldens together with the code change.
- `test/unit/compile_test.dart` runs `dart analyze --fatal-warnings` on generated code for every option combination, so generated code must be warning-free.
- For a new Postgres type: add a column and its array version to the migration, map the type, run `--update`, then add a round-trip test under `test/datatypes/` and a parsing test in `test/unit/type_mapping_test.dart`.

## Releasing

Bump the version in `pubspec.yaml`, the `version` constant in `bin/supadart.dart`, and add a `## x.y.z` entry at the top of `CHANGELOG.md`. `test/unit/version_test.dart` checks that all three agree. Pushing a `vX.Y.Z` tag triggers `.github/workflows/publish.yml`.
