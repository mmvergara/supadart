import 'package:supabase/supabase.dart';
import 'package:dotenv/dotenv.dart';
import 'dart:io';

import '../test/datatypes/big_int.dart';

void main(List<String> arguments) {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    exit(1);
  }

  final supabase = SupabaseClient(url, anonKey);
  createBigInt(supabase);
}
