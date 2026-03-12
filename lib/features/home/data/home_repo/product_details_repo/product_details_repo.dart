import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

abstract class ProductDetailsRepo {
  // لاحظ الـ List هنا
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
      int id);
}
