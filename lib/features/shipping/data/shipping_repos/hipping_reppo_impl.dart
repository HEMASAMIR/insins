import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:insins/core/errors/failure.dart';
import 'package:insins/features/shipping/data/shipping_repos/shipping_repo.dart';
import 'package:insins/features/shipping/data/shipping_zone_model.dart';

class ShippingRepositoryImpl implements ShippingRepository {
  final Dio dio;

  ShippingRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, List<CityData>>> getShippingZones() async {
    try {
      final response =
          await dio.get("${AppConstants.baseUrl}/api/MobileApi/shipping-zones");

      if (response.statusCode == 200) {
        final model = ShippingZoneModel.fromJson(response.data);

        if (model.success == true && model.data != null) {
          return Right(model.data!);
        } else {
          return Left(ServerFailure("فشل في استرجاع قائمة المدن"));
        }
      } else {
        return Left(ServerFailure("خطأ في الاتصال بالسيرفر"));
      }
    } on DioException catch (e) {
      // تحويل خطأ Dio لـ ServerFailure
      return Left(ServerFailure(e.message ?? "حدث خطأ في الشبكة"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
