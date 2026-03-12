import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/data/home_repo/product_details_repo/product_details_repo.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final Dio dio;
  ProductDetailsRepoImpl(this.dio);

  @override
  Future<Either<Failure, List<ProductDetailsModel>>> getProductsByCategoryId(
      int id) async {
    try {
      // ✅ نستخدم الـ Query Parameters عشان نجيب "كل" منتجات القسم
      final response = await dio.get(
        'https://incense-sa.com/api/MobileApi/products',
        queryParameters: {'categoryId': id},
      );

      log("الرد من الـ API لقسم $id: ${response.data}");

      final dynamic rawData = response.data;
      List listData = [];

      // التأكد من شكل البيانات (هل هي لستة مباشرة ولا جوه data؟)
      if (rawData is List) {
        listData = rawData;
      } else if (rawData is Map && rawData.containsKey('data')) {
        // لو الداتا عبارة عن ماب، نتأكد إن الـ 'data' اللي جواها هي اللي لستة
        var internalData = rawData['data'];
        if (internalData is List) {
          listData = internalData;
        } else if (internalData is Map) {
          // حالة خاصة لو رجع منتج واحد بس كـ Map
          return Right([
            ProductDetailsModel.fromJson(internalData as Map<String, dynamic>)
          ]);
        }
      }

      final products = listData
          .map((e) => ProductDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(products);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "خطأ في الاتصال بالسيرفر"));
    } catch (e) {
      log("Error Parsing: $e");
      return Left(ServerFailure("حدث خطأ أثناء معالجة البيانات"));
    }
  }
}
