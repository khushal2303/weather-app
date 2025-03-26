import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/core/api/base_response.dart';
import 'package:weather_app/core/services/hive_service.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';

abstract class WeatherLocalDatasource {
  Future<Response> getLastWeather();

  Future<void> saveLastWeather(WeatherResponse response);
}

class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  final HiveService _hiveService;

  WeatherLocalDatasourceImpl({required HiveService hiveService})
      : _hiveService = hiveService;
  @override
  Future<Response> getLastWeather() {
    final String? weatherData =
        _hiveService.getData(HiveKey.weatherData, defaultValue: null);
    if (weatherData != null) {
      Response response = Response(
        requestOptions: RequestOptions(path: ""),
        data: jsonDecode(weatherData),
      );
      return Future.value(response);
    }
    return Future.error(
      Response(
        requestOptions: RequestOptions(path: ""),
        data: BaseResponse(cod: 404, message: "No data found").toJson(),
      ),
    );
  }

  @override
  Future<void> saveLastWeather(WeatherResponse response) async {
    await _hiveService.addData(
        HiveKey.weatherData, jsonEncode(response.toJson()));
  }
}
