import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../cleanup.dart';

Future<void> performBitTest(SupabaseClient supabase) async {
  String insertBit = "0";
  String updatedBit = "1";
  test('Testing Bit Create', () async {
    await cleanup(supabase);
    var createResult = await createBit(supabase, insertBit);
    expect(createResult, null);
  });

  test('Testing Bit Update', () async {
    var updateResult = await updateBit(supabase, insertBit, updatedBit);
    expect(updateResult, null);
  });

  test('Testing Bit Read', () async {
    var readResult = await readBit(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].bitx, isA<String>());
    expect(readResult[0].bitx, updatedBit);
  });
}

Future<Object?> createBit(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      bitx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<Test_table>?> readBit(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readBit error");
    print(error);
    return null;
  }
}

Future<Object?> updateBit(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(bitx: value))
        .eq(Test_table.c_bitx, oldValue);
    return null;
  } catch (error) {
    print("updateBit error");
    print(error);
    return error;
  }
}
