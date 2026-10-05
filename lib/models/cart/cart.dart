import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/models/menu_item_options.dart';

class Cart {
  final MenuItem? menuItem;
  final int quantity;
  final MenuItemOptions? customOptions;

  Cart({this.menuItem, this.quantity = 0, this.customOptions});
  @override
  String toString() {
    return 'Cart:(menuItem: $menuItem,  quantity: $quantity,  custom: $customOptions)';
  }

  // ! For inserting into order_items table
  Map<String, dynamic> toJson() {
    return {
      'menu_item_id': menuItem?.id,
      'item_name': menuItem?.name,
      'item_description': menuItem?.name,
      'quantity': quantity,
    };
  }
}
