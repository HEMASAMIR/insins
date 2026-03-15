import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/add_review_model/add_review_mode.dart';
import 'package:insins/features/home/data/home_repo/add_review_repo/add_review_repo.dart';

class AddReviewRepoImpl implements AddReviewRepo {
  final Dio dio;
  AddReviewRepoImpl(this.dio);

  @override
  Future<Either<Failure, List<ReviewRequestModel>>> addReview(
      {required ReviewRequestModel reviewModel}) async {
    try {
      final response = await dio.post(
        '/api/MobileApi/add-review',
        data: reviewModel.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint("✅ Server Response: ${response.data}");
      return right([]); // ✅ السيرفر نجح، مش محتاج ترجع data
    } catch (e) {
      if (e is DioException) {
        debugPrint("🚨 Full Dio Error: ${e.response?.data}");
        debugPrint("🚨 Status Code: ${e.response?.statusCode}");

        // ✅ الحل: نتعامل مع كل أنواع الـ response بأمان
        String errorMessage = 'فشل في إرسال التقييم';

        final data = e.response?.data;
        if (data is Map && data['message'] != null) {
          errorMessage = data['message'].toString();
        } else if (data is String && data.isNotEmpty) {
          errorMessage = data;
        }

        return left(ServerFailure(errorMessage));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
