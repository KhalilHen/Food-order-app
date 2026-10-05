import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hf_customer_app/models/enum/order_status_enum.dart';
import 'package:hf_customer_app/provider/order_status_provider.dart';
import 'order_status_pages/order_ready_for_pickup_screen.dart';
import 'order_status_pages/order_status_cancelled.dart';
import 'order_status_pages/order_status_confirmed.dart';
import 'order_status_pages/order_status_pending.dart';
class OrderStatusHandler extends StatelessWidget {
  // final Order  order;
  //! For now orderId perhaps change this if so //TODO Adjust the order history sent object
  final String orderId;
  const OrderStatusHandler({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final value = ref.watch(
          orderStreamProvider(orderId),
        );

        return value.when(
          
          data: (status)
           {
            print(status);
            switch (status) {
              case OrderStatusEnum.pending:
                return const OrderStatusPending();

              case OrderStatusEnum.accepted:

                return const OrderStatusConfirmed();


              case OrderStatusEnum.cancelled:
              return const OrderStatusCancelled();

              case OrderStatusEnum.ready:

              return  const OrderStatusReady();
              default:
                return const Text('unknown status');
            }
          },
          loading: () {
           return const OrderStatusPending();
          },

          error: (e, st) => Text('Error: $e'),
        );
      },
    );
  }
}
