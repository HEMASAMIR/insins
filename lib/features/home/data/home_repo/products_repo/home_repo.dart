import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

abstract class ProductRepository {
  // ✅ موجودة زي ما هي
  Future<Either<Failure, List<ProductDetailsModel>>> getProducts();

  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
      int categoryId);

  Future<Either<Failure, List<ProductDetailsModel>>> searchProducts({
    required int categoryId,
    String? search,
  });

  // ✅ إضافة جديدة - جيب منتجات بالـ subCategoryId
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsBySubCategoryId(
      int subCategoryId);
}
