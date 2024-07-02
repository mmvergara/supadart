# Supabase Schema to Dart Classes 🎯

Typesafe queries in Supabase Flutter! <br/>
Generate Flutter / Dart 🎯 classes from your Supabase schema.

### Features

- 🛠️ Typesafe Queries (Create, Read, Equality)
- 🧱 Immutable Generated Classes
- 📊 Supports Column Selection Queries
- 🔢 Supports all Supabase Major datatypes
- 🗂️ Supports Defined as array types
- 🌐 Cli and Web App

### Table of Contents

- [Generate Dart Classes via](#generating-dart-classes)
  - [CLI](#using-the-dart-cli)
  - [Web App](https://supabase-schema-dart-class-generator.vercel.app/)
- [Example Usage](#example-usage)

## Conversion Table

| Supabase Identifier | PostgreSQL Format           | JSON Type | Dart Type            | Runtime Tested <img src="https://github.com/mmvergara/supabase-schema-dart-class-generator/actions/workflows/dart.yml/badge.svg?branch=main%22"/> |
| ------------------- | --------------------------- | --------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| # int2              | smallint                    | integer   | int                  | type ✅ type[]✅                                                                                                                                  |
| # int4              | integer                     | integer   | int                  | type ✅ type[]✅                                                                                                                                  |
| # int8              | bigint                      | integer   | BigInt               | type ✅ type[]✅                                                                                                                                  |
| # float4            | real                        | number    | double               | type ✅ type[]✅                                                                                                                                  |
| # float8            | double precision            | number    | double               | type ✅ type[]✅                                                                                                                                  |
| # numeric           | numeric                     | number    | num                  | type ✅ type[]✅                                                                                                                                  |
| {} json             | json                        | -         | Map<String, dynamic> | type ✅ type[]✅                                                                                                                                  |
| {} jsonb            | jsonb                       | -         | Map<String, dynamic> | type ✅ type[]✅                                                                                                                                  |
| T text              | text                        | string    | String               | type ✅ type[]✅                                                                                                                                  |
| T varchar           | character varying           | string    | String               | type ✅ type[]✅                                                                                                                                  |
| T uuid              | uuid                        | string    | String               | type ✅ type[]✅                                                                                                                                  |
| 🗓️ date             | date                        | string    | DateTime             | type ✅ type[]✅                                                                                                                                  |
| 🗓️ time             | time without time zone      | string    | DateTime             | type ✅ type[]✅                                                                                                                                  |
| 🗓️ timetz           | time with time zone         | string    | DateTime             | type ✅ type[]✅                                                                                                                                  |
| 🗓️ timestamp        | timestamp without time zone | string    | DateTime             | type ✅ type[]✅                                                                                                                                  |
| 🗓️ timestamptz      | timestamp with time zone    | string    | DateTime             | type ✅ type[]✅                                                                                                                                  |
| 💡 bool             | boolean                     | boolean   | bool                 | type ✅ type[]✅                                                                                                                                  |

> [Other Types](https://github.com/mmvergara/supabase-schema-dart-class-generator/blob/main/other-types.md)

# Generating Dart Classes

## 1. Pre-requisites

#### if you have serial types you need to add a comment to the column like this,

serial types in general are not available in supabase table editor afaik, so if you did not add them manually via sql editor you probably dont have them.

```sql
COMMENT ON COLUMN test_table.bigserialx IS 'serial';
COMMENT ON COLUMN test_table.smallserialx IS 'serial';
COMMENT ON COLUMN test_table.serialx IS 'serial';
-- otherwise the insert method will always ask for a value
```

[Why do we need this?](https://gist.github.com/mmvergara/5e3d42d73dd316f8ff809fb940163c1f)

#### Install `Internationalization` package

```bash
# This is an official package from dart and is used for parsing dates
flutter pub add intl
# or
dart pub add intl
```

## 2. Generate Dart Classes

### Using the [Web App](https://supabase-schema-dart-class-generator.vercel.app/)

### Using the Dart CLI

#### Installation

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

#### Generate Classes

```bash
# If you have a .env file with SUPABASE_URL and SUPABASE_ANON_KEY in the root of your project
supadart

# If you have a .env file in a different location
supadart -e path/to/.env

# If you dont have a .env file specify the Supabase URL and ANON KEY
supadart -u <your-supabase-url> -k <your-supabase-anon-key>
```

> Note: If you are not using Flutter, just normal Dart project, add `-d` option

#### Options

```bash
-h, --help         Show usage information
-e, --env-path     Path to the .env file -- (default: .env)
-u, --url          Supabase URL          -- (default: .env SUPABASE_URL)
-k, --key          Supabase ANON KEY     -- (default: .env SUPABASE_ANON_KEY)
-o, --output       Output file path      -- (default: "lib/generated_classes.dart" or "lib/models/" if --seperated is enabled)
-d, --dart         Enable if you are not using Flutter, just normal Dart project
-s, --seperated    Generate Seperate files for each classes
-v, --version      v1.3.2
```

---

# Example Usage

Assuming the following table schema

```sql
create table
  public.books (
    id bigint generated by default as identity,
    name character varying not null,
    description text null,
    price integer not null,
    created_at timestamp with time zone not null default now(),
    constraint books_pkey primary key (id)
  ) tablespace pg_default;
```

### 1. Use the CLI or the Web App to [generate dart classes](#generating-dart-classes)

```dart
class Books {
  final BigInt id;
  final String name;
  final String? description;
  final int price;
  final DateTime created_at;

  const Books({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.created_at,
  });

  static String get table_name => 'books';
  static String get c_id => 'id';
  static String get c_name => 'name';
  static String get c_description => 'description';
  static String get c_price => 'price';
  static String get c_created_at => 'created_at';
  static Map<String, dynamic> insert({
    BigInt? id,
    required String name,
    String? description,
    required int price,
    DateTime? created_at,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      'name': name.toString(),
      if (description != null) 'description': description.toString(),
      'price': price.toString(),
      if (created_at != null) 'created_at': created_at.toUtc().toString(),
    };
  }

  static Map<String, dynamic> update({
    BigInt? id,
    String? name,
    String? description,
    int? price,
    DateTime? created_at,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (name != null) 'name': name.toString(),
      if (description != null) 'description': description.toString(),
      if (price != null) 'price': price.toString(),
      if (created_at != null) 'created_at': created_at.toUtc().toString(),
    };
  }

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: BigInt.parse(json['id'].toString()),
      name: json['name'] as String,
      description:
          json['description'] != null ? json['description'] as String : null,
      price: json['price'] as int,
      created_at: DateTime.parse(json['created_at'].toString()),
    );
  }
}
```

### 2. Using the generated class

we now have a typesafe'ish to interact with the database.

#### Getting Table Name

```dart
  Books.table_name // "books"
```

#### Fetch Data

```dart
// fetchedBooks is a typeof List<Books>
final books = await supabase
      .books
      .select("*")
      .withConverter((data) => data.map(Books.fromJson).toList());
```

#### Insert Data

```dart
final data = Books.insert(
  name: 'Learn Flutter',
  description: 'Endless brackets and braces',
  price: 2,
);
await supabase.books.insert(data);
```

#### Inset Many Data

```dart
final many_data = [
  Books.insert(
    name: 'Learn Minecraft',
    description: 'Endless blocks and bricks',
    price: 2,
  ),
  Books.insert(
    name: 'Description is optional',
    created_at: DateTime.now(),
    price: 2,
  ),
];
await supabase.books.insert(many_data);
```

#### Update Data

```dart
final newData = Books.update(
  name: 'New Book Name',
);
await supabase.books.update(newData).eq(Books.c_id, 1);
```

#### Delete Data

```dart
await supabase.books.delete().eq(Books.c_id, 1);
```

---
