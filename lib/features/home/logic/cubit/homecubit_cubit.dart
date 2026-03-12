import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;

  ProductsCubit(this.repository) : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductsLoading());

    final result = await repository.getProducts();

    result.fold(
      (failure) => emit(ProductsError(failure.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }
}


/**
 * import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/data/home_model/home_data_model.dart';
import 'package:insins/features/home/data/home_repo/home_repo.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;

  ProductsCubit(this.repository) : super(ProductsInitial());

  // ✅ نجيب الاتنين مع بعض في نفس الوقت
  Future<void> fetchAll() async {
    emit(HomeLoading());

    final productsResult = await repository.getProducts();
    final categoriesResult = await repository.getCategories();

    // لو في error في أي واحد فيهم
    final failure = productsResult.fold((f) => f, (_) => null) ??
        categoriesResult.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(HomeError(failure.message));
      return;
    }

    final products = productsResult.getOrElse(() => <ProductModel>[]);
    final categories = categoriesResult.getOrElse(() => <CategoryModel>[]);

    emit(HomeLoaded(products: products, categories: categories));
  }
}
 */