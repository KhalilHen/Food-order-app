import '../../core/utils/utils.dart';

enum CategoryIconEnum {
  pizza(Icons.local_pizza),
  burgers(Icons.fastfood),
  desserts(Icons.icecream_rounded),
  sushi(Icons.menu),
  defaultIcon(Icons.local_dining);
  
  const CategoryIconEnum(this.iconData);
  final IconData iconData;

  static CategoryIconEnum fromString(String name) =>
      CategoryIconEnum.values.firstWhere(
        (e) => e.name == name,
        orElse: () => CategoryIconEnum.defaultIcon,
      );
}