import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/data/home_repo/categories_repo/categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final Dio dio;

  CategoriesRepoImpl(this.dio);
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await dio.get('/api/MobileApi/categories');

      // ✅ الـ data جوا object
      final List<dynamic> data = response.data['data'];

      final categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();
      return Right(categories);
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
}
