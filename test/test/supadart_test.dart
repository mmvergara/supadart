import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'datatypes/big_int.dart';

import 'datatypes/big_serial.dart';
import 'datatypes/bit.dart';
import 'datatypes/bit_varying.dart';
import 'datatypes/box.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }

  final supabase = SupabaseClient(url, anonKey);

  // await performBigIntTest(supabase);
  // await performBigSerialTests(supabase);
  // await performBitTest(supabase);
  // await performBitVaryingTest(supabase);
  await performBoxTest(supabase);
}
