import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/home/data/add_review_model/add_review_mode.dart';

abstract class AddReviewRepo {
  // بدل void هنخليها ترجع List من الموديل
  Future<Either<Failure, List<ReviewRequestModel>>> addReview(
      {required ReviewRequestModel reviewModel});
}
