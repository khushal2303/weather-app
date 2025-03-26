import 'package:weather_app/core/api/api_result.dart';
import 'package:weather_app/features/weather/data/models/forcast_response.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';

abstract class WeatherRepository {
  Future<ApiResult<WeatherResponse>> getWeatherByCityName(String cityName);

  Future<ApiResult<WeatherResponse>> getWeatherByLocation(
      double lat, double lon);

  Future<ApiResult<ForcastResponse>> getForcast(double lat, double lon);
}
