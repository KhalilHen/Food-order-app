import 'package:hf_customer_app/controller/stripe_controller.dart';
import 'package:hf_customer_app/provider/order_status_provider.dart';
import '../../core/utils/utils.dart';
import 'package:hf_customer_app/provider/user_provider.dart';
import '../controller/order_controller.dart';
import '../models/order_history.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  ConsumerState<OrderHistoryPage> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistoryPage> {
  final orderController = OrderController();
  List<OrderHistoryModel>? orders;

  @override
  void initState() {
    super.initState();
    // NotificationController().printDeviceToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    final orders = ref.watch(orderStatusProvider(user.value?.id));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.orange,
        actions: const [],
      ),

      body: user.value == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Icon(Icons.receipt_long_outlined, size: 90),

                  const SizedBox(height: 32),

                  const Text(
                    "No order history yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    textAlign: TextAlign.center,
                    "Log in to view your past orders",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 28),

                  ElevatedButton(
                    onPressed: () => context.go('/login'),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.deepOrangeAccent[200], //TODO Adjust the color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(215, 0),
                      maximumSize: const Size(
                        350,
                        60,
                      ), //TODO Test how this looks with wider
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : orders.value == null || orders.value?.isEmpty == true
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),

                  const Text('You currently don\'t have any orders yet.'),
                ],
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsetsGeometry.all(24),

                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: orders.value?.length ?? 0,

                  itemBuilder: (context, index) {
                    final order = orders.value?[index];

                    if (order!.orderStatus == 'pending') {
                      //TODO Perhaps add later a seperate custom widget for pending orders
                      return const SizedBox.shrink();
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //TODO Implement this later
                        //IF orderStatus != completed
                        // Dislay active orders  on a subheader
                        // Text("currently active orders"),
                        //For each item
                        // const SizedBox(height: 24,),
                        //Info container
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              width: 300,
                              child: Card(
                                elevation: 4,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,

                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          //! Restaurant image
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //TODO Add responsiveness here
                                                  //TODO Check how it looks on iphone perhaps less or more border radius needed
                                                  Container(
                                                    height: 80,
                                                    width: 100,

                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),

                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            12,
                                                          ),
                                                      child:
                                                          order.restaurantPreviewBanner !=
                                                              null
                                                          ? Image.network(
                                                              order
                                                                  .restaurantPreviewBanner!,
                                                              fit: BoxFit
                                                                  .contain,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            )
                                                          : const FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Icon(
                                                                Icons
                                                                    .restaurant,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 4),

                                          //! Restaurant info
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,

                                              children: [
                                                Text(
                                                  order.restaurantName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),

                                                Row(
                                                  children: [
                                                    const Text('1 item'),
                                                    const SizedBox(width: 4),
                                                    const SizedBox(height: 4),

                                                    const Text(
                                                      '•',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),

                                                    Text(
                                                      '€' +
                                                          order.subTotal
                                                              .toString(),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      order.orderStatus!,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),

                                                    const Text(
                                                      '•',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),

                                                    Text(
                                                      DateFormat(
                                                        'dd/MM/yyyy',
                                                      ).format(order.createdAt),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        12,
                                        12,
                                        12,
                                        16,
                                      ), // 👈 extra bottom breathing room

                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: 40,

                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFFF5A623,
                                                ), //! Misschien iets donkerde kleur
                                              ),

                                              //TODO
                                              //If orderStatus !=  completed  ? view order status:  View order
                                              onPressed: () => context.push(
                                                '/order-status/${order.id}',
                                              ),
                                              child: const Text(
                                                "View order status",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
