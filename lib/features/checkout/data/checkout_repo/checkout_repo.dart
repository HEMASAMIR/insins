import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/checkout/data/models/checkout_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, Map<String, dynamic>>> submitOrder(
      CheckoutRequest request);
}
