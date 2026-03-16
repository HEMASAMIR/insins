import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/checkout/data/checkout_repo/checkout_repo.dart';
import 'package:insins/features/checkout/data/models/checkout_model.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final Dio _dio;

  CheckoutRepositoryImpl(this._dio);
  @override
  Future<Either<Failure, Map<String, dynamic>>> submitOrder(
      CheckoutRequest request) async {
    try {
      final response = await _dio.post(
        '/api/MobileApi/checkout',
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // بنرجع الـ data اللي جاية من السيرفر كـ Map
        return Right(response.data as Map<String, dynamic>);
      } else {
        // هنا بنستخدم الـ Failure اللي عندك في المشروع
        return Left(
            ServerFailure("فشل في إتمام الطلب: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      // التعامل مع أخطاء الـ Dio بناءً على الـ Response اللي جاي من السيرفر
      return Left(ServerFailure(
          e.response?.data['message'] ?? "خطأ في الاتصال بالسيرفر"));
    } catch (e) {
      return Left(ServerFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
