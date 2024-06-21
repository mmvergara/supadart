import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'datatypes/big_int.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  String? url = env['SUPABASE_URL'];
  String? anonKey = env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    print('Please provide SUPABASE_URL and SUPABASE_ANON_KEY in .env file');
    return;
  }

  final supabase = SupabaseClient(url, anonKey);

  // Cleanup
  try {
    await supabase.all_types.delete().neq("bigintx", "0");
  } catch (err) {
    print("Error cleaning up");
    print(err);
  }
  // =================================================================
  // =================================================================
  // Note: For all of the the "INSERT" test we are providing the
  // serial types with 0 as by default they are not nullable.
  // or maybe i just don't know postgresql well enough.
  //
  // The Supabase API also that we are using marked them as required
  // =================================================================
  // =================================================================

  test('Testing BigInt Create,Update,Read', () async {
    // Create
    BigInt val = BigInt.from(4221312931259329921);
    var createResult = await createBigInt(supabase);
    expect(createResult, null);

    // Update
    BigInt updatedVal = BigInt.from(4221312931259329821);
    var updateResult = await updateBigInt(supabase, val, updatedVal);
    expect(updateResult, null);

    // Read
    var readResult = await readBigInt(supabase);
    assert(readResult is List<All_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].bigintx, updatedVal);
  });
}
