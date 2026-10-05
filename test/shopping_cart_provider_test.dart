import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/provider/shopping_cart_provider.dart';

void main() {
  final mockItems = [
    MenuItem(
      id: 1,
      restaurantId: "restaurant",
      categoryId: 1,
      name: "Pizza Margherita ",
      basePrice: 33.toDecimal(),
      isAvailable: true,
      isActive: true,
    ),

    MenuItem(
      id: 2,
      restaurantId: "restaurant-2",
      categoryId: 1,
      name: "Pizza pineapple",
      basePrice: 33.toDecimal(),
      isAvailable: true,
      isActive: true,
    ),
  ];

  test("Default state of the shopping cart", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    expect(container.read(shoppingCartProvider("restaurant")), equals({}));
  });

  test("Adding items to the shopping cart", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .addMenuItem(1, mockItems.first, null);

    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(1),
    );

    //Map length
    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(1),
    );
    expect(
      container.read(shoppingCartProvider("restaurant")).containsKey('item_1'),
      equals(true),
    );

    // ! This test different restaurant without items
    expect(
      container.read(shoppingCartProvider("restaurant-2")).length,
      equals(0),
    );

    expect(
      container
          .read(shoppingCartProvider("restaurant-2"))
          .containsKey('item_1'),
      equals(false),
    );
    // ! This test an restaurant that dont exist

    expect(
      container.read(shoppingCartProvider("unknownRestaurant")).length,
      equals(0),
    );

    expect(
      container
          .read(shoppingCartProvider("notARestaurant"))
          .containsKey('item_1'),
      equals(false),
    );
  });

  test("Removing   items from the   shopping cart", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .addMenuItem(1, mockItems.first, null);
    // * Check whether item is added to be sure

    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(1),
    );
    container
        .read(shoppingCartProvider("restaurant").notifier)
        .removeMenuItem(mockItems.first, null);

    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(0),
    );

    expect(
      container.read(shoppingCartProvider("restaurant")).containsKey('item_1'),
      equals(false),
    );
  });
  test("Updating   items from the   shopping cart", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .addMenuItem(1, mockItems.first, null);
    // * Check whether item is added to be sure
    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(1),
    );

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .addMenuItem(5, mockItems.first, null);
    // ! To retrieve a specific field
    final cartState = container.read(shoppingCartProvider("restaurant"));
    expect(cartState['item_1']?.quantity, 6);

    expect(
      container.read(shoppingCartProvider("restaurant-2")).isEmpty,
      equals(true),
    );
  });

  test("Updating only the menu item   quantity in shopping cart overview", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .addMenuItem(1, mockItems.first, null);
    expect(
      container.read(shoppingCartProvider("restaurant")).length,
      equals(1),
    );

    container
        .read(shoppingCartProvider("restaurant").notifier)
        .updateMenuItemQuantity(mockItems.first, null);
    // ! Increasing it once  times
    var cartState = container.read(shoppingCartProvider("restaurant"));

    expect(cartState['item_1']?.quantity, 2);

    // ! Increasing it multiple times

    for (int i = 0; i < 5; i++) {
      container
          .read(shoppingCartProvider("restaurant").notifier)
          .updateMenuItemQuantity(mockItems.first, null);
    }
    cartState = container.read(shoppingCartProvider("restaurant"));

    expect(cartState['item_1']?.quantity, 7);
  });

  test("Default state of the shopping cart", () {
    final container = ProviderContainer.test();

    container.read(shoppingCartProvider("restaurant"));

    expect(container.read(shoppingCartProvider("restaurant")), equals({}));
  });
}
