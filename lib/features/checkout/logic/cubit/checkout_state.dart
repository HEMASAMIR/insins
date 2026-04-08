abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final Map<String, dynamic> response; // عشان تستلم الـ Order ID أو رابط Tamara
  CheckoutSuccess(this.response);
}

class CheckoutFailure extends CheckoutState {
  final String errMessage;
  CheckoutFailure(this.errMessage);
}
