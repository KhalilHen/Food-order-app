class MenuCategory {
  final int id;
  final String restaurantId;
  final String name;
  final String? description;
  final int displayOrder;
  final bool isActive;

  MenuCategory({
    required this.id,
    required this.restaurantId,
    required this.name,
     this.description,
    required this.displayOrder,
    required this.isActive,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {

return MenuCategory(
      id: json['id'] as int,
      restaurantId: json['restaurant_id'] as String,
      name: json['name'] as String,
      description:
          json['description'] as String?,

      displayOrder:
          json['display_order'] as int,
      isActive:
          json['is_active'] as bool,
         
      );

  }
}

