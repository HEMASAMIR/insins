import 'package:insins/features/home/data/home_model/product_details_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final List<ProductDetailsModel> products; // خليها لستة هنا

  ProductDetailsLoaded({required this.products});
}

// 4. حالة الخطأ (Error) - هنا بنعرض رسالة الخطأ أو الـ
class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}
