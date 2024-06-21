import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../cleanup.dart';

Future<void> performBitVaryingTest(SupabaseClient supabase) async {
  String insertBitVarying = "0";
  String updatedBitVarying = "1";
  test('Testing Bit Varying Create', () async {
    await cleanup(supabase);
    var createResult = await createBitVarying(supabase, insertBitVarying);
    expect(createResult, null);
  });

  test('Testing Bit Varying Update', () async {
    var updateResult =
        await updateBitVarying(supabase, insertBitVarying, updatedBitVarying);
    expect(updateResult, null);
  });

  test('Testing Bit Varying Read', () async {
    var readResult = await readBitVarying(supabase);
    assert(readResult is List<Test_table>);
    expect(readResult!.length, 1);
    expect(readResult[0].bitvaryingx, isA<String>());
    expect(readResult[0].bitvaryingx, updatedBitVarying);
  });
}

Future<Object?> createBitVarying(
    SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.test_table.insert(Test_table.insert(
      bitvaryingx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateBitVarying(
    SupabaseClient supabase, String oldValue, String value) async {
  try {
    await supabase.test_table
        .update(Test_table.update(bitvaryingx: value))
        .eq(Test_table.c_bitvaryingx, oldValue);
    return null;
  } catch (error) {
    print("updateBitVarying error");
    print(error);
    return error;
  }
}

Future<List<Test_table>?> readBitVarying(SupabaseClient supabase) async {
  try {
    var res = await supabase.test_table
        .select()
        .withConverter((data) => data.map(Test_table.fromJson).toList());
    return res;
  } catch (error) {
    print("readBitVarying error");
    print(error);
    return null;
  }
}
