import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
