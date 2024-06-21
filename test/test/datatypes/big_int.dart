import 'package:supabase/supabase.dart';
import 'package:supadart_test/generated_classes.dart';

Future<Object?> createBigInt(SupabaseClient supabase) async {
  try {
    BigInt value = BigInt.from(4221312931259329921);
    await supabase.all_types.insert(All_types.insert(
      bigintx: value,
      // bigserialx: value,
      smallserialx: 0,
      serialx: 0,
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
        .eq("bigintx", oldValue);
    return null;
  } catch (error) {
    print("updateBigInt error");
    print(error);
    return error;
  }
}
