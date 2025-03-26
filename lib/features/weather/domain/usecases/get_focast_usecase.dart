import 'package:weather_app/core/api/api_result.dart';
import 'package:weather_app/features/weather/data/models/forcast_response.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetFocastUsecase {
  final WeatherRepository _repository;

  GetFocastUsecase({required WeatherRepository repository})
      : _repository = repository;

  Future<ApiResult<ForcastResponse>> call(double lat, double lon) async {
    return _repository.getForcast(lat, lon);
  }
}
