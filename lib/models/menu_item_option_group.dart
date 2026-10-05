// !! Menu item option groups e.g Toppins, dressings, sizes, etc


class MenuItemOptionGroup {
  final int id;
  final  int menuItemId;

  final String name;
  final String? description;
  final bool isRequired;
  final int minSelections;
  final int maxSelections;

  final bool isActive;
  // final int displayOrder;

  MenuItemOptionGroup({
    required this.id,
      required this.menuItemId,
    required this.name,
    this.description, 
      required this.isRequired,
      required this.minSelections,
      required this.maxSelections,

    required this.isActive,
    // required this.displayOrder,
  });
  factory MenuItemOptionGroup.fromJson(Map<String, dynamic> json) {
    return MenuItemOptionGroup(
      id: json['id'] as int,

      menuItemId:  json['menu_item_id'],

      name: json['name'] as String,

      description: json['description'] as String?,
      isRequired: json['is_required'] as bool,

      minSelections: json['min_selections'],

  
    maxSelections:   json['max_selections'],

    isActive: json['is_active'] as bool,
    );
  }
}