# How supadart is tested

supadart reads a database schema and writes Dart classes from it. The tests ask three questions, in order:

1. **Is the generated code what we expect?** Golden tests.
2. **Does the generated code compile?** Compile tests.
3. **Does the generated code work against a real database?** Integration tests.

Unit tests underneath these check the smaller pieces: type mapping, value parsing, config handling and HTTP fetching.

```
                 supabase/migrations/*.sql   (test schema: one table per type family)
                              │
                     supabase db reset
                              │
                 local Supabase (ports 56420-56429)
                              │
          tool/update_fixtures.dart  (only with --update)
                              │
               ┌──────────────┴──────────────┐
     test/fixtures/swagger.json      test/fixtures/storage.json
               └──────────────┬──────────────┘
                       generator (lib/)
                              │
          ┌───────────────────┼────────────────────┐
     golden test         compile test        integration test
  (text == checked-in)  (dart analyze)   (insert/read real rows using
                                           test/models/generated_classes.dart)
```

## The test database

Everything starts from a schema checked into the repo:

- `supabase/migrations/20240101000000_test_schema.sql` defines the tables, views and enums: `numeric_types`, `string_types`, `datetime_types`, `json_types`, `enum_types`, `profiles` and more. Each table has a column for each Postgres type, plus an array version of each, for example `col_int4` and `col_int4_array`.
- `supabase/seed.sql` creates the storage buckets (`avatars`, `documents`).

`supabase db reset` rebuilds the database from these two files, so every run starts from the same clean state.

This local Supabase project is separate from any other Supabase instance on the machine. It has its own `project_id` and uses ports 56420-56429.

## Fixtures: running the generator offline

The generator's input is the PostgREST swagger JSON from `/rest/v1/` and the storage bucket list from `/storage/v1/bucket/`. Both responses are saved in `test/fixtures/`, so most tests can run the generator without a database.

`tool/update_fixtures.dart` (run with `--update`) captures them from the local instance. It pins bucket timestamps so the files don't change on every reset.

`test/integration/schema_test.dart` checks that the fixtures still match what the live database returns. If someone changes the migration but doesn't refresh the fixtures, this test fails and says to run `--update`.

## The test layers

### Unit tests (`test/unit/`, no database needed)

| File | What it checks |
| --- | --- |
| `type_mapping_test.dart` | Each Postgres type maps to the right Dart type. Real PostgREST values parse correctly, e.g. intervals like `1 year 2 mons -3 days +04:05:06.5`, `json[]` with object elements, and numeric edge cases. |
| `config_options_test.dart` | Each config option changes the output as documented and nothing else. Options covered: `mappings`, `exclude`, `jsonb` models, `jsonbToDynamic`, `postGIS`, `dart` vs Flutter, and single vs `separated` files. Also checks that CLI flags take precedence over `.env`, which takes precedence over `supadart.yaml`. |
| `golden_test.dart` | Runs the generator on the fixtures and compares the output, character for character, with checked-in files. |
| `compile_test.dart` | Generates code for every option combination, writes it under `.dart_tool/`, and runs `dart analyze --fatal-warnings` on it. Any error or warning fails the test. |
| `fetch_test.dart` | Fetching swagger and storage through a mocked HTTP client: headers, the retry without a key, error messages for a rejected anon key, and malformed JSON. |
| `key_check_test.dart` | Telling publishable/anon keys apart from secret/service_role keys. |

### Golden files

The golden files are the expected generator output, checked into git:

- `test/models/generated_classes.dart`: Dart, single file.
- `test/goldens/flutter_separated/`: Flutter, one file per table.

When the generator changes on purpose, regenerate them with `--update` and review the `git diff`. The diff shows exactly how the output changed for users.

### Integration tests (`test/integration/`, need a live Supabase)

They are tagged `integration` and skip automatically when `SUPABASE_URL` and `SUPABASE_API_KEY` aren't set.

| File | What it checks |
| --- | --- |
| `schema_test.dart` | The fixtures still match the live schema and buckets. |
| `runtime_test.dart` | Uses the generated models in `test/models/` with a real `SupabaseClient`. |

For each table, `runtime_test.dart`:

1. **Inserts** a row with `Model.insert(...)`.
2. **Reads** it back with `.withConverter(Model.converter)` and checks every field has the right value and type.
3. **Updates** it with `Model.update(...)` and reads it again.
4. **Round-trips** the row: `fromJson(row.toJson())` must give the same JSON.

Some tests also check the raw values Postgres stores and returns, not only what the models produce. For example:

- `jsonb[]` elements are stored as objects, not as JSON strings.
- An interval written in SQL comes back as `1 year 2 mons -3 days +04:05:06.5`, and the model parses it to the right `Duration`.

`default_values.dart` inserts rows with only an `id`. It checks that unset columns come back as `null` and that columns with a database default come back with that default.

The per-type test bodies are in `test/datatypes/` (e.g. `numeric/int4_int.dart`, `datetime/interval.dart`). Files such as `test/numeric_types.dart` group them by table.

## Running the tests

```bash
cd cli

# Unit + golden + compile tests only (fast, offline). Integration tests are skipped.
dart test

# Everything: start Supabase if needed, reset the DB, run all tests
tool/test_integration.sh

# Same, but first refresh fixtures and goldens. Use after changing the generator or schema.
tool/test_integration.sh --update
```

If the `supabase` CLI isn't on your PATH, the script falls back to `npx supabase`. You can also set it explicitly with `SUPABASE_CLI="npx -y supabase"`.

### Reading the output

Lines like `🎯 Generated: …`, `Trying without the API key...` and `Warning: Invalid jsonb key format "bad_key"` are not failures. Tests deliberately trigger those code paths, and the CLI prints its normal messages. The final line, e.g. `+313: All tests passed!`, is the result.

## CI (`.github/workflows/dart.yml`)

CI runs two jobs on every push and PR:

- **unit:** `dart analyze --fatal-warnings`, then `dart test --exclude-tags integration`.
- **integration:** starts a slimmed-down local Supabase (Postgres, PostgREST, Storage and Kong only), then runs `cli/tool/test_integration.sh`.

## Typical workflows

**Changing the generator:**

1. Edit `lib/`.
2. Run `tool/test_integration.sh --update`.
3. Read the diff in `test/models/` and `test/goldens/`. It shows exactly what changes for users.
4. Commit the code together with the updated goldens.

**Supporting a new Postgres type:**

1. Add a column, and its array version, to the migration.
2. Map the type in the generator.
3. Run `--update`.
4. Add a round-trip test under `test/datatypes/` and a parsing test in `type_mapping_test.dart`.

**Checking that a test actually catches a bug:** temporarily revert the fix and confirm the test fails. This was done for the interval and `json[]` fixes: reverting them caused 11 failures.
