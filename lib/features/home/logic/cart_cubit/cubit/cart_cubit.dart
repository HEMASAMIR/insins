import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/data/home_repo/cart_repo/cart_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _repo;

  CartCubit(this._repo) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    final result = await _repo.getCartItems();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items: items)),
    );
  }

  Future<void> addToCart(CartItemModel item) async {
    final result = await _repo.addToCart(item);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => loadCart(),
    );
  }

  Future<void> removeFromCart(String id) async {
    final result = await _repo.removeFromCart(id);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => loadCart(),
    );
  }

  Future<void> updateQuantity(String id, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(id);
    } else {
      final result = await _repo.updateQuantity(id, quantity);
      result.fold(
        (failure) => emit(CartError(failure.message)),
        (_) => loadCart(),
      );
    }
  }

  Future<void> clearCart() async {
    final result = await _repo.clearCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => emit(CartLoaded(items: [])),
    );
  }
}
