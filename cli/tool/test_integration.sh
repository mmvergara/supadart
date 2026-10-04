#!/usr/bin/env bash
# Runs the full test suite against a local Supabase instance.
#
#   tool/test_integration.sh            start Supabase if needed, reset DB, run all tests
#   tool/test_integration.sh --update   same, but first refresh fixtures and goldens
#
# Uses the project in ../supabase (its own project_id and ports), so it never
# touches other local Supabase instances. Set SUPABASE_CLI to override the
# command used to invoke the Supabase CLI (default: `supabase`, else `npx supabase`).
set -euo pipefail

cli_dir="$(cd "$(dirname "$0")/.." && pwd)"
repo_dir="$(cd "$cli_dir/.." && pwd)"

if [[ -n "${SUPABASE_CLI:-}" ]]; then
  read -r -a supabase <<<"$SUPABASE_CLI"
elif command -v supabase >/dev/null; then
  supabase=(supabase)
else
  supabase=(npx -y supabase)
fi

cd "$repo_dir"
if ! "${supabase[@]}" status >/dev/null 2>&1; then
  "${supabase[@]}" start
fi
"${supabase[@]}" db reset

# Exports API_URL, SECRET_KEY, etc. for this project only.
eval "$("${supabase[@]}" status -o env)"
export SUPABASE_URL="$API_URL"
export SUPABASE_API_KEY="$SECRET_KEY"

cd "$cli_dir"
dart pub get >/dev/null
if [[ "${1:-}" == "--update" ]]; then
  dart run tool/update_fixtures.dart
fi
dart test
