[![Pub Version](https://img.shields.io/pub/v/supadart)](https://pub.dev/packages/supadart)
[![Pub Points](https://img.shields.io/pub/points/supadart)](https://pub.dev/packages/supadart)
[![GitHub Stars](https://img.shields.io/github/stars/mmvergara/supadart)](https://github.com/mmvergara/supadart/stargazers)
[![Runtime Test](https://github.com/mmvergara/supadart/actions/workflows/dart.yml/badge.svg)](https://github.com/mmvergara/supadart/actions/workflows/dart.yml)
[![GitHub License](https://img.shields.io/github/license/mmvergara/supadart)](https://github.com/mmvergara/supadart/blob/main/LICENSE)

# Supadart 🎯

Typesafe Supabase Flutter Queries <br/>
Generate Flutter / Dart 🎯 classes from your Supabase schema.

```dart
// allBooks is a typeof List<Books>
final allBooks = await supabase
      .books
      .select("*")
      .withConverter(Books.converter);
```

### Table of Contents 📚

- [**Generate Dart Classes**](#generating-dart-classes)
  - [**Pre-requisites**](#1-pre-requisites)
  - [**Generate Dart Classes**](#2-generate-dart-classes)
- [**Example Usage**](#example-usage)
  - [**Fetch Data**](#fetch-data)
  - [**Fetch Single Data**](#fetch-single-data)
  - [**Insert Data**](#insert-data)
  - [**Insert Many Data**](#inset-many-data)
  - [**Update Data**](#update-data)
  - [**Delete Data**](#delete-data)
- [**Working with Enums**](#enums-crud)
- [**Column Selection Queries**](#column-selection-queries)

### Features 🚀

- 🌐 Cli and Web App
- 🛠️ Typesafe Queries (Create, Read, Equality)
- 🧱 Immutable Generated Classes
- 🗂️ Roundtrip Serialization fromJson to toJson and back
- 📊 Supports Column Selection Queries
- 🔢 Supports all Supabase Major datatypes
- 🗂️ Supports Defined as array types
- 🗂️ Supports Enums

### Conversion Table 📊

| Supabase Identifier | PostgreSQL Format           | JSON Type | Dart Type            | Runtime Tested <img src="https://github.com/mmvergara/supadart/actions/workflows/dart.yml/badge.svg?branch=main%22"/> |
| ------------------- | --------------------------- | --------- | -------------------- | --------------------------------------------------------------------------------------------------------------------- |
| # int2              | smallint                    | integer   | int                  | type ✅ type[]✅                                                                                                      |
| # int4              | integer                     | integer   | int                  | type ✅ type[]✅                                                                                                      |
| # int8              | bigint                      | integer   | BigInt               | type ✅ type[]✅                                                                                                      |
| # float4            | real                        | number    | double               | type ✅ type[]✅                                                                                                      |
| # float8            | double precision            | number    | double               | type ✅ type[]✅                                                                                                      |
| # numeric           | numeric                     | number    | num                  | type ✅ type[]✅                                                                                                      |
| {} json             | json                        | object    | Map<String, dynamic> | type ✅ type[]✅                                                                                                      |
| {} jsonb            | jsonb                       | object    | Map<String, dynamic> | type ✅ type[]✅                                                                                                      |
| T text              | text                        | string    | String               | type ✅ type[]✅                                                                                                      |
| T varchar           | character varying           | string    | String               | type ✅ type[]✅                                                                                                      |
| T uuid              | uuid                        | string    | String               | type ✅ type[]✅                                                                                                      |
| 🗓️ date             | date                        | string    | DateTime             | type ✅ type[]✅                                                                                                      |
| 🗓️ time             | time without time zone      | string    | DateTime             | type ✅ type[]✅                                                                                                      |
| 🗓️ timetz           | time with time zone         | string    | DateTime             | type ✅ type[]✅                                                                                                      |
| 🗓️ timestamp        | timestamp without time zone | string    | DateTime             | type ✅ type[]✅                                                                                                      |
| 🗓️ timestamptz      | timestamp with time zone    | string    | DateTime             | type ✅ type[]✅                                                                                                      |
| 🕒 interval         | interval                    | string    | Duration             | type ✅ type[]✅                                                                                                      |
| 💡 bool             | boolean                     | boolean   | bool                 | type ✅ type[]✅                                                                                                      |
| 🗂️ ENUMS            | ENUM                        | string    | Enum                 | type ✅ type[]✅                                                                                                      |

> [Other Types](https://github.com/mmvergara/supadart/blob/main/other-types.md)

# Generating Dart Classes

## 1. Pre-requisites

#### 1.2 Do you have serial types?

We don't recommend using serial types when using this package, if you have serial types you need to add a `[supadart:serial]` to the column like this

> You probably don't have them Serial types aren't available in the Supabase editor and must be added via SQL editor manually.

```sql
COMMENT ON COLUMN test_table.bigserialx IS '[supadart:serial]';
COMMENT ON COLUMN test_table.smallserialx IS 'you can still add comment [supadart:serial]';
COMMENT ON COLUMN test_table.serialx IS 'this part [supadart:serial] just needs to be included';
-- otherwise the insert method will always ask for a value even though serial types are auto-generated
```

> [Why do we need this?](https://gist.github.com/mmvergara/5e3d42d73dd316f8ff809fb940163c1f)

#### 1.3 Install `Internationalization` package

```bash
# This is an official package from dart and is used for parsing dates
flutter pub add intl
# or
dart pub add intl
```

> Unless you are not using any date types, you can skip this step

#### 1.4 Use snake casing for table names and column names (Optional)

this tool will automatically convert snake_case to camelCase for both table (GeneratedClassName) and column (FieldName) generated names.

```
snake_case  => camelCase
user_table  => UserTable
```

```
snake_case  => camelCase
user_id     => userId
```

---

## 2. Generate Dart Classes

> Using the [Web App (no enum support)](https://supadart.vercel.app/)

### Using the Dart CLI (Recommended)

#### Installation

```bash
# 🎯 Active from pub.dev
dart pub global activate supadart

# 🚀 Run via
supadart
# or
dart pub global run supadart
```

#### Quick Start

```bash

# Initialize supadart.yaml config file
supadart --init

# Generate classes
supadart --url <supabase_url> --key <supabase_anon_key>

# if SUPABASE_URL and SUPABASE_ANON_KEY are set in the environment variables
# if SUPABASE_URL and SUPABASE_ANON_KEY are set in supadart.yaml
supadart
```

If you have enums, you need to specify them in the config file

````yaml
#### CLI Usage

```bash
-h, --help       Show usage information
-i, --init       Initialize config file supadart.yaml
-c, --config     Specify a path to config file of yaml   (default: ./supadart.yaml)
-u, --url        Supabase URL                            (if not set in yaml)
-k, --key        Supabase ANON KEY                       (if not set in yaml)
-v, --version
````

---

# Example Usage

Assuming the following table schema <br/>

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
class Books implements SupadartClass<Books> {
  final BigInt id;
  final String name;
  final String? description;
  final int price;
  final DateTime? createdAt;

  const Books({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.createdAt,
  });

  static String get table_name => 'books';
  static String get c_id => 'id';
  static String get c_name => 'name';
  static String get c_description => 'description';
  static String get c_price => 'price';
  static String get c_createdAt => 'created_at';

  static List<Books> converter(List<Map<String, dynamic>> data) {
    return data.map(Books.fromJson).toList();
  }

  static Books converterSingle(Map<String, dynamic> data) {
    return Books.fromJson(data);
  }

  static Map<String, dynamic> _generateMap({
    BigInt? id,
    String? name,
    String? description,
    int? price,
    DateTime? createdAt,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (name != null) 'name': name.toString(),
      if (description != null) 'description': description.toString(),
      if (price != null) 'price': price.toString(),
      if (createdAt != null) 'created_at': createdAt.toUtc().toString(),
    };
  }

  static Map<String, dynamic> insert({
    BigInt? id,
    required String name,
    String? description,
    required int price,
    DateTime? createdAt,
  }) {
    return _generateMap(
      id: id,
      name: name,
      description: description,
      price: price,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> update({
    BigInt? id,
    String? name,
    String? description,
    int? price,
    DateTime? createdAt,
  }) {
    return _generateMap(
      id: id,
      name: name,
      description: description,
      price: price,
      createdAt: createdAt,
    );
  }

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id'] != null
          ? BigInt.parse(json['id'].toString())
          : BigInt.from(0),
      name: json['name'] != null ? json['name'].toString() : '',
      description:
          json['description'] != null ? json['description'].toString() : '',
      price: json['price'] != null ? json['price'] as int : 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) as DateTime
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() {
    // Promotion doesn't work well with public fields due to the possibility of the field being modified elsewhere.
    return _generateMap(
      id: id,
      name: name,
      description: description,
      price: price,
      createdAt: createdAt,
    );
  }
}
```

### 2. Using the generated class

we now have a typesafe'ish to interact with the database.

#### Fetch Data

```dart
// allBooks is a typeof List<Books>
final allBooks = await supabase
      .books
      .select("*")
      .withConverter(Books.converter);
```

#### Fetch Single Data

```dart
// book is a typeof Books
final book = await supabase
      .books
      .select("*")
      .eq(Books.c_id, 1)
      .single()
      .withConverter(Books.converterSingle);
```

#### Insert Data

```dart
// Yes we know which one's are optional or required.
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

# Working with Enums

**IMPORTANT:**

- You need to specify your enums on supadart.yaml config file
- Enum `names` are converted to `UPPERCASE` to follow dart enum naming conventions
- Optional: We recommend defining the enum values as lowercase to follow dart enum naming conventions

Assuming the following schema

```sql
-- We recommend defining the enum values as lowercase to follow dart enum naming conventions
CREATE TYPE mood AS ENUM ('happy', 'sad', 'neutral', 'excited', 'angry');
CREATE TABLE enum_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mood mood NOT NULL
);
```

In the supadart.yaml you need to specify the enums

```yaml
enums:
  mood: [happy, sad, neutral, excited, angry]
```

### Generated Enum Class

```dart
enum MOOD { happy, sad, neutral, excited, angry }
```

### Create / Read / Update with Enums

```dart
MOOD firstEnumVal = MOOD.angry;
MOOD newEnumVal = MOOD.excited;

// Create
await supabase.enum_types.insert(EnumTypes.insert(
      mood: firstEnumVal,
    ));

await supabase.enum_types
        // Update
        .update(EnumTypes.update(mood: newEnumVal))
        // Equality ⚠️ you need to do manual ⬇️ enum to string conversion
        .eq(EnumTypes.c_mood, firstEnumVal.toString().split(".").last);

// Read
await supabase.enum_types.select().withConverter(EnumTypes.converter);
```

# Column Selection Queries

**IMPORTANT:**

- When you select columns, the class will fill the missing columns with the default values

```dart
final book = await supabase
      .from('books')
      .select('${Books.c_id}, ${Books.c_name}')
      .eq(Books.c_id, 69) // Assuming 69 is the id
      .single()
      .withConverter(Books.converterSingle);
```

```dart
print(book.id);           // 69
print(book.name);         // "Supadart"
print(book.description);  // ""
print(book.price);        // 0
print(book.created_at);   // 1970-01-01 00:00:00.000
```

if a value is an enum, the first value of that enum will be used as the default value

# Contributors

[![GitHub contributors](https://contrib.rocks/image?repo=mmvergara/supadart)](https://github.com/mmvergara/supadart/graphs/contributors)
