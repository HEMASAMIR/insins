import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/home/data/add_review_model/add_review_mode.dart';
import 'package:insins/features/home/data/home_repo/add_review_repo/add_review_repo.dart';
import 'package:insins/features/home/presentaion/add_review/logic/add_review_cubit/addreview_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final AddReviewRepo addReviewRepo;

  AddReviewCubit(this.addReviewRepo) : super(AddReviewInitial());

  Future<void> addReview({required ReviewRequestModel reviewModel}) async {
    debugPrint(
        "🚨 Cubit: STARTING PROCESS"); // لو دي مطبعتش يبقى المشكلة في الزرار
    emit(AddReviewLoading());

    try {
      debugPrint("🚨 Cubit: CALLING REPO WITH DATA: ${reviewModel.toJson()}");
      var result = await addReviewRepo.addReview(reviewModel: reviewModel);

      if (isClosed) {
        debugPrint("🚨 Cubit: IS CLOSED, CANNOT EMIT");
        return;
      }

      result.fold(
        (failure) {
          debugPrint("🚨 Cubit: RECEIVED FAILURE -> ${failure.message}");
          emit(AddReviewFailure(failure.message));
        },
        (success) {
          debugPrint("🚨 Cubit: RECEIVED SUCCESS");
          emit(AddReviewSuccess());
        },
      );
    } catch (e) {
      debugPrint("🚨 Cubit: CRASHED WITH ERROR -> $e");
      emit(AddReviewFailure(e.toString()));
    }
  }
}
