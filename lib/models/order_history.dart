//! Model order history to combine both properties from order and restaurant.
//TODO mabye change this just to OrderHistory
class OrderHistoryModel {
  final String id;
  final String customerId;
  final String restaurantId;
  final String? orderStatus;
  // final DateTime? pickUpTime;
  final String? customerNotes;
  final num? subTotal;
  final String restaurantName;
  final String? restaurantPreviewBanner;
  final DateTime createdAt;
  final DateTime? updatedAt;
 

  OrderHistoryModel({
    required this.id,
    required this.restaurantId,
    required this.customerId,
    this.orderStatus,
    //  this.pickUpTime,
    this.customerNotes,
    this.subTotal,
    required this.restaurantName,
    this.restaurantPreviewBanner,
   required this.createdAt,
    this.updatedAt,
  
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      customerId: json['customer_id'],
      restaurantId: json['restaurant_id'],
      orderStatus: json['status'] ?? 'unknown',
      subTotal: json['sub_total'],

      restaurantName: json['restaurant']['name'],
      restaurantPreviewBanner: json['restaurant']['restaurant_preview_banner'],
      // * If there is no data no use of parsing the data
createdAt: DateTime.parse(json['created_at']),
updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,

    );
  }
}
