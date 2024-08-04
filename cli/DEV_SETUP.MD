# Dev Environment Setup

### Install Dependencies

```bash
dart pub get
```

### Compile and Run

```bash
dart compile exe bin/supadart.dart ; ./bin/supadart.exe
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
