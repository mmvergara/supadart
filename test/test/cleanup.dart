import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';

Future<void> cleanup(SupabaseClient supabase) async {
  try {
    await supabase.all_types.delete().eq(All_types.c_cleanup, "1");
  } catch (err) {
    print("Error cleaning up");
    print(err);
  }
}
