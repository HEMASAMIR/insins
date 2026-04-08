// import 'dart:developer';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:insins/features/home/data/home_model/product_details_model.dart';
// import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';
// import 'package:insins/features/home/logic/cubit/homecubit_state.dart';

// class ProductsCubit extends Cubit<ProductsState> {
//   final ProductRepository repository;

//   // ✅ النوع صريح دلوقتي
//   List<ProductDetailsModel> _allProducts = [];

//   ProductsCubit(this.repository) : super(ProductsInitial());

//   Future<void> fetchProducts() async {
//     log('🔵 [ProductsCubit] fetchProducts started');
//     emit(ProductsLoading());

//     final result = await repository.getProducts();

//     result.fold(
//       (failure) {
//         log('🔴 [ProductsCubit] fetchProducts FAILED: ${failure.message}');
//         emit(ProductsError(failure.message));
//       },
//       (products) {
//         log('🟢 [ProductsCubit] fetchProducts SUCCESS: ${products.length} products loaded');
//         _allProducts = products;
//         emit(ProductsLoaded(products));
//       },
//     );
//   }

//   void filterByCategory(String categoryName) {
//     if (_allProducts.isEmpty) return;

//     log('🔵 [ProductsCubit] filterByCategory: $categoryName');

//     if (categoryName == 'جميع المنتجات') {
//       emit(ProductsLoaded(
//         List<ProductDetailsModel>.from(_allProducts),
//         selectedCategoryName: 'جميع المنتجات',
//       ));
//     } else {
//       final filtered =
//           _allProducts.where((p) => p.categoryName == categoryName).toList();

//       log('🟢 [ProductsCubit] filtered: ${filtered.length} products for "$categoryName"');

//       emit(ProductsLoaded(
//         filtered,
//         selectedCategoryName: categoryName,
//       ));
//     }
//   }

//   Future<void> fetchProductsByCategory(int categoryId) async {
//     log('🔵 [ProductsCubit] fetchProductsByCategory started | categoryId: $categoryId');
//     emit(ProductsLoading());

//     final result = categoryId == 0
//         ? await repository.getProducts()
//         : await repository.getProductsByCategoryId(categoryId);

//     result.fold(
//       (failure) {
//         log('🔴 [ProductsCubit] fetchProductsByCategory FAILED: ${failure.message}');
//         emit(ProductsError(failure.message));
//       },
//       (products) {
//         log('🟢 [ProductsCubit] fetchProductsByCategory SUCCESS: ${products.length} products');
//         emit(ProductsLoaded(products));
//       },
//     );
//   }

//   Future<void> fetchProductsBySubCategory(int subCategoryId) async {
//     log('🔵 [ProductsCubit] fetchProductsBySubCategory started | subCategoryId: $subCategoryId');
//     emit(ProductsLoading());

//     final result = subCategoryId == 0
//         ? await repository.getProducts()
//         : await repository.getProductsBySubCategoryId(subCategoryId);

//     result.fold(
//       (failure) {
//         log('🔴 [ProductsCubit] fetchProductsBySubCategory FAILED: ${failure.message}');
//         emit(ProductsError(failure.message));
//       },
//       (products) {
//         log('🟢 [ProductsCubit] fetchProductsBySubCategory SUCCESS: ${products.length} products');
//         emit(ProductsLoaded(products));
//       },
//     );
//   }

//   Future<void> searchProducts({
//     required int categoryId,
//     String? search,
//   }) async {
//     log('🔵 [ProductsCubit] searchProducts started | categoryId: $categoryId | search: "$search"');
//     emit(ProductsLoading());

//     final result = await repository.searchProducts(
//       categoryId: categoryId,
//       search: search,
//     );

//     result.fold(
//       (failure) {
//         log('🔴 [ProductsCubit] searchProducts FAILED: ${failure.message}');
//         emit(ProductsError(failure.message));
//       },
//       (products) {
//         log('🟢 [ProductsCubit] searchProducts SUCCESS: ${products.length} products');
//         emit(ProductsLoaded(products));
//       },
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;

  List<ProductDetailsModel> _allProducts = [];

  // ✅ نحفظ الفلتر الحالي عشان لو راح الهوم ورجع يلاقي نفس القسم
  String _selectedCategoryName = 'جميع المنتجات';

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
        _allProducts = products;

        // ✅ لو في فلتر محفوظ - طبّقه على الداتا الجديدة
        if (_selectedCategoryName == 'جميع المنتجات') {
          emit(ProductsLoaded(
            products,
            selectedCategoryName: 'جميع المنتجات',
          ));
        } else {
          final filtered = _allProducts
              .where((p) => p.categoryName == _selectedCategoryName)
              .toList();

          log('🟢 [ProductsCubit] re-applied filter "$_selectedCategoryName": ${filtered.length} products');

          emit(ProductsLoaded(
            filtered,
            selectedCategoryName: _selectedCategoryName,
          ));
        }
      },
    );
  }

  void filterByCategory(String categoryName) {
    if (_allProducts.isEmpty) return;

    log('🔵 [ProductsCubit] filterByCategory: $categoryName');

    // ✅ احفظ الفلتر الجديد
    _selectedCategoryName = categoryName;

    if (categoryName == 'جميع المنتجات') {
      emit(ProductsLoaded(
        List<ProductDetailsModel>.from(_allProducts),
        selectedCategoryName: 'جميع المنتجات',
      ));
    } else {
      final filtered =
          _allProducts.where((p) => p.categoryName == categoryName).toList();

      log('🟢 [ProductsCubit] filtered: ${filtered.length} products for "$categoryName"');

      emit(ProductsLoaded(
        filtered,
        selectedCategoryName: categoryName,
      ));
    }
  }

  // ✅ لو حابب تعمل reset يدوي للفلتر من أي مكان
  void clearFilter() {
    _selectedCategoryName = 'جميع المنتجات';
    if (_allProducts.isNotEmpty) {
      emit(ProductsLoaded(
        List<ProductDetailsModel>.from(_allProducts),
        selectedCategoryName: 'جميع المنتجات',
      ));
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    log('🔵 [ProductsCubit] fetchProductsByCategory started | categoryId: $categoryId');
    emit(ProductsLoading());

    final result = categoryId == 0
        ? await repository.getProducts()
        : await repository.getProductsByCategoryId(categoryId);

    result.fold(
      (failure) {
        log('🔴 [ProductsCubit] fetchProductsByCategory FAILED: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] fetchProductsByCategory SUCCESS: ${products.length} products');
        emit(ProductsLoaded(products));
      },
    );
  }

  Future<void> fetchProductsBySubCategory(int subCategoryId) async {
    log('🔵 [ProductsCubit] fetchProductsBySubCategory started | subCategoryId: $subCategoryId');
    emit(ProductsLoading());

    final result = subCategoryId == 0
        ? await repository.getProducts()
        : await repository.getProductsBySubCategoryId(subCategoryId);

    result.fold(
      (failure) {
        log('🔴 [ProductsCubit] fetchProductsBySubCategory FAILED: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] fetchProductsBySubCategory SUCCESS: ${products.length} products');
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
        log('🔴 [ProductsCubit] searchProducts FAILED: ${failure.message}');
        emit(ProductsError(failure.message));
      },
      (products) {
        log('🟢 [ProductsCubit] searchProducts SUCCESS: ${products.length} products');
        emit(ProductsLoaded(products));
      },
    );
  }
}
