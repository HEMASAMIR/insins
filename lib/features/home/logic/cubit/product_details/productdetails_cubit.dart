import 'package:bloc/bloc.dart';
import 'package:insins/features/home/data/home_repo/product_details_repo/product_details_repo.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_state.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsCubit(this.productDetailsRepo) : super(ProductDetailsInitial());

  // المتغيرات دي عشان نحفظ البيانات محلياً (Cache)
  int? _lastCategoryId;
  List<ProductDetailsModel>? _cachedProducts;

  Future<void> getProductsByCategoryId(int categoryId) async {
    // 1. لو بنطلب نفس القسم اللي حملناه قبل كده ومعانا بياناته، ابعتها فوراً ومتحملش تاني
    if (_lastCategoryId == categoryId && _cachedProducts != null) {
      emit(ProductDetailsLoaded(products: _cachedProducts!));
      return;
    }

    // 2. لو قسم جديد، نظهر الـ Loading ونبدأ الرحلة
    emit(ProductDetailsLoading());

    final result = await productDetailsRepo.getProductsByCategoryId(categoryId);

    result.fold(
      (failure) {
        // في حالة الخطأ بنصفر الـ ID عشان يقدر يحاول تاني
        _lastCategoryId = null;
        emit(ProductDetailsError(message: failure.message));
      },
      (productsList) {
        // 3. نجاح! نحفظ الـ ID والمنتجات في الـ Cache
        _lastCategoryId = categoryId;
        _cachedProducts = productsList;
        emit(ProductDetailsLoaded(products: productsList));
      },
    );
  }

  // دالة اختيارية لو حبيت "تجبر" التطبيق إنه يعمل ريفريش للسيرفر
  Future<void> refreshProducts(int categoryId) async {
    _lastCategoryId = null;
    _cachedProducts = null;
    await getProductsByCategoryId(categoryId);
  }
}
