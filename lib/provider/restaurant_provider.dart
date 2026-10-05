// !! This providers keeps eye of which restaurant user is  looking into. So the cart provider knows which restaurant
// !! it should display it's menu items

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantProvider extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  retrieveCurrentRestaurant(String restaurantId) {
    final currentRestaurant = restaurantId;

    state = currentRestaurant;
  }
}

final restaurantProvider = NotifierProvider<RestaurantProvider, String?>(() {
  return RestaurantProvider();
});
