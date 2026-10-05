import 'package:decimal/decimal.dart';
import 'package:hf_customer_app/controller/stripe_controller.dart';
import '../../core/utils/utils.dart';

import 'package:hf_customer_app/controller/order_controller.dart';
import 'package:hf_customer_app/provider/shopping_cart_provider.dart';
import 'package:hf_customer_app/provider/restaurant_provider.dart';

import '../../provider/user_provider.dart';

class CartOverview extends ConsumerStatefulWidget {
  const CartOverview({super.key});

  @override
  ConsumerState<CartOverview> createState() => _CartOverviewState();
}

class _CartOverviewState extends ConsumerState<CartOverview> {
  @override
  Widget build(BuildContext context) {
    final stripeController = StripeController();
    final orderController = OrderController();
    final whichRestaurantAreWeIn = ref.watch(restaurantProvider);
    final shoppingCart = ref.watch(
      shoppingCartProvider(whichRestaurantAreWeIn!),
    );
    final user = ref.watch(userProvider);

    //This one is what get's sent to the createOrder function to insert the items into the table
    final shoppingCartItems = ref
        .read(shoppingCartProvider(whichRestaurantAreWeIn).notifier)
        .toJsonList();

    final cartItems = shoppingCart.values.toList();

    // Calculate totals
    final totalItems = cartItems.fold<int>(
      0,
      (sum, cart) => sum + cart.quantity,
    );
    final totalPrice = cartItems.fold<double>(
      0.0,
      (sum, cart) =>
          sum + (cart.menuItem!.basePrice.toDouble() * cart.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Your cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // Cart items list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final cart = cartItems[index];
                      final menuItem = cart.menuItem!;
                      final quantity = cart.quantity;
                      final itemTotal =
                          menuItem.basePrice * quantity.toDecimal();

                      return Padding(
                        // ke
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quantity badge
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  15,
                                  14,
                                  14,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '×$quantity',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Item details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menuItem.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '€${menuItem.basePrice.toStringAsFixed(2).replaceAll('.', ',')} per item',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Price
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '€${itemTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // ! This is the container where you can change the quantity of the item and if there is only 1 item left it change into  a trashcan icon button
                                Container(
                                  child: quantity == 1
                                      ? Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      shoppingCartProvider(
                                                        whichRestaurantAreWeIn,
                                                      ).notifier,
                                                    )
                                                    .removeMenuItem(
                                                      menuItem,
                                                      null,
                                                    );
                                              },
                                              icon: Icon(
                                                Icons.delete_outline,
                                                size: 20,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(quantity.toString()),

                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      shoppingCartProvider(
                                                        whichRestaurantAreWeIn,
                                                      ).notifier,
                                                    )
                                                    .updateMenuItemQuantity(
                                                      menuItem,
                                                      null,
                                                    );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      shoppingCartProvider(
                                                        whichRestaurantAreWeIn,
                                                      ).notifier,
                                                    )
                                                    .decreaseMenuItemQuantity(
                                                      menuItem,
                                                      null,
                                                    );
                                              },

                                              icon: const Icon(Icons.remove),
                                            ),

                                            Text(quantity.toString()),

                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      shoppingCartProvider(
                                                        whichRestaurantAreWeIn,
                                                      ).notifier,
                                                    )
                                                    .updateMenuItemQuantity(
                                                      menuItem,
                                                      null,
                                                    );
                                              },

                                              icon: const Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom summary card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Subtotal row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Subtotal ($totalItems items)',

                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  //TODO Add here in future service fee
                                ],
                              ),

                              Text(
                                '€${totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 24),
                          // Total row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '€${(totalPrice).toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Checkout button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (user.value == null) {
                                  UIHelper.navigateTo(
                                    context,
                                    '/login',
                                    NavigationType.go,
                                    null,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'You need to be logged in to create an order',
                                      ),
                                    ),
                                  );
                                  return;
                                }


int amountInCents = (totalPrice * 100).round();
print(user.value);
print(amountInCents);
    final stripeResponse =  await stripeController.createPaymentIntent(user.value, amountInCents);

        if(stripeResponse case Success()) {

        final confirmPaymentResponse = await StripeController().confirmPayment(context);
///! After user succesfully paid for the order i create the order
///TODO Change in next version that this happends vice versa. So that the total price comes from the DB and not the client side
                                final orderResponse = await orderController
                                    .createOrder(
                                      shoppingCartItems,
                                      whichRestaurantAreWeIn,
                                      totalPrice,
                                      user.value!.id,
                                    );
                                                       switch (orderResponse) {
                                  case Success():

                                    //Clear the items from the cart
                                    ref
                                        .read(
                                          shoppingCartProvider(
                                            whichRestaurantAreWeIn,
                                          ).notifier,
                                        )
                                        .clearCart(
                                          orderResponse.value.$2,
                                          null,
                                        );

                                    UIHelper.navigateTo(
                                      context,
                                      '/order-status/${orderResponse.value.$1!.id}',
                                      NavigationType.go,

                                      orderResponse.value.$1,
                                    );

                                  case Failure():
                                   UIHelper.showError(context,  orderResponse.message);
                         
                                }
      }   else {
                                   UIHelper.showError(context,  "Sorry something went wrong with the payment");

       
      }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Go to checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to start',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: context.pop,
            icon: const Icon(Icons.restaurant_menu, size: 20),
            label: const Text(
              'Browse Menu',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepOrange,
              side: const BorderSide(color: Colors.deepOrange, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
