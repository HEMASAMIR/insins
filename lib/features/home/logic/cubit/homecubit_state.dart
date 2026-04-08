import 'package:insins/features/home/data/home_model/product_details_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductDetailsModel> products;
  final String selectedCategoryName; // ✅ إضافة

  ProductsLoaded(
    this.products, {
    this.selectedCategoryName = 'جميع المنتجات', // ✅ default value
  });
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
