import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_helpers.dart';

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: ApiHelpers.baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
    );

    this.options = options;
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.queryParameters["appid"] = ApiHelpers.apiKey;
          if (options.data is FormData) {
            log((options.data as FormData).fields.toString());
          }
          handler.next(options);
        },
        onError: (DioException e, handler) async {
          return handler.next(e);
        },
      ),
    );

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }

    httpClientAdapter = IOHttpClientAdapter();
  }
  static Dio getInstance() => AppDio._();
}
