# Dev Environment Setup

### Install Dependencies

```bash
dart pub get
```

### Compile and Run

```bash
# Compile and run > Initialize config file supadart.yaml
dart compile exe bin/supadart.dart ; ./bin/supadart.exe --init

# Compile and run > Generate dart classes
dart compile exe bin/supadart.dart ; ./bin/supadart.exe --url <supabase_url> --key <supabase_secret_key>
```

### Testing

Tests need Docker and the [Supabase CLI](https://supabase.com/docs/guides/local-development/cli/getting-started) (or `npx`). They run against a local Supabase project defined in `supabase/`. That project has its own `project_id` and uses ports 56420-56429, so it can run next to other local Supabase instances.

| Layer | Location | Needs Supabase | What it checks |
| --- | --- | --- | --- |
| Unit | `test/unit/` | No | Postgres → Dart type mapping and parsing of real PostgREST values, each config option (`mappings`, `exclude`, `jsonb`, `jsonbToDynamic`, `postGIS`, `dart`, `separated`, CLI/env/yaml precedence), generated code type-checks for every option combination (Flutter included), key detection, fetch/error handling (mocked HTTP), generator output vs goldens |
| Integration | `test/integration/` | Yes | Live schema matches the fixtures; insert/update/read round-trips through the generated models for every table in the test schema, including nulls and database defaults |

```bash
# Unit tests only (fast, offline). Integration tests are skipped without SUPABASE_URL / SUPABASE_API_KEY.
dart test

# Everything: starts Supabase if needed, resets the DB from migrations + seed, runs all tests
tool/test_integration.sh
```

#### Test schema

- `supabase/migrations/` holds the tables, views and enums the tests cover.
- `supabase/seed.sql` holds the storage buckets.

`supabase db reset` rebuilds both.

#### Fixtures and goldens

- `test/fixtures/` stores the swagger and storage responses captured from the local instance. Golden tests feed these into the generator.
- `test/models/` holds the expected output for a Dart project with a single file. The integration tests also run against these models.
- `test/goldens/` holds the expected output for a Flutter project with separate files.

After changing the generator or the test schema, refresh fixtures and goldens, then review the diff:

```bash
tool/test_integration.sh --update
```

#### Running against another instance

To run the integration tests against a different instance, set `SUPABASE_URL` and `SUPABASE_API_KEY` in the environment or in a `.env` file. Use a secret key: hosted projects reject anon/publishable keys for the schema endpoint.

### Releasing

1. Bump `version` in `pubspec.yaml` and `version` in `bin/supadart.dart`, and add a `## x.y.z` entry at the top of `CHANGELOG.md` (a unit test checks all three agree).
2. Run `dart pub publish --dry-run` and fix any warnings.
3. Merge to `main`, then tag and push: `git tag vX.Y.Z && git push origin vX.Y.Z`.
4. `.github/workflows/publish.yml` publishes the tag to pub.dev.
