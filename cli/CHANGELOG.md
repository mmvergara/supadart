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
