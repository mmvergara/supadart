// import 'package:supabase/supabase.dart';
// import 'package:supadart_test/generated_classes.dart'; // Assuming this imports All_types class

// // Function to create a new row with bigserial value (auto-increment)
// Future<Object?> createBigserial(SupabaseClient supabase) async {
//   try {
//     // No value needs to be explicitly set for bigserial as it auto-increments
//     final response = await supabase.all_types.insert(All_types.insert());
//     return response; // You might want to return the inserted data (ID)
//   } catch (error) {
//     return error;
//   }
// }

// // Function to read all rows with bigserial values
// Future<List<All_types>?> readBigserial(SupabaseClient supabase) async {
//   try {
//     final result = await supabase.all_types.select().execute();
//     if (result.error != null) {
//       throw result.error!; // Re-throw the Supabase error
//     }
//     final data = result.data as List;
//     return data.map((item) => All_types.fromJson(item)).toList();
//   } catch (error) {
//     print("readBigserial error");
//     print(error);
//     return null;
//   }
// }

// // Function to update a row based on the existing bigserial value (assuming it's the primary key)
// Future<Object?> updateBigserial(
//     SupabaseClient supabase, All_types existingData) async {
//   try {
//     // Update other fields as needed (excluding bigserialx)
//     final updateData = existingData
//         .copyWith(); // Create a copy to avoid modifying original data
//     updateData.bigintx =
//         BigInt.from(100); // Replace with your desired update value

//     final response = await supabase.all_types.update(updateData.update()).eq(
//         'bigserialx',
//         existingData.bigserialx); // Use existing bigserialx as the filter
//     return response; // You might want to return the updated data
//   } catch (error) {
//     print("updateBigserial error");
//     print(error);
//     return error;
//   }
// }
