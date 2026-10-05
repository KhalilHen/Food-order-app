import 'package:hf_customer_app/models/enum/order_status_enum.dart';

class Order {
  final String id;
  final String customerId;
  final String restaurantId;
  // final String? orderStatus;
  final OrderStatusEnum? orderStatus;
  final DateTime? pickUpTime;
  final String? customerNotes;
  final num? subTotal;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.restaurantId,
     required this.customerId,
      required this.orderStatus,
       this.pickUpTime,
        this.customerNotes, 
         this.subTotal,
         this.createdAt, 
         this.updatedAt,
   
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
     customerId:   json['customer_id'],
      restaurantId: json['restaurant_id'],
      // orderStatus: json['order_status']  ?? 'unknown',
      orderStatus: OrderStatusEnum.fromString(json['status']),

      pickUpTime: json['pick_up_time'] ,
      createdAt:   DateTime.parse(json['created_at']),
      updatedAt:   DateTime.parse(json['updated_at']),



    );
  }
}
