class ShippingZoneModel {
  final bool? success;
  final List<CityData>? data;

  ShippingZoneModel({this.success, this.data});

  factory ShippingZoneModel.fromJson(Map<String, dynamic> json) {
    return ShippingZoneModel(
      success: json['success'],
      data: json['data'] != null
          ? List<CityData>.from(json['data'].map((x) => CityData.fromJson(x)))
          : null,
    );
  }
}

class CityData {
  final int? id;
  final String? cityName;
  final double? price;

  CityData({this.id, this.cityName, this.price});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'],
      cityName: json['cityName'],
      // هنا بنعمل تحويل احتياطي عشان لو السعر جه int من الـ API ميرميش Error
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
    );
  }
}
