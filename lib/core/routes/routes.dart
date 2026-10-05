//TODO Change that every page uses a normal import routing and not a package routing
import 'package:hf_customer_app/core/routes/auth_guard.dart';
import 'package:hf_customer_app/core/utils/utils.dart';
import 'package:hf_customer_app/models/restaurant.dart';
import 'package:hf_customer_app/pages/cart/cart_overview.dart';
import 'package:hf_customer_app/pages/errors/not_found_page.dart';
import 'package:hf_customer_app/pages/forgot_password.dart';
import 'package:hf_customer_app/pages/location_page.dart';
import 'package:hf_customer_app/pages/login.dart';
import 'package:hf_customer_app/pages/order_history_page.dart';
import 'package:hf_customer_app/pages/order_status_pages/order_ready_for_pickup_screen.dart';
import 'package:hf_customer_app/pages/order_status_pages/order_status_cancelled.dart';
import 'package:hf_customer_app/pages/order_status_pages/order_status_confirmed.dart';
import 'package:hf_customer_app/pages/order_status_pages/order_status_pending.dart';
import 'package:hf_customer_app/pages/settings_page.dart';
import 'package:hf_customer_app/pages/profile_personal_information.dart';
import 'package:hf_customer_app/pages/reset_password.dart';
import 'package:hf_customer_app/pages/restaurant_overview_.dart';
import 'package:hf_customer_app/pages/restaurant_view.dart';
import 'package:hf_customer_app/pages/sign_up.dart';
import 'package:hf_customer_app/core/routes/bottom_nav_bar.dart';
import '../../pages/order_status_handler.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
GoRouter? previousRouter;

class Routes {
  static GoRouter router({String? initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation ?? '/',
      navigatorKey: rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              BottomNavBar(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const RestaurantOverviewPage(),
                ),

                GoRoute(
                  path: '/restaurants',
                  builder: (context, state) => const RestaurantOverviewPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/order-history',

                  builder: (context, state) => const OrderHistoryPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const ProfilePage(),
                ),

                GoRoute(
                  path: '/settings/personal-information',
                  builder: (context, state) {
                    return const PersonalInformation();
                  },
                ),
              ],
            ),
          ],
        ),
//TODO Change restaurant into a seperate widget in the future
        // GoRoute(
        //   path: '',
        //   builder: (context, state) => const RestaurantWidget(),
        // ),


        GoRoute(
          path: '/location',
          builder: (context, state) => const LocationPage(),
        ),
  
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),


        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: '/forgot-password',

          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/reset-password',
          name: 'resetPassword',

          builder: (context, state) => const ResetPassword(),
        ),
        // * Restaurants
        GoRoute(
          path: '/restaurant-specific',

          builder: (context, state) {
            final restaurant = state.extra as Restaurant;
            return RestaurantView(restaurant: restaurant);
          },
        ),

        GoRoute(
          path: '/cart-overview',
          builder: (context, state) => const CartOverview(),
        ),

        // ** Order status screens
        //TODO Configure later that the screen receives both Order and OrderItesm
        //TODO Nice to have (for later):  After that  the user succesfully logged in make the user redirect back to the cart
        GoRoute(
          path: '/order-status/:id',
          builder: (context, state) {
            final order = state.pathParameters['id'];

            return AuthGuard(
              fallbackRoute: '/login',

              child: OrderStatusHandler(orderId: order!),
            );
          },
        ),
        GoRoute(
          path: '/order-status/pending',

          builder: (context, state) => const OrderStatusPending(),
        ),

        GoRoute(
          path: '/order-status/accepted',

          builder: (context, state) => const OrderStatusConfirmed(),
        ),

        GoRoute(
          path: '/order-status/cancelled',

          builder: (context, state) => const OrderStatusCancelled(),
        ),
        GoRoute(
          path: '/order-status/ready',

          builder: (context, state) => const OrderStatusReady(),
        ),

        GoRoute(
          path: '/not-found-page',
          builder: (context, state) => const NotFoundPage(),
        ),
      ],
  errorBuilder: (context, state) => const NotFoundPage(),
    );
  }
}
