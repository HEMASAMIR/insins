import 'package:insins/features/checkout/data/models/order_model.dart';

class CheckoutRequest {
  final String customerName;
  final String customerPhone;
  final String city;
  final String address;
  final String paymentMethod;
  final List<OrderItem> items;

  CheckoutRequest({
    required this.customerName,
    required this.customerPhone,
    required this.city,
    required this.address,
    required this.paymentMethod,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customerPhone': customerPhone,
      'city': city,
      'address': address,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
