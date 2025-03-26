import 'package:weather_app/core/api/api_result.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByCityUsecase {
  final WeatherRepository _repository;

  GetWeatherByCityUsecase({required WeatherRepository repository})
      : _repository = repository;

  Future<ApiResult<WeatherResponse>> call(String cityName) async {
    return _repository.getWeatherByCityName(cityName);
  }
}
