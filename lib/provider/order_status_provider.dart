import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hf_customer_app/controller/order_controller.dart';
import 'package:hf_customer_app/models/order_history.dart';

import '../core/error/result.dart';
import '../models/enum/order_status_enum.dart';

final orderStatusProvider = FutureProvider.family
    .autoDispose<List<OrderHistoryModel>, String?>((ref, userId) async {
      final response = await OrderController().fetchOrderHistory(userId);

      switch (response) {
        case Success():
          return response.value ?? [];

        case Failure():
          return [];
      }
    });
final orderStreamProvider = StreamProvider.family<OrderStatusEnum, String>((
  ref,
  orderId,
) {
  final (stream, channel) = OrderController().orderStatusListener(orderId);

  ref.onDispose(() {
    channel.unsubscribe();
  });

  return stream;
});
