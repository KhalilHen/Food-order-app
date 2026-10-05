import '../../core/utils/utils.dart';
import 'package:hf_customer_app/controller/auth_controller.dart';
import 'package:hf_customer_app/controller/restaurant_controller.dart';
import 'package:hf_customer_app/models/restaurant.dart';

class RestaurantOverviewPage extends StatefulWidget {
  const RestaurantOverviewPage({super.key});

  @override
  State<RestaurantOverviewPage> createState() => _RestaurantOverviewPageState();
}

//TODO Add search query
//TODO Add here the category widget and search bar. And make sure it changes the streambuilder based on user interaction.
class _RestaurantOverviewPageState extends State<RestaurantOverviewPage> {
  final restaurantController = RestaurantController();
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Restaurants"),
        backgroundColor: Colors.orange, actions: const [
        
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            SearchBar(
              leading: const Icon(Icons.search),
              onChanged: (value) {},
              hintText: "Search restaurants",
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                ),
              ),
            ),
            //Breathing space
            const SizedBox(height: 16),

            //TODO Add here for in the future filter chips
            Expanded(
              child: StreamBuilder(
                stream: restaurantController.fetchAllRestaurants(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(padding: EdgeInsetsGeometry.all(16)),
                            Text("Loading restaurants"),
                          ],
                        ),
                      );
                    case ConnectionState.none:
                
                      return const Center(child: CircularProgressIndicator());

                    case ConnectionState.active:
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        final List<Restaurant> restaurants = snapshot.data!;

                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final restaurant = restaurants[index];
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: SizedBox(
                                height: 250,
                                width: 60,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(
                                      '/restaurant-specific?id=$restaurant',

                                      extra: restaurant,
                                    );
                                  },
                                  child: Hero(
                                    tag: "Restaurant-${restaurant.id}",
                                    child: Card(
                         
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(16),
                                      ),
                                      child:
                                          //Parent column
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                flex: 2,

                                                //TODO Add restaurant category to the collection of items
                                                child:
                                                    restaurant
                                                            .restaurantPreviewBanner !=
                                                        null
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                            4
                                                            ),

                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                16,
                                                              ),

                                                          child: Image.network(
                                                            restaurant
                                                                .restaurantPreviewBanner!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      child: Container(
                                                        color: Colors
                                                            .grey
                                                            .shade300,
                                                        alignment: Alignment
                                                            .center,
                                                        child: Icon(
                                                          Icons.hide_image,
                                                          size: 40,
                                                          color: Colors
                                                              .grey
                                                              .shade400,
                                                        ),
                                                      ),
                                                    ),
                                              ),

                                              Expanded(
                                                flex: 1,

                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        restaurant.name,
                                                        style: const TextStyle(
                                                          fontSize: 24,
                                                        ),
                                                      ),

                                                      const SizedBox(height: 4),

                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),

                                                          Text(
                                                            restaurant.rating
                                                                .toString(),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),

                                                          const Text('•'),

                                                          const Text(
                                                            '15-30 mins',
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "Sorry der zijn momenteel geen restaurants bij u in de buurt",
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              const Text(
                                "Sorry there went something wrong. Please refresh the page and try again.",
                              ),

                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => setState(() {}),

                                child: const Text("Reload"),
                              ),
                            ],
                          ),
                        );
                      }
                    case ConnectionState.done:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            24.0,
                          ), // Add some breathing room
                          child: Column(
                            mainAxisSize: MainAxisSize
                                .min, // So it doesn't stretch the whole height
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.redAccent,
                              ),
                              // ! No internet message
                              const Text(
                                "There went something wrong. Try refreshing the page by clicking the button.",

                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 16,
                              ), // Space between text and butto
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: const Text("Reload the page"),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),

    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
