//TODO Refactor this model before finalizing
// TODO Figure out whether i need to use type double for money
class OrderItem {
  final String id; //! Figure out whether int as id is also fine??
  final int menuItemId;
  final String itemName;
  final String? itemDescription;
  final int quantity;
  final num? unitPrice;
  final num? subTotal;
  // final num totalPrice;
  final String? specialInstructions;
  final String? orderId;
  // final int displayOrder;

  OrderItem({
    required this.id, required this.menuItemId, required this.itemName, this.itemDescription,  required this.quantity, this.unitPrice, this.subTotal,   this.specialInstructions, this.orderId,

  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
     menuItemId:   json['menu_item_id'] as int,
      itemName: json['item_name'] as String,
      itemDescription: json['item_description'] as String?  ?? '',

      quantity: json['quantity'] as int,
      unitPrice: json['unit_price'] as num?,
      subTotal: json['sub_total'] as  num?,
      // totalPrice: json['total_price'] as num,
      specialInstructions: json['special_instructions'] as String? ?? '',



    );
  }
}
