import 'package:insins/features/home/data/home_model/home_data_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

// ══════════════════════════════════════════════════════════
// Products States
// ══════════════════════════════════════════════════════════
class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
