class OrderItem {
  final int productId;
  final String productName;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  // تحويل من JSON إلى Object
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  // تحويل من Object إلى JSON لإرساله للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }
}
