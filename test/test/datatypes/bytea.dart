// import 'package:supabase/supabase.dart';
// import 'package:test/test.dart';
// import '../utils.dart';
// import 'package:supadart_test/generated_classes.dart'; // Adjust the path as needed

// Future<void> performByteaTest(SupabaseClient supabase) async {
//   // Test values for bytea
//   String insertBytea = "1234";
//   String updatedBytea = "5678";

//   // Tests for bytea
//   test('Testing Bytea Create', () async {
//     await cleanup(supabase);
//     var createResult = await createBytea(supabase, insertBytea);
//     expect(createResult, null);
//   });

//   test('Testing Bytea Update', () async {
//     var updateResult = await updateBytea(supabase, insertBytea, updatedBytea);
//     expect(updateResult, null);
//   });

//   test('Testing Bytea Read', () async {
//     var readResult = await readBytea(supabase);
//     print(readResult);
//     print(readResult);
//     print(readResult);
//     assert(readResult is List<Test_table>);
//     expect(readResult!.length, 1);
//     expect(readResult[0].byteax, updatedBytea);
//   });
// }

// Future<Object?> createBytea(SupabaseClient supabase, String insertVal) async {
//   try {
//     await supabase.from('test_table').insert(Test_table.insert(
//           byteax: insertVal,
//         ));
//     return null;
//   } catch (error) {
//     return error;
//   }
// }

// Future<Object?> updateBytea(
//     SupabaseClient supabase, String oldValue, String value) async {
//   try {
//     await supabase
//         .from('test_table')
//         .update(Test_table.update(byteax: value))
//         .eq('byteax', oldValue);
//     return null;
//   } catch (error) {
//     print("updateBytea error");
//     print(error);
//     return error;
//   }
// }

// Future<List<Test_table>?> readBytea(SupabaseClient supabase) async {
//   try {
//     var res = await supabase.from('test_table').select().withConverter(
//         (data) => data.map((e) => Test_table.fromJson(e)).toList());
//     return res;
//   } catch (error) {
//     print("readBytea error");
//     print(error);
//     return null;
//   }
// }
