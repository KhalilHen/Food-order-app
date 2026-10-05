import '../utils/utils.dart';
import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/provider/shopping_cart_provider.dart';
import 'package:hf_customer_app/provider/item_quantity.dart';
import 'package:hf_customer_app/provider/restaurant_provider.dart';

class MenuItemDetailModal extends ConsumerWidget {
  final MenuItem item;
  const MenuItemDetailModal({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRestaurantId = ref.read(restaurantProvider);
    final quantity = ref.watch(itemQuantityProvider(item.id));
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Item image if available
            if (item.image != null && item.image!.isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.fastfood,
                          color: Colors.grey,
                          size: 60,
                        ),
                      );
                    },
                  ),
                ),
              ),

            Text(
              item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            if (item.description != null && item.description!.isNotEmpty)
              Text(
                item.description!,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

            const SizedBox(height: 16),

            Text(
              '€${item.basePrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 16),

            // ! Quantity structure
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    ref
                        .read(itemQuantityProvider(item.id).notifier)
                        .decreaseQuantity();
                  },
                  icon: const Icon(Icons.remove),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$quantity',

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () => ref
                      .read(itemQuantityProvider(item.id).notifier)
                      .updateQuantity(),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            //!! Temporary removed for V1.0
            // CustomMenuGroupWidget(item: item),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //TODO Add later customization
                  final response = ref.watch(itemQuantityProvider(item.id));

                  // If quantity selected is 0 then dont add to the shopping cart
                  if (response == 0) {
                  } else {
                    ref
                        .read(
                          shoppingCartProvider(currentRestaurantId!).notifier,
                        )
                        .addMenuItem(response, item, null);
                  }

                  // TODO: Add to cart logic with customizations
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to your cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
