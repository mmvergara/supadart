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
dart compile exe bin/supadart.dart ; ./bin/supadart.exe --url <supabase_url> --key <supabase_anon_key>
```

### Testing

Keep in mind that we are testing for runtime only especially data integrity and not the actual supabase querying functionality.

Fill up the `.env`, tests use the `.env` for the supabase url and key.

```env
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

```bash
dart run test
```
