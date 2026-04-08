class CartItemModel {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'quantity': quantity,
      };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        // تحويل num لـ double يمنع الـ Crash لو الرقم جه 100 بدل 100.0
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        image: json['image'] ?? '',
        quantity: json['quantity'] ?? 1,
      );
}
