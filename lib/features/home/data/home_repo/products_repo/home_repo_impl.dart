import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Dio dio;

  ProductRepositoryImpl(this.dio);

  // ─── Helper ────────────────────────────────────────────────────────────────
  // بدل ما نكرر نفس الكود في كل method
  Future<Either<Failure, List<ProductDetailsModel>>> _fetchProducts({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        '/api/MobileApi/products',
        queryParameters: queryParameters,
      );
      final List<dynamic> data = response.data['data'];
      final products =
          data.map((json) => ProductDetailsModel.fromJson(json)).toList();
      return Right(products);
    } on DioException catch (e) {
      if (e.response != null) {
        log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
      return Left(ServerFailure(e.message ?? 'Server Error'));
    } catch (e) {
      log("Unknown Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  // ─── Methods ───────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProducts() =>
      _fetchProducts();

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
    int categoryId,
  ) =>
      _fetchProducts(
        queryParameters: {'categoryId': categoryId},
      );

  // ✅ إضافة جديدة - فلترة بالـ subCategoryId
  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsBySubCategoryId(
    int subCategoryId,
  ) =>
      _fetchProducts(
        queryParameters: {'subCategoryId': subCategoryId},
      );

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> searchProducts({
    required int categoryId,
    String? search,
  }) =>
      _fetchProducts(
        queryParameters: {
          'categoryId': categoryId,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
}
