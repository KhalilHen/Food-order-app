import '../core/utils/utils.dart';

import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/models/menu_item_option_group.dart';
import 'package:hf_customer_app/models/menu_item_options.dart';

class MenuItemController {
  // !! Original
  Stream<List<MenuItem>> fetchMenuItems(categoryId) {
    final response = supabase
        .from('menu_item')
        .stream(primaryKey: ['id'])
        .eq('category_id', categoryId)
        .order('name', ascending: true);

    return response.map((data) {
      return data
          .map((row) => MenuItem.fromJson(row))
          .where(
            (menuItemData) => menuItemData.isActive && menuItemData.isAvailable,
          )
          .toList();
    });
  }

  //? This fetches the different groups inside a menu item. e.g (Toppings, sizes, sauces, extra's)
  //!! Currently not used
  // TODO  wrap this into a Result
  Future<List<MenuItemOptionGroup>> fetchMenuItemGroup(menuItem) async {
    try {
      final response = await supabase
          .from('menu_item_option_group')
          .select('*')
          .eq('menu_item_id', menuItem)
          .order('display_order', ascending: true);

      if (response.isEmpty) {
        return [];
      }

      return response.map<MenuItemOptionGroup>((menuGroupData) {
        return MenuItemOptionGroup.fromJson(menuGroupData);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // TODO Change this in future into a Result
  //!! Currently not used
  Future<List<MenuItemOptions>> fetchMenuOptions(group) async {
    try {
      final response = await supabase
          .from('menu_item_options')
          .select('*')
          .eq('option_group_id', group)
          .order('display_order', ascending: true);

      if (response.isEmpty) {
        return [];
      }
      return response.map<MenuItemOptions>((menuOptions) {
        return MenuItemOptions.fromJson(menuOptions);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
