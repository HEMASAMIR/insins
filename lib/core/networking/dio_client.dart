import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;


  static initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    dio!.interceptors.add(PrettyDioLogger());
  }

  getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio!.get(endPoint, queryParameters: query);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
      rethrow;
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      rethrow;
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
      rethrow;
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      rethrow;
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.put(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log("Dio PUT Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio PUT Error: ${e.message}");
      }
      rethrow;
    } catch (e) {
      log("Unexpected PUT Error: ${e.toString()}");
      rethrow;
    }
  }
}
