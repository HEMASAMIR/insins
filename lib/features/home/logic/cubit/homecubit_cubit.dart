import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;

  ProductsCubit(this.repository) : super(ProductsInitial());

  Future<void> fetchProducts() async {
    log('🔵 [ProductsCubit] fetchProducts started');
    emit(ProductsLoading());

    final result = await repository.getProducts();

    result.fold(
      (failure) {
        log('🔴 [ProductsCubit] fetchProducts FAILED: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] fetchProducts SUCCESS: ${products.length} products loaded');
        emit(ProductsLoaded(products));
      },
    );
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    log('🔵 [ProductsCubit] fetchProductsByCategory started | categoryId: $categoryId');
    emit(ProductsLoading());

    final result = categoryId == 0
        ? await repository.getProducts()
        : await repository.getProductsByCategoryId(categoryId);

    result.fold(
      (failure) {
        log('🔴 [ProductsCubit] fetchProductsByCategory FAILED | categoryId: $categoryId | error: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] fetchProductsByCategory SUCCESS | categoryId: $categoryId | ${products.length} products loaded');
        emit(ProductsLoaded(products));
      },
    );
  }

  Future<void> searchProducts({
    required int categoryId,
    String? search,
  }) async {
    log('🔵 [ProductsCubit] searchProducts started | categoryId: $categoryId | search: "$search"');
    emit(ProductsLoading());

    final result = await repository.searchProducts(
      categoryId: categoryId,
      search: search,
    );

    result.fold(
      (failure) {
        log('🔴 [ProductsCubit] searchProducts FAILED | categoryId: $categoryId | search: "$search" | error: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] searchProducts SUCCESS | categoryId: $categoryId | search: "$search" | ${products.length} products loaded');
        emit(ProductsLoaded(products));
      },
    );
  }
}
