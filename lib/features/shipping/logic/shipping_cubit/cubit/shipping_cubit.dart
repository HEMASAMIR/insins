import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/features/shipping/data/shipping_repos/shipping_repo.dart';
import 'package:insins/features/shipping/data/shipping_zone_model.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  final ShippingRepository shippingRepository;

  ShippingCubit(this.shippingRepository) : super(ShippingInitial());

  List<CityData> _allCities = [];

  // دالة لجلب المدن من الـ API
  Future<void> fetchCities() async {
    print("1. [Cubit] بدأت عملية الجلب...");
    emit(ShippingLoading());

    final result = await shippingRepository.getShippingZones();

    result.fold(
      (failure) {
        print("2. [Cubit] فشل Repository: ${failure.message}");
        emit(ShippingError(failure.message));
      },
      (cities) {
        log("2. [Cubit] نجاح! عدد المدن اللي رجعت: ${cities.length}");
        if (cities.isEmpty) {
          log("⚠️ تحذير: السيرفر رجع قائمة فاضية []");
        }
        _allCities = cities;
        emit(ShippingSuccess(cities));
      },
    );
  }

  // دالة لتغيير المدينة المختارة وتحديث الـ UI بالسعر الجديد
  void selectCity(String cityName) {
    // بنبحث عن المدينة في القائمة اللي معانا
    final selected = _allCities.firstWhere(
      (city) {
        log("City: ${city.cityName}");
        return city.cityName == cityName;
      },
      orElse: () {
        log("City not found: $cityName");
        return _allCities.first;
      },
    );

    // لازم نبعت الـ _allCities تاني عشان الـ BlocBuilder يرسم الـ Dropdown صح
    emit(ShippingSuccess(_allCities, selectedCity: selected));
  }
}
