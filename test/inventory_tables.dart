import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import 'models/generated_classes.dart';
import 'utils.dart';

/// Tables in the `inventory` schema, generated alongside `public`.
Future<void> performInventoryTablesTest(SupabaseClient supabase) async {
  group('inventory schema', () {
    test('getters query the inventory schema', () async {
      await cleanup(supabase, supabase.inventory_profiles);
      await supabase.inventory_profiles
          .insert(InventoryProfiles.insert(id: uuidx, displayName: 'Depot'));

      final row = await supabase.inventory_profiles
          .select()
          .eq(InventoryProfiles.c_id, uuidx)
          .single()
          .withConverter(InventoryProfiles.converterSingle);
      expect(row.displayName, 'Depot');

      // public.profiles has no display_name: the row went to inventory.
      final viaSchemaName = await supabase
          .schema(InventoryProfiles.schema_name)
          .from(InventoryProfiles.table_name)
          .select()
          .eq(InventoryProfiles.c_id, uuidx);
      expect(viaSchemaName, hasLength(1));
    });

    test('round-trips enums from both schemas', () async {
      await supabase.inventory_items.delete().gte(InventoryItems.c_id, 0);
      final inserted = await supabase.inventory_items
          .insert(InventoryItems.insert(
            name: 'Widget',
            statusHistory: [
              INVENTORY_ITEM_STATUS.backordered,
              INVENTORY_ITEM_STATUS.in_stock,
            ],
            ownerMood: MOOD.happy,
            warehouseMood: INVENTORY_MOOD.busy,
            attributes: {'color': 'red'},
          ))
          .select()
          .single()
          .withConverter(InventoryItems.converterSingle);
      expect(inserted.status, INVENTORY_ITEM_STATUS.in_stock);

      await supabase.inventory_items
          .update(
              InventoryItems.update(status: INVENTORY_ITEM_STATUS.discontinued))
          .eq(InventoryItems.c_id, inserted.id.toString());

      final row = await supabase.inventory_items
          .select()
          .eq(InventoryItems.c_id, inserted.id.toString())
          .single()
          .withConverter(InventoryItems.converterSingle);
      expect(row.name, 'Widget');
      expect(row.status, INVENTORY_ITEM_STATUS.discontinued);
      expect(row.statusHistory, [
        INVENTORY_ITEM_STATUS.backordered,
        INVENTORY_ITEM_STATUS.in_stock,
      ]);
      expect(row.ownerMood, MOOD.happy);
      expect(row.warehouseMood, INVENTORY_MOOD.busy);
      expect(row.attributes, {'color': 'red'});
      expect(InventoryItems.fromJson(row.toJson()).toJson(), row.toJson());
    });
  });
}
