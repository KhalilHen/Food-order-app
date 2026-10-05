import 'package:hf_customer_app/core/utils/utils.dart';

import 'enum/category_icon_enum.dart';

class Category {
  final int id;
  final String name;
  final String iconName;
 
  Category({
    required this.id,
    required this.name,
    required this.iconName,

  });
  IconData get icon => CategoryIconEnum.fromString(iconName).iconData;

  factory Category.fromJson(Map<String, dynamic> json) {

return Category(id: json['id'], name: json['name'], iconName: json['icon_name']);
  }
}