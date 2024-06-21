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
    assert(readResult is List<All_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].bitvaryingx, updatedBitVarying);
  });
}

Future<Object?> createBitVarying(
    SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.all_types.insert(All_types.insert(
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
    await supabase.all_types
        .update(All_types.update(bitvaryingx: value))
        .eq(All_types.c_bitvaryingx, oldValue);
    return null;
  } catch (error) {
    print("updateBitVarying error");
    print(error);
    return error;
  }
}

Future<List<All_types>?> readBitVarying(SupabaseClient supabase) async {
  try {
    var res = await supabase.all_types
        .select()
        .withConverter((data) => data.map(All_types.fromJson).toList());
    return res;
  } catch (error) {
    print("readBitVarying error");
    print(error);
    return null;
  }
}
