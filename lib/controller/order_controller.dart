import 'dart:async';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hf_customer_app/models/enum/order_status_enum.dart';
import '../core/utils/utils.dart';
import '../models/order.dart';
import '../models/order_history.dart';
import '../models/order_items.dart';

class OrderController {
  //TODO Adjust the subTotal & totalPrice once you include a fixed amount tax/service fee
  // ! For now just subTotal everything
  Future<Result<(Order?, List<OrderItem>), Exception>> createOrder(
    List<Map<String, dynamic>> shoppingCartItems,
    restaurantId,
    subTotal, //! For now  subTotal
    userId,
  ) async {
    if (userId == null) {
      final exception = UserNotAuthenticatedException();
      return Failure(
        ExceptionHandler.handleException(exception),
        exception: exception,
      );
    }

    try {
      final response = await supabase
          .from('orders')
          .insert({
            'customer_id': userId,
            'restaurant_id': restaurantId,
            'sub_total': subTotal,
          })
          .select('*')
          .single();

      final orderObject = Order.fromJson(response);
      final orderItems = shoppingCartItems
          .map(
            (item) => {
              ...item,
              'sub_total': subTotal,
              'order_id': response['id'],
            },
          )
          .toList();

      final orderItemResponse = await supabase
          .from('order_items')
          .insert(orderItems)
          .select('*');


      final orderItemsObject = orderItemResponse
          .map((item) => OrderItem.fromJson(item))
          .toList();

      //TODO Add here stripe part

      return Success((orderObject, orderItemsObject), null);
    } on Exception catch (e, s) {
      final exception = e;

      return Failure(ExceptionHandler.handleException(e, s));
    }
  }

  Future<Result<List<OrderHistoryModel>?, Exception>> fetchOrderHistory(
    userId,
  ) async {
    //* User check
    if (userId == null) {
      final exception = UserNotAuthenticatedException();
      return Failure(
        ExceptionHandler.handleException(exception),
        exception: exception,
      );
    }

    try {
      final response = await supabase
          .from('orders')
          .select('''
id, restaurant_id, status, total_amount,   customer_id,  created_at, updated_at, sub_total,
    restaurant(name,  restaurant_preview_banner) 
  ''')
          .eq('customer_id', userId)
          .limit(15);

      final mapOrders = response
          .map((item) => OrderHistoryModel.fromJson(item))
          .toList();

      return Success(mapOrders, null);
    } catch (e, s) {
      final exception = e;
      return Failure(ExceptionHandler.handleException(e, s));
    }
  }

  //TODO Refactor this into a async notifier https://claude.ai/chat/4e5d2473-6e2f-474b-9ba0-fd9ab0aedda5
  //TODO Think about mabye also fetching restaurant cause some screens need it in the order status screens
  (Stream<OrderStatusEnum>, RealtimeChannel) orderStatusListener(
    String orderId,
  ) {
    late RealtimeChannel channel;

    final controller = StreamController<OrderStatusEnum>();
    channel = supabase
        .channel('public:orders')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'orders',

          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: orderId,
          ),

          callback: (payload) {
            final status = payload.newRecord['status'];
            if (status != null) {
              controller.add(OrderStatusEnum.fromString(status.toString()));
            }

            print('Change received: ${payload.toString()}');
          },
        )
        .subscribe((status, [error]) {
          print('Channel status: $status');
          print('Channel error: $error');
        });

    return (controller.stream, channel);
  }
}
