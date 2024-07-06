import 'package:supabase/supabase.dart';
import 'datatypes/datetime/date.dart';
import 'datatypes/datetime/date_array.dart';
import 'datatypes/datetime/time.dart';
import 'datatypes/datetime/time_array.dart';
import 'datatypes/datetime/timestamp.dart';
import 'datatypes/datetime/timestamp_array.dart';
import 'datatypes/datetime/timestamptz.dart';
import 'datatypes/datetime/timestamptz_array.dart';
import 'datatypes/datetime/timetz.dart';
import 'datatypes/datetime/timetz_array.dart';

Future<void> performDatetimeTypesTest(SupabaseClient supabase) async {
  // Datetime Types
  // STES = Supabase Table Editor Supported (PRIORITIZED)

  await performDateTest(supabase);
  await performDateArrayTest(supabase);

  await performTimeTest(supabase);
  await performTimeArrayTest(supabase);

  await performTimeTzTest(supabase);
  await performTimeTzArrayTest(supabase);

  await performTimestampTest(supabase);
  await performTimestampArrayTest(supabase);

  await performTimestamptzTest(supabase);
  await performTimestamptzArrayTest(supabase);

  // Other Datetime Types
}
