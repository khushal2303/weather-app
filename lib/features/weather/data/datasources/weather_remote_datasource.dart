import 'package:dio/dio.dart';
import 'package:weather_app/core/api/api_helpers.dart';

abstract class WeatherRemoteDatasource {
  Future<Response> getWeatherByCityName(String cityName);

  Future<Response> getWeatherByLocation(double lat, double lon);

  Future<Response> getForcast(double lat, double lon);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Dio _dio;

  WeatherRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Response> getWeatherByCityName(String cityName) {
    return _dio.get(
      ApiHelpers.weather,
      queryParameters: {
        "q": cityName,
        "units": "metric",
      },
    );
  }

  @override
  Future<Response> getWeatherByLocation(double lat, double lon) {
    return _dio.get(
      ApiHelpers.weather,
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "units": "metric",
      },
    );
  }

  @override
  Future<Response> getForcast(double lat, double lon) {
    return _dio.get(
      ApiHelpers.forecast,
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "units": "metric",
      },
    );
  }
}
