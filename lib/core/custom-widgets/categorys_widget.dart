// ! Not in use currently!
import '../../controller/restaurant_controller.dart';
import '../../models/category.dart';
import '../utils/utils.dart';

class CategorysWidget extends StatefulWidget {
  const CategorysWidget({super.key});

  @override
  State<CategorysWidget> createState() => _CategorysWidgetState();
}

class _CategorysWidgetState extends State<CategorysWidget> {
  List<Category>? categoryItems;

  @override
  void initState() {
    loadCategorys();
    super.initState();
  }

  Future<List<Category>?> loadCategorys() async {
    final response = await RestaurantController().fetchAllCategorys();

    switch (response) {
      case Success():
        categoryItems = response.value;
        return categoryItems;

      case Failure():
        return categoryItems;
    }
  }

  @override
  void dispose() {
    loadCategorys();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItems?.length ?? 0,
        itemBuilder: (context, index) {
          final category = categoryItems?[index];


          return category == null
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category.icon),

                        const SizedBox(height: 16),
                        Text(category.name),
                      ],
                    ),
                    //Breathing space
                    const SizedBox(width: 18), //ADjust this
                  ],
                );
        },
      ),
    );
  }
}
