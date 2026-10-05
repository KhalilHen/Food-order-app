import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hf_customer_app/models/cart/cart.dart';
import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/models/menu_item_options.dart';
import 'package:hf_customer_app/models/order_items.dart';

class ShoppingCart extends Notifier<Map<String, Cart>> {
  @override
  Map<String, Cart> build() => {};

  //!! This is optimized for only unique menu items not yet with the additional customization options.

  void updateMenuItemQuantity(
    MenuItem menuItem,
    MenuItemOptions? customizationOptions,
  ) {
    state = Map.from(state)
      ..update(
        'item_${menuItem.id}',
        (existing) => Cart(
          menuItem: existing.menuItem,
          quantity: existing.quantity + 1,
          customOptions: existing.customOptions,
        ),
      );
  }

  void decreaseMenuItemQuantity(
    MenuItem menuItem,
    MenuItemOptions? customzationOptions,
  ) {
    state = Map.from(state)
      ..update(
        'item_${menuItem.id}',
        (existing) => Cart(
          menuItem: existing.menuItem,
          quantity: existing.quantity - 1,
          customOptions: existing.customOptions,
        ),
      );
  }

  void addMenuItem(
    int quantity1,
    MenuItem menuItem,
    MenuItemOptions? customizationOptions,
  ) {
    if (state.containsKey("item_${menuItem.id}")) {
      state = Map.from(state)
        ..update(
          'item_${menuItem.id}',
          (existing) => Cart(
            menuItem: existing.menuItem,
            quantity: existing.quantity + quantity1,
            customOptions: existing.customOptions,
          ),
        );
    } else {
      final newCartItem = Cart(
        quantity: quantity1,
        menuItem: menuItem,
        customOptions: customizationOptions,
      );

      state = {...state, 'item_${menuItem.id}': newCartItem};
    }
  }

  //!! This is optimized for only unique menu items not yet with the additional customization options.
  void removeMenuItem(
    MenuItem menuItem,
    MenuItemOptions? customizationOptions,
  ) {
    state = Map.from(state)..remove('item_${menuItem.id}');
  }

  void clearCart(
    List<OrderItem> menuItemId,
    MenuItemOptions? customizationOptions,
  ) {
    for (var menuItem in menuItemId) {
      state = Map.from(state)..remove('item_${menuItem.menuItemId}');
    }
  }

  List<Map<String, dynamic>> toJsonList() {
    return state.values.map((cart) => cart.toJson()).toList();
  }
}

final shoppingCartProvider =
    NotifierProvider.family<ShoppingCart, Map<String, Cart>, String>((ref) {
      return ShoppingCart();
    });
