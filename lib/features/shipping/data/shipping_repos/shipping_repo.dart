import 'package:dartz/dartz.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/shipping/data/shipping_zone_model.dart';

abstract class ShippingRepository {
  Future<Either<Failure, List<CityData>>> getShippingZones();
}
