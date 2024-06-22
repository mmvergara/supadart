import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';

Future<void> cleanup(SupabaseClient supabase) async {
  try {
    await supabase.test_table.delete().eq(Test_table.c_cleanup, "1");
  } catch (err) {
    print("Error cleaning up");
    print(err);
  }
}
