abstract class AddReviewState {}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewSuccess extends AddReviewState {}

class AddReviewFailure extends AddReviewState {
  final String errMessage;
  AddReviewFailure(this.errMessage);
}
