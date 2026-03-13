import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_repo/cart_repo/cart_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';

class CartRepoImpl implements CartRepo {
  final SharedPreferences _prefs;
  static const _key = 'cart_items';

  CartRepoImpl(this._prefs);

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      final data = _prefs.getStringList(_key) ?? [];
      final items =
          data.map((e) => CartItemModel.fromJson(jsonDecode(e))).toList();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(CartItemModel item) async {
    try {
      final result = await getCartItems();
      return result.fold(
        (failure) => Left(failure),
        (items) async {
          final index = items.indexWhere((e) => e.id == item.id);
          if (index != -1) {
            items[index].quantity++;
          } else {
            items.add(item);
          }
          await _save(items);
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(String id) async {
    try {
      final result = await getCartItems();
      return result.fold(
        (failure) => Left(failure),
        (items) async {
          items.removeWhere((e) => e.id == id);
          await _save(items);
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(String id, int quantity) async {
    try {
      final result = await getCartItems();
      return result.fold(
        (failure) => Left(failure),
        (items) async {
          final index = items.indexWhere((e) => e.id == id);
          if (index != -1) {
            items[index].quantity = quantity;
            await _save(items);
          }
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await _prefs.remove(_key);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<void> _save(List<CartItemModel> items) async {
    await _prefs.setStringList(
      _key,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
