import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartItemModel>>> getCartItems();
  Future<Either<Failure, void>> addToCart(CartItemModel item);
  Future<Either<Failure, void>> removeFromCart(String id);
  Future<Either<Failure, void>> updateQuantity(String id, int quantity);
  Future<Either<Failure, void>> clearCart();
}
