// !! Menu item option groups e.g Toppins, dressings, sizes, etc
import 'package:decimal/decimal.dart';

class MenuItemOptions {
  final int id;
  final int optionGroupId;

  final String name;
  final String? description;
  final Decimal priceModifier;
  final int displayOrder;
  final bool isAvailable;
  final bool isActive;

  MenuItemOptions({
    required this.id,
    required this.optionGroupId,
    required this.name,
    this.description,
    required this.priceModifier,
    required this.displayOrder,
    required this.isAvailable,
    required this.isActive,
  });

  factory MenuItemOptions.fromJson(Map<String, dynamic> json) {
    return MenuItemOptions(
      id: json['id'] as int,
      optionGroupId:
          json['option_group_id'] as int,

      name: json['name'] as String,

      description: json['description'] as String?,
      priceModifier: Decimal.parse(json['price_modifier'].toString()),


      displayOrder:
          json['display_order'] as int,

      isAvailable: json['is_available'] as bool,

      isActive:  json['is_active'] as bool,
    );
  }

}
