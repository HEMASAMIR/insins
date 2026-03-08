import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class ApiClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return _instance!;
  }
}
