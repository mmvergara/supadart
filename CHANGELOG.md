## 2.1.0

- Generate models from schemas other than `public` ([#88](https://github.com/mmvergara/supadart/issues/88)). Set `schemas: [public, inventory]` in `supadart.yaml` or pass `--schema public,inventory`. Each schema is fetched through PostgREST's `Accept-Profile` header and must be exposed through the Data API; supadart explains when one is not. The first schema keeps plain names, the others are prefixed (`InventoryItems`, `INVENTORY_MOOD`, `supabase.inventory_items`), and generation stops with a list of clashes if two tables or enums would still share a name.
- Generated client getters for tables outside `public` query their schema (`schema('inventory').from('items')`).
- Every generated class now has a `schema_name` alongside `table_name`.
- `mappings` accept `schema.table` keys, and `enums` accept `schema.type` keys. Unqualified keys refer to the first schema, which is `public` by default, so existing configs are unchanged.
- **Library API:** `DatabaseSwagger.definitions` is replaced by `tables` (each `Table` has a `schema`), and `DatabaseSwagger.enums` is keyed by `schema.type`. Use `DatabaseSwagger.fromSchemas` to parse several schemas.

## 2.0.1

- Fixed PostGIS `geometry` columns failing to decode. PostgREST returns `geometry` as a GeoJSON object (PostGIS casts it to json) and `geography` as a hex EWKB string; generated `fromJson` now handles both through a `GeometryFromJson.fromJson` helper. Geometry arrays now decode each element instead of the whole list.

## 2.0.0

> **Getting a 401 or 403 when fetching the schema? Use a secret key.**
> Since April 8, 2026, hosted Supabase projects no longer serve the schema (`/rest/v1/`) to anon or publishable keys ([Supabase changelog](https://supabase.com/changelog/42949-breaking-change-removing-access-to-openapi-spec-via-the-anon-key)). This is a Supabase change and affects every supadart version, 1.x included. Pass a secret key (`sb_secret_...`) or the legacy `service_role` key as `SUPABASE_API_KEY`, ideally from a gitignored `.env`, and never ship it in your app. Local Supabase stacks still accept the anon/publishable key. See [#185](https://github.com/mmvergara/supadart/issues/185).

- Enums are now read from the database schema; `enums:` in `supadart.yaml` is only needed for enums used solely in array columns. Schema values take precedence over the config, with a warning when they differ.
- **Breaking:** generated enums are now enhanced enums that keep each database label in `.value` (with `fromValue` to parse one). Labels that are not valid Dart identifiers (`in-progress`, `2fa`, `default`) now generate compiling code. Use `.value` instead of `toString().split('.').last` in filters.
- User-defined types without known values (enum arrays missing from the config, domains, composite or extension types in `public`) are now generated as `String` with a warning, instead of code that does not compile.
- Nullable enum columns now read a missing value as `null` instead of the first enum value ([#164](https://github.com/mmvergara/supadart/issues/164)).
- **Breaking (library API):** `supadartRun` no longer takes the enum map; it uses `DatabaseSwagger.enums`.
- **Breaking:** errors and warnings are now written to stderr, and usage/config errors exit with code 64 (was 1).
- **Breaking:** removed the automatic fallback that retried failed TLS handshakes with certificate checks disabled, and the fallback from HTTPS to HTTP. Connections must now succeed over the URL you give.
- Generated `interval` parsing now handles Postgres' full default format (e.g. `1 year 2 mons -3 days +04:05:06.5`) instead of only `HH:MM:SS`.
- Generated `converter` / `converterSingle` now have explicit return types; generated files no longer trigger `constant_identifier_names` lints.
- Columns mapped to `dynamic` are no longer emitted as the redundant `dynamic?`.
- Warns when a publishable/anon key is used, and explains 401/403 responses from the schema endpoint (a secret key is required).
- Invalid CLI flags now print a clear message instead of a stack trace.
- Package moved to the repository root; added a full test suite (unit, golden, compile and integration tests against a local Supabase).

## 1.9.3

- Support more integer types thanks to @anasmohammed361
- Added a user-facing note when Swagger fetch fails with 401: Supabase now requires an API key service/secret key to load the OpenAPI schema at `/rest/v1/`

## 1.9.2

- New jsonb configuration option in supadart.yaml thanks to @tmillian
- Bugfix/geospacial thanks to @anasmohammed361

## 1.9.0

- Support with new supabase api keys
- Thanks to @renesass

## 1.8.4

- Add jsonbToDynamic option to override the default jsonb mapping to dynamic

## 1.8.3

- Fix fromJson Geometry default null type handling

## 1.8.2

- Fix import statement for PostGIS geometry and geography
- Thanks to @momingse

## 1.8.1

- Add support for PostGIS geometry and geography thanks to @ih57452

## 1.8.0

- Fallback all types to String or String[] if not supported
- Should not set default value to "0" in fromJson when the field is a nullable foreign key
- disabled default values test
- Support null values for copyWith

## 1.7.2

- Add support for vector types and create embeddings table

## 1.7.1

- Update Dependencies
- Clarify Case Sensitivity on Enum Values (supadart.yaml)
- Improve error messages on missing supadart.yaml file
- Add deprecation note on the web app

## 1.7.0

- Revert changes on upperCasing generated enum values (postgres enums are case-sensitive)

## 1.6.9

- Enum `names` are converted to `UPPERCASE` to follow dart enum naming conventions
- Enum `values` are converted to `LOWERCASE` to follow dart enum naming conventions
- Update supadart.yaml documentation for enums

## 1.6.8

- Add "New" method to generated classes

## 1.6.7

- Fix enum array generation

## 1.6.6

- Yaml config is now required (default: ./supadart.yaml)
- Enums are now required to be in the yaml config
- Add support to array enums
- Changed yaml_config supabase credentials to uppercase SUPABASE_URL, SUPABASE_ANON_KEY
- Add .env support for supabase credentials SUPABASE_URL, SUPABASE_ANON_KEY

## 1.6.5

- Fix typo
- Update dependencies

## 1.6.4

- Fix nullable fields in class attributes and insert method

## 1.6.3

- Add storage client extension generator thanks to @bookshiyi
- Update dependencies

## 1.6.2

- Add -e --exclude option to exclude methods from generated classes
- Add copyWith method thanks to @bookshiyi

## 1.6.1

- Add Postgres Interval type support => Duration in Dart
- Refactor import structure to allow easier function creations
- Add interval test and interval array test

## 1.6.0

- Add local development mode generation support

## 1.5.9

- Fix FromJson and toJson methods comptaibility with conversions
- Add fromJson to toJson tests for EACH data types
- Add Big Serial Array Test

## 1.5.8

- Fix Boolean values encoding
- New Private Generate Map Method to simplify crud methods

## 1.5.7

- Fix toJson serialization
- Fix num parsing fromJson method

## 1.5.6

- Usage of .parse instead of .tryParse in nums and in other types

## 1.5.5

- Improve performance by using String Buffer instead of String concatenation
- Restructure Generators to be more modular and maintainable

## 1.5.4

- Add toJson method to generated models

## 1.5.3

- Changed model fields to be camel casing

## 1.5.2

- Fix extra " generated on enum values

## 1.5.1

- initiate 2nd Swagger Request without the apikey if the first request fails

## 1.5.0

- Support for enum types

## 1.4.2

- Fix Default Project Type config

## 1.4.1

- Update CLI print feedback
- Update README

## 1.4.0

- Support customize table to model class mappings
- added `--init` option to generate a `supadart.yaml` config file

## 1.3.8

- Fix Crash when using the tool with views table

## 1.3.7

- Fix Json Array and DateTime parsing

## 1.3.6

- Switched Generators from API to just local generation

## 1.3.5

- improved abstract class import for `--separated` option

## 1.3.4

- fixed `--separated` option to include supadart_abstract_class.dart file import

## 1.3.3

- changed api base url to `https://supadart.vercel.app/api/generate/`

## 1.3.2

- refactor -o --output help text

## 1.3.1

- fix api link

## 1.3.0

- Added support for separated class files generation

## 1.2.1

- Add recursive file generation

## 1.2.0

- Added `--version` option and -d for dart class version only instead of flutter version

## 1.1.0

- Added cmd options

## 1.0.5

- Readme Installation Update

## 1.0.4

- Success Log Feedback

## 1.0.3

- Fix API url. Goodness 🥹

## 1.0.2

- Fix API url

## 1.0.1

- Fix add executable

## 1.0.0

- Initial version.
