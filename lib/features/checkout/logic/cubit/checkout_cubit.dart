import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/checkout/data/checkout_repo/checkout_repo.dart';
import 'package:insins/features/checkout/data/models/checkout_model.dart';
import 'package:insins/features/checkout/logic/cubit/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepository checkoutRepo;

  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());

  Future<void> submitOrder(CheckoutRequest request) async {
    // 1. نغير الحالة لتحميل
    emit(CheckoutLoading());

    // 2. نستدعي الـ Repo
    final result = await checkoutRepo.submitOrder(request);

    // 3. نعالج النتيجة باستخدام fold
    result.fold(
      (failure) {
        // في حالة الخطأ
        emit(CheckoutFailure(failure.message));
      },
      (response) {
        // في حالة النجاح
        emit(CheckoutSuccess(response));
      },
    );
  }
}
