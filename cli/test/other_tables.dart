import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import 'models/generated_classes.dart';
import 'utils.dart';

Future<void> performOtherTablesTest(SupabaseClient supabase) async {
  group('profiles (enum array, no primary key)', () {
    test('insert, update and read', () async {
      await cleanup(supabase, supabase.profiles);
      await supabase.profiles.insert(Profiles.insert(
        id: uuidx,
        firstName: 'Ada',
        userGroups: [USERGROUP.ADMIN, USERGROUP.MODERATOR],
      ));
      await supabase.profiles
          .update(Profiles.update(lastName: 'Lovelace'))
          .eq(Profiles.c_id, uuidx);

      final row = await supabase.profiles
          .select()
          .eq(Profiles.c_id, uuidx)
          .single()
          .withConverter(Profiles.converterSingle);
      expect(row.firstName, 'Ada');
      expect(row.lastName, 'Lovelace');
      expect(row.userGroups, [USERGROUP.ADMIN, USERGROUP.MODERATOR]);
      expect(Profiles.fromJson(row.toJson()).toJson(), row.toJson());
    });
  });

  group('view', () {
    test('reads joined columns through the generated class', () async {
      await cleanup(supabase, supabase.numeric_types);
      await cleanup(supabase, supabase.string_types);
      await supabase.numeric_types.insert(
          NumericTypes.insert(id: uuidx, colInteger: 42, colDouble: 1.5));
      await supabase.string_types
          .insert(StringTypes.insert(id: uuidx, colText: 'hi', colUuid: uuidy));

      final rows = await supabase.combined_types_view
          .select()
          .withConverter(CombinedTypesView.converter);
      expect(rows, hasLength(1));
      final row = rows.single;
      expect(row.numericId, uuidx);
      expect(row.stringId, uuidx);
      expect(row.colInteger, 42);
      expect(row.colDouble, 1.5);
      expect(row.colText, 'hi');
      expect(row.colUuid, uuidy);
    });
  });
}
