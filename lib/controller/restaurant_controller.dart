import 'package:hf_customer_app/models/category.dart';

import '../core/utils/utils.dart';

import 'package:hf_customer_app/models/restaurant.dart';

class RestaurantController {
  //TODO Change this later also to a subscription/postgress changes
  Stream<List<Restaurant>> fetchAllRestaurants() {
    final response = supabase
        .from('restaurant')
        .stream(primaryKey: ['id'])
        .order('name', ascending: true);

    return response.map((data) {
      return data
          .map((row) => Restaurant.fromJson(row))
          .where((restaurant) => restaurant.isOpen && restaurant.isActive)
          .toList();
    });
  }

  Stream<List<Restaurant>> fetchClosedRestaurants() {
    final response = supabase
        .from('restaurant')
        .stream(primaryKey: ['id'])
        .order('name', ascending: true);

    return response.map((data) {
      return data
          .map((row) => Restaurant.fromJson(row))
          .where(
            (restaurant) => restaurant.isOpen == false && restaurant.isActive,
          )
          .toList();
    });


  }
      //TODO Work further on this for V2
  // Future<Result<List<Restaurant>?, Exception>> fetchSearchOrganizations(
  //   String searchQuery,
  // ) async {
  //   try {
  //     final response = await supabase
  //         .from('restaurant')
  //         .select()
  //         .textSearch('name', searchQuery);

  //     final restaurants = response
  //         .map((restaurant) => Restaurant.fromJson(restaurant))
  //         .toList();

  //     return Success(restaurants, '');
  //   } catch (e, s) {
  //     return Failure(ExceptionHandler.handleException(e, s));
  //   }
  // }
// ! Not used right now
  Future<Result<List<Category>?, Exception>> fetchAllCategorys() async {
    try {
      final response = await supabase.from('category').select('*');

      if (response.isEmpty) {
        return const Failure('No category avaibel');
      }
      final category = response.map((item) => Category.fromJson(item)).toList();

      return Success(category, null);
    } catch (e, s) {
      return Failure(ExceptionHandler.handleException(e, s));
    }
  }
}
