import 'package:decimal/decimal.dart';
class MenuItem {
  final int id;
  final String restaurantId;
  final int categoryId;
  final String name;
  final String? description;
  final String? image;
  final Decimal basePrice;
  final bool isAvailable;
  final bool isActive;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    this.description,
    this.image,
    required this.basePrice,
    required this.isAvailable,
    required this.isActive,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as int,
      restaurantId: json['restaurant_id'] as String,
      categoryId: json['category_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
 
      basePrice: Decimal.parse(json['base_price'].toString()),

      isAvailable: json['is_available'] as bool? ?? true,

      isActive: json['is_active'] as bool? ?? true,
    );
  }

  @override 
  String toString() {
    return 'MenuItem:  id: $id, restaurantId: $restaurantId, categoryId: $categoryId, name: $name,  description: $description,       baseprice: $basePrice,  isAvailable: $isAvailable,  isActive: $isActive';

  }
}
