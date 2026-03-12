import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/home_data_model.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
      int categoryId);
}
