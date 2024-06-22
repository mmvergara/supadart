import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'dart:io';

Future<void> cleanup(SupabaseClient supabase) async {
  try {
    await supabase.test_table.delete().eq(Test_table.c_cleanup, "1");
  } catch (err) {
    print("Error cleaning up");
    print(err);
  }
}

Future<void> changeSupabaseFlutterImportToSupabaseImport() async {
  // Define the path to the file
  final filePath = './lib/hello.dart';

  final file = File(filePath);
  if (!await file.exists()) {
    print('File does not exist.');
    return;
  }

  List<String> lines = await file.readAsLines();

  if (lines.isNotEmpty) {
    lines[0] = "import 'package:supabase/supabase.dart';";
  } else {
    lines.add("import 'package:supabase/supabase.dart';");
  }

  // Write the modified content back to the file
  await file.writeAsString(lines.join('\n'));

  print('File modified successfully.');
}
