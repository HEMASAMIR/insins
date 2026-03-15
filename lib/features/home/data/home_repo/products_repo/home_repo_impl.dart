import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Dio dio;

  ProductRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProducts() async {
    try {
      final response = await dio.get('/api/MobileApi/products');
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

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
      int categoryId) async {
    try {
      final response = await dio.get(
        '/api/MobileApi/products',
        queryParameters: {'categoryId': categoryId}, // ✅
      );
      final List<dynamic> data = response.data['data'];
      final products =
          data.map((json) => ProductDetailsModel.fromJson(json)).toList();
      return Right(products);
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      return Left(ServerFailure(e.message ?? 'Server Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> searchProducts({
    required int categoryId,
    String? search,
  }) async {
    try {
      final response = await dio.get(
        '/api/MobileApi/products',
        queryParameters: {
          'categoryId': categoryId,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      final List<dynamic> data = response.data['data'];
      final products =
          data.map((json) => ProductDetailsModel.fromJson(json)).toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
