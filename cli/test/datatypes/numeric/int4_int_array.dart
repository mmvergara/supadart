import 'package:supabase/supabase.dart';
import '../../models/generated_classes.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import '../../utils.dart';

Future<void> performIntegerArrayTest(SupabaseClient supabase) async {
  // int4[] = array of four-byte signed integers
  List<int> insertInt4Array = [
    2147483647,
    0,
    -2147483648
  ]; // max, 0, and min values for int4
  List<int> updatedInt4Array = [-2147483648, 0, 2147483647]; // reversed order

  test('Testing Integer Array Create', () async {
    await cleanup(supabase, supabase.numeric_types);
    var createResult = await createIntegerArray(supabase, insertInt4Array);
    expect(createResult, null);
  });

  test('Testing Integer Array Update', () async {
    var updateResult =
        await updateIntegerArray(supabase, insertInt4Array, updatedInt4Array);
    expect(updateResult, null);
  });

  test('Testing Integer Array Read', () async {
    var readResult = await readIntegerArray(supabase);
    assert(readResult is List<NumericTypes>);
    expect(readResult!.length, 1);
    expect(readResult[0].colIntegerArray, isA<List<int>>());
    expect(readResult[0].colIntegerArray, updatedInt4Array);
  });
}

Future<Object?> createIntegerArray(
    SupabaseClient supabase, List<int> insertVal) async {
  try {
    await supabase.numeric_types.insert(NumericTypes.insert(
      colIntegerArray: insertVal,
      id: uuidx,
    ));
    return null;
  } catch (error) {
    return error;
  }
}

Future<Object?> updateIntegerArray(
    SupabaseClient supabase, List<int> oldValue, List<int> value) async {
  try {
    await supabase.numeric_types
        .update(NumericTypes.update(colIntegerArray: value))
        .eq(NumericTypes.c_id, uuidx);
    return null;
  } catch (error) {
    print("updateIntegerArray error");
    print(error);
    return error;
  }
}

Future<List<NumericTypes>?> readIntegerArray(SupabaseClient supabase) async {
  try {
    var res = await supabase.numeric_types
        .select()
        .withConverter(NumericTypes.converter);
    return res;
  } catch (error) {
    print("readIntegerArray error");
    print(error);
    return null;
  }
}
