import 'package:insins/features/home/data/cart_model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double totalPrice;

  CartLoaded({required this.items})
      : totalPrice =
            items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
