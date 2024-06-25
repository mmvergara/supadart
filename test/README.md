# Get Started on Testing Environment

### 1. Install Dart Dependencies

```bash
pub get
```

### 2. Setup Supabase project and use the seed.sql file to create the tables

### 3. Fill up ENV variables

```bash
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

### 4. Generate Dart Classes using the CLI

```bash
dart pub global run supadart -d
# or
supadart -d
# D tag is for dart class and not for flutter/dart class
```

### 5. Run the tests

```bash
dart test
```
