import 'package:bloc/bloc.dart';
import 'package:insins/features/home/data/home_repo/product_details_repo/product_details_repo.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsCubit(this.productDetailsRepo) : super(ProductDetailsInitial());

  Future<void> getProductsByCategoryId(int categoryId) async {
    emit(ProductDetailsLoading());

    // بننادي الميثود اللي بترجع List
    final result = await productDetailsRepo.getProductsByCategoryId(categoryId);

    result.fold(
      (failure) => emit(ProductDetailsError(message: failure.message)),
      (productsList) => emit(
          ProductDetailsLoaded(products: productsList)), // المنتجات وصلت هنا
    );
  }
}
