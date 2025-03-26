import 'package:weather_app/core/api/api_result.dart';
import 'package:weather_app/core/mixins/error_mixin.dart';
import 'package:weather_app/core/mixins/internet_connection_mixin.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/models/forcast_response.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl
    with ErrorMixin, InternetConnectionMixin
    implements WeatherRepository {
  final WeatherRemoteDatasource _remoteDatasource;
  final WeatherLocalDatasource _localDatasource;

  WeatherRepositoryImpl(
      {required WeatherRemoteDatasource remoteDatasource,
      required WeatherLocalDatasource localDatasource})
      : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<ApiResult<WeatherResponse>> getWeatherByCityName(
      String cityName) async {
    try {
      final bool hasInternet = await checkInternetConnection();
      final result = hasInternet
          ? await _remoteDatasource.getWeatherByCityName(cityName)
          : await _localDatasource.getLastWeather();
      WeatherResponse response = WeatherResponse.fromJson(result.data);
      if (response.cod == 200) {
        if (hasInternet) {
          _localDatasource.saveLastWeather(response);
        }
        return ApiResult.success(data: response);
      }
      return ApiResult.failure(error: response.message ?? "");
    } catch (e) {
      return handleAPIError<WeatherResponse>(e);
    }
  }

  @override
  Future<ApiResult<WeatherResponse>> getWeatherByLocation(
      double lat, double lon) async {
    try {
      final bool hasInternet = await checkInternetConnection();
      final result = hasInternet
          ? await _remoteDatasource.getWeatherByLocation(lat, lon)
          : await _localDatasource.getLastWeather();
      WeatherResponse response = WeatherResponse.fromJson(result.data);
      if (response.cod == 200) {
        if (hasInternet) {
          await _localDatasource.saveLastWeather(response);
        }
        return ApiResult.success(data: response);
      }
      return ApiResult.failure(error: response.message ?? "");
    } catch (e) {
      return handleAPIError<WeatherResponse>(e);
    }
  }

  @override
  Future<ApiResult<ForcastResponse>> getForcast(double lat, double lon) async {
    try {
      final result = await _remoteDatasource.getForcast(lat, lon);
      ForcastResponse response = ForcastResponse.fromJson(result.data);
      if (response.cod == 200) {
        return ApiResult.success(data: response);
      }
      return ApiResult.failure(error: response.message ?? "");
    } catch (e) {
      return handleAPIError<ForcastResponse>(e);
    }
  }
}
