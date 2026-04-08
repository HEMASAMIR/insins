import 'package:insins/features/shipping/data/shipping_zone_model.dart';

abstract class ShippingState {}

class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingSuccess extends ShippingState {
  final List<CityData> cities;
  final CityData? selectedCity;
  ShippingSuccess(this.cities, {this.selectedCity});
}

class ShippingError extends ShippingState {
  final String message;
  ShippingError(this.message);
}
