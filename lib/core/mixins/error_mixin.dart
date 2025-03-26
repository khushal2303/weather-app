import 'package:dio/dio.dart';

import '../api/api_result.dart';

mixin ErrorMixin {
  ApiResult<T> handleAPIError<T>(e) {
    try {
      if (e is DioException) {
        if (e.response?.data is Map) {
          Map<String, dynamic> response = e.response?.data ?? {};
          if (response.containsKey("cod") && response['cod'] != 200) {
            return ApiResult.failure(error: response['message']);
          } else {
            return ApiResult.failure(error: response['message']);
          }
        }
      }
      return const ApiResult.failure(error: "Something is wrong");
    } catch (e) {
      return const ApiResult.failure(error: "Something is wrong");
    }
  }
}
