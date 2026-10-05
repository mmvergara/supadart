import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import 'models/generated_classes.dart';
import 'utils.dart';

/// Rows created with only an id: every nullable column must come back null
/// (toJson drops nulls, so the whole row serializes to just the id), and
/// columns with a database default must come back with that default.
Future<void> performDefaultValuesTest(SupabaseClient supabase) async {
  _expectAllNull(
      supabase, supabase.numeric_types, NumericTypes.fromJson, 'numeric_types');
  _expectAllNull(
      supabase, supabase.string_types, StringTypes.fromJson, 'string_types');
  _expectAllNull(supabase, supabase.datetime_types, DatetimeTypes.fromJson,
      'datetime_types');
  _expectAllNull(supabase, supabase.boolean_bit_types, BooleanBitTypes.fromJson,
      'boolean_bit_types');
  _expectAllNull(
      supabase, supabase.json_types, JsonTypes.fromJson, 'json_types');
  _expectAllNull(supabase, supabase.geometric_types, GeometricTypes.fromJson,
      'geometric_types');
  _expectAllNull(
      supabase, supabase.network_types, NetworkTypes.fromJson, 'network_types');
  _expectAllNull(supabase, supabase.binary_xml_types, BinaryXmlTypes.fromJson,
      'binary_xml_types');
  _expectAllNull(
      supabase, supabase.misc_types, MiscTypes.fromJson, 'misc_types');

  test('profiles: database defaults are read back', () async {
    await cleanup(supabase, supabase.profiles);
    // user_groups has a default, but PostgREST does not report defaults on
    // array columns, so Profiles.insert requires it. Insert raw instead.
    await supabase.profiles.insert({'first_name': 'Ada'});

    final row = await supabase.profiles
        .select()
        .eq(Profiles.c_firstName, 'Ada')
        .single()
        .withConverter(Profiles.converterSingle);
    expect(row.userGroups, [USERGROUP.USERS]);
    expect(row.id, hasLength(36), reason: 'uuid_generate_v4() default');
    expect(row.lastName, isNull);
  });
}

void _expectAllNull<T>(
  SupabaseClient supabase,
  SupabaseQueryBuilder table,
  T Function(Map<String, dynamic>) fromJson,
  String tableName,
) {
  test('$tableName: unset columns are read back as null', () async {
    await cleanup(supabase, table);
    await table.insert({'id': uuidx});

    final data = await table.select().eq('id', uuidx).single();
    final row = fromJson(data) as dynamic;
    expect(row.toJson(), {'id': uuidx});
  });
}
