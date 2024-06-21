import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performBigSerialTests(SupabaseClient supabase) async {
  BigInt insertBigSerial = BigInt.from(4221312931259329921);
  BigInt updatedBigSerial = BigInt.from(4221312931259329821);
  test('Testing BigSerial Create', () async {
    await cleanup(supabase);
    var createResult = await createBigSerial(supabase, insertBigSerial);
    expect(createResult, null);
  });

  test('Testing BigSerial Update', () async {
    var updateResult =
        await updateBigSerial(supabase, insertBigSerial, updatedBigSerial);
    expect(updateResult, null);
  });

  test('Testing BigSerial Read', () async {
    var readResult = await readBigSerial(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].bigserialx, isA<BigInt>());
    expect(readResult[0].bigserialx, updatedBigSerial);
  });
}

Future<Object?> createBigSerial(
    SupabaseClient supabase, BigInt insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      bigserialx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readBigSerial(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readBigSerial error");
    print(error);
    return null;
  }
}

Future<Object?> updateBigSerial(
    SupabaseClient supabase, BigInt oldValue, BigInt value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(bigserialx: value))
        .eq(Test_table.c_bigserialx, oldValue);
    return null;
  } catch (error) {
    print("updateBigSerial error");
    print(error);
    return error;
  }
}
