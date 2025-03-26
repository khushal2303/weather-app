import 'package:weather_app/core/api/api_result.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByLatlonUsecase {
  final WeatherRepository _repository;

  GetWeatherByLatlonUsecase({required WeatherRepository repository})
      : _repository = repository;

  Future<ApiResult<WeatherResponse>> call(double lat, double lon) async {
    return await _repository.getWeatherByLocation(lat, lon);
  }
}
