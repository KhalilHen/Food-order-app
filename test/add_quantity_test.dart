import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hf_customer_app/provider/item_quantity.dart';

void main() {
  test("Default state of the item quantity provider", () {
    final container = ProviderContainer.test();

    // container.read(itemQuantityProvider(3));
    // container.listen(itemQuantityProvider(3), )

    expect(container.read(itemQuantityProvider(3)), equals(0));
  });

  test("Increasing quantity of an item", () {
    final container = ProviderContainer.test();
    container.read(itemQuantityProvider(3).notifier).updateQuantity();
    container.read(itemQuantityProvider(2).notifier).updateQuantity();

    for (int i = 0; i < 6; i++) {
      container.read(itemQuantityProvider(5).notifier).updateQuantity();
    }

    expect(container.read(itemQuantityProvider(3)), equals(1));
    expect(container.read(itemQuantityProvider(2)), equals(1));
    expect(container.read(itemQuantityProvider(5)), equals(6));
  });

  test("Decreasing the quantity  of the menu item quantity counter", () {
    //Setupm
    final container = ProviderContainer.test();

    container.read(itemQuantityProvider(3).notifier).decreaseQuantity();

    for (int t = 0; t < 3; t++) {
      container.read(itemQuantityProvider(2).notifier).updateQuantity();
    }
    container.read(itemQuantityProvider(2).notifier).decreaseQuantity();

    for (int i = 0; i < 6; i++) {
      container.read(itemQuantityProvider(5).notifier).updateQuantity();
      container.read(itemQuantityProvider(5).notifier).decreaseQuantity();
    }

    // Check whether a item quantity can go  -1/-0
    expect(container.read(itemQuantityProvider(3)), equals(0));
    // Check if it decrease correctly items
    expect(container.read(itemQuantityProvider(5)), equals(0));
    expect(container.read(itemQuantityProvider(2)), equals(2));
  });
}
