import '../../core/utils/utils.dart';
import 'package:hf_customer_app/controller/menu_category_controller.dart';
import 'package:hf_customer_app/controller/menu_controller.dart';
import 'package:hf_customer_app/controller/order_controller.dart';
import 'package:hf_customer_app/core/custom-widgets/menu_item_widget.dart';
import 'package:hf_customer_app/models/menu_category.dart';
import 'package:hf_customer_app/models/menu_item.dart';
import 'package:hf_customer_app/models/restaurant.dart';
import 'package:hf_customer_app/provider/shopping_cart_provider.dart';
import 'package:hf_customer_app/provider/restaurant_provider.dart';

class RestaurantView extends ConsumerStatefulWidget {
  final Restaurant restaurant;

  const RestaurantView({super.key, required this.restaurant});

  @override
  ConsumerState<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends ConsumerState<RestaurantView> {
  final orderController = OrderController();
  final menuCategoryController = MenuCategoryController();
  final menuItemController = MenuItemController();

  @override
  void initState() {
    super.initState();

    // ! This schedules a callback to run after the frame is build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(restaurantProvider.notifier)
          .retrieveCurrentRestaurant(widget.restaurant.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.restaurant.isOpen) {
      return const Scaffold(
        body: Center(child: Text("Sorry restaurant is currently closed")),
      );
    }

    if (!widget.restaurant.isActive) {
      return const Scaffold(
        body: Center(
          child: Text("Sorry the restaurant is currently unavailable"),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'restaurant-${widget.restaurant.id}',
                child:
                    widget.restaurant.restaurantPreviewBanner == null ||
                        widget.restaurant.restaurantPreviewBanner!.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.restaurant.restaurantPreviewBanner ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              title: Text(
                widget.restaurant.name,
                style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${widget.restaurant.reviewCount} reviews',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '30 min',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.restaurant.description ??
                          "Momenteel geen bescrijving beschikbaar",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Menu Categories and Items
          FutureBuilder<List<MenuCategory>>(
            future: menuCategoryController.fetchCategoryFromRestaurant(
              widget.restaurant.id,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );

                case ConnectionState.none:
           
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );

                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Der is een fout gekomen bij het laden van de categeorieen. Contact support als dit blijft voorkomen',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                           'No Menu items available',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }

                  final categories = snapshot.data!
                      .where((category) => category.isActive)
                      .toList();

                  // Sort categories by display order
                  categories.sort(
                    (a, b) => a.displayOrder.compareTo(b.displayOrder),
                  );

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final category = categories[index];
                      return _buildCategorySection(category);
                    }, childCount: categories.length),
                  );

                case ConnectionState.active:
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
              }
            },
          ),
          // Add some bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          final itemInCart = ref.watch(
            shoppingCartProvider(widget.restaurant.id),
          );
          if (itemInCart.isNotEmpty) {
            return FloatingActionButton.extended(
              backgroundColor: Colors.deepOrangeAccent,
              icon: const Icon(Icons.shopping_cart, color: Colors.white),

              elevation: 6,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),

              label: const Padding(
               
                padding: EdgeInsets.symmetric(horizontal: 4),

                child: Text(
                  "Go to your shopping cart",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              onPressed: () => context.push('/cart-overview'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCategorySection(MenuCategory category) {
    final sectionName = category.name.isEmpty ? 'Naamloos' : category.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.1),
            border: const Border(
              left: BorderSide(color: Colors.deepOrange, width: 4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              if (category.description != null &&
                  category.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    category.description!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
            ],
          ),
        ),

        // Menu Items for this category
        StreamBuilder<List<MenuItem>>(
          stream: menuItemController.fetchMenuItems(category.id),

          // (category.id),
          builder: (context, itemSnapshot) {
            if (itemSnapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (itemSnapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Fout bij laden van menu items',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (!itemSnapshot.hasData ||
                itemSnapshot.data == null ||
                itemSnapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Geen items beschikbaar in deze categorie',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }

            final menuItems = itemSnapshot.data!
                .where((item) => item.isActive && item.isAvailable)
                .toList();

            

            return Column(
              children: menuItems
                  .map((item) => CustomMenuItemWidget(item: item))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
