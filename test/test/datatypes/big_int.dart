import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../cleanup.dart';

Future<void> performBigIntTest(SupabaseClient supabase) async {
  BigInt insertBigInt = BigInt.from(4221312931259329921);
  BigInt updatedBigInt = BigInt.from(4221312931259329821);
  test('Testing BigInt Create', () async {
    await cleanup(supabase);
    var createResult = await createBigInt(supabase, insertBigInt);
    expect(createResult, null);
  });

  test('Testing BigInt Update', () async {
    var updateResult =
        await updateBigInt(supabase, insertBigInt, updatedBigInt);
    expect(updateResult, null);
  });

  test('Testing BigInt Read', () async {
    var readResult = await readBigInt(supabase);
    assert(readResult is List<All_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].bigintx, updatedBigInt);
  });
}

Future<Object?> createBigInt(SupabaseClient supabase, BigInt insertVal) async {
  try {
    await supabase.all_types.insert(All_types.insert(
      bigintx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<All_types>?> readBigInt(SupabaseClient supabase) async {
  try {
    var res = await supabase.all_types
        .select()
        .withConverter((data) => data.map(All_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readBigInt error");
    print(error);
    return null;
  }
}

Future<Object?> updateBigInt(
    SupabaseClient supabase, BigInt oldValue, BigInt value) async {
  try {
    await supabase.all_types
        .update(All_types.update(bigintx: value))
        .eq(All_types.c_bigintx, oldValue);
    return null;
  } catch (error) {
    print("updateBigInt error");
    print(error);
    return error;
  }
}
