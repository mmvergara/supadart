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
    assert(readResult is List<All_types>);
    expect(readResult!.length, 1);
    expect(readResult[0].bitx, updatedBit);
  });
}

Future<Object?> createBit(SupabaseClient supabase, String insertVal) async {
  try {
    await supabase.all_types.insert(All_types.insert(
      bitx: insertVal,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<List<All_types>?> readBit(SupabaseClient supabase) async {
  try {
    var res = await supabase.all_types
        .select()
        .withConverter((data) => data.map(All_types.fromJson).toList());
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
    await supabase.all_types
        .update(All_types.update(bitx: value))
        .eq(All_types.c_bitx, oldValue);
    return null;
  } catch (error) {
    print("updateBit error");
    print(error);
    return error;
  }
}
