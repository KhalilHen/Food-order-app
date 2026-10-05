import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hf_customer_app/provider/restaurant_provider.dart';

void main() {
  test("Default state of the restaurant  provider", () {
    final container = ProviderContainer.test();

    container.read(restaurantProvider);

    expect(container.read(restaurantProvider), equals(null));
  });

  test("retrieving the current restaurant state", () {
    final container = ProviderContainer.test();

    container
        .read(restaurantProvider.notifier)
        .retrieveCurrentRestaurant("testRestaurant");

    expect(container.read(restaurantProvider), equals("testRestaurant"));
  });

  test("retrieving  different restaurants   ", () {
    final container = ProviderContainer.test();

    container
        .read(restaurantProvider.notifier)
        .retrieveCurrentRestaurant("Restaurant1");

    expect(container.read(restaurantProvider), equals("Restaurant1"));

    container
        .read(restaurantProvider.notifier)
        .retrieveCurrentRestaurant("Restaurant2");
    expect(container.read(restaurantProvider), equals("Restaurant2"));

    
  });
}
