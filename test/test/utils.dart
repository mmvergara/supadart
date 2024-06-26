import 'package:supabase/supabase.dart';

Future<void> cleanup(
    SupabaseClient supabase, SupabaseQueryBuilder supabaseTable) async {
  try {
    await supabaseTable
        .delete()
        .neq("id", "00c92d92-940e-42dd-0000-98c3e0ad6ff4");
  } catch (err) {
    print("Error cleaning up");
    print(err);
  }
}

const String uuidx = "00c92d92-940e-42dd-a401-98c3e0ad6ff4";
const String uuidy = "00c92d92-940e-42dd-a401-98c3e0ad6ff5";
const String uuidz = "00c92d92-940e-42dd-a401-98c3e0ad6ff6";
