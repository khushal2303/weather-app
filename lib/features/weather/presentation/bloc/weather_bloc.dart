import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/exception/location_%20exception.dart';
import 'package:weather_app/core/services/permissions_service.dart';
import 'package:weather_app/di/injector.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';
import 'package:weather_app/features/weather/domain/usecases/get_focast_usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_city_usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_latlon_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCityUsecase _getWeatherByCityUsecase;
  final GetWeatherByLatlonUsecase _getWeatherByLatlonUsecase;
  final GetFocastUsecase _getFocastUsecase;

  WeatherBloc({
    required GetWeatherByCityUsecase getWeatherByCityUsecase,
    required GetWeatherByLatlonUsecase getWeatherByLatlonUsecase,
    required GetFocastUsecase getFocastUsecase,
  })  : _getWeatherByCityUsecase = getWeatherByCityUsecase,
        _getWeatherByLatlonUsecase = getWeatherByLatlonUsecase,
        _getFocastUsecase = getFocastUsecase,
        super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {});
    on<GetWeatherByCityName>(_getWeatherByCityName);
    on<GetWeatherByLocation>(_getWeatherByLocation);
    on<ChangeCelsiusTemprature>(_changeCelsiusTemprature);
    on<GetForcastByLocation>(_getForcastByLocation);
  }

  Future<void> _getWeatherByCityName(
      GetWeatherByCityName event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading(isBusy: true));
    if (event.cityName.trim().isEmpty) {
      add(GetWeatherByLocation());
      return;
    }
    final response = await _getWeatherByCityUsecase.call(event.cityName);
    response.when(
      success: (data) {
        emit(WeatherLoading(isBusy: false));
        emit(state.copyWith(weatherResponse: data));
        add(GetForcastByLocation(
            lat: data.coord?.lat ?? 0.0, lon: data.coord?.lon ?? 0.0));
      },
      failure: (error) {
        emit(WeatherLoading(isBusy: false));
        emit(WeatherError(error));
      },
    );
  }

  Future<void> _getWeatherByLocation(
      GetWeatherByLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading(isBusy: true));
    Position? position;

    try {
      position = await sl<PermissionsService>().requestCurrentLocation();
    } on LocationPermissionException catch (e) {
      emit(WeatherLoading(isBusy: false));
      emit(LocationPermissionError(message: e.error));
    } on LocationPermissionPermanentlyDeniedException catch (e) {
      emit(WeatherLoading(isBusy: false));
      emit(
          LocationPermissionError(message: e.error, isPermanentlyDenied: true));
    } catch (e) {
      emit(WeatherLoading(isBusy: false));
      emit(LocationPermissionError(message: e.toString()));
      return;
    }
    if (position == null) {
      return;
    }
    final response = await _getWeatherByLatlonUsecase.call(
        position.latitude, position.longitude);
    response.when(
      success: (data) {
        emit(WeatherLoading(isBusy: false));
        emit(state.copyWith(weatherResponse: data));
        add(GetForcastByLocation(
            lat: data.coord?.lat ?? 0.0, lon: data.coord?.lon ?? 0.0));
      },
      failure: (error) {
        emit(WeatherLoading(isBusy: false));
        emit(WeatherError(error));
      },
    );
  }

  Future<void> _changeCelsiusTemprature(
      ChangeCelsiusTemprature event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isCelsius: !state.isCelsius));
  }

  Future<void> _getForcastByLocation(
      GetForcastByLocation event, Emitter<WeatherState> emit) async {
    emit(ForcastLoading(isBusy: true, weatherResponse: state.weatherResponse));

    final response = await _getFocastUsecase.call(event.lat, event.lon);
    response.when(
      success: (data) {
        emit(ForcastLoading(
            isBusy: false, weatherResponse: state.weatherResponse));
        emit(state.copyWith(forcastList: data.filterDataByTimeInterval(3)));
      },
      failure: (error) {
        emit(ForcastLoading(
            isBusy: false, weatherResponse: state.weatherResponse));
        emit(ForcastError(
            message: error, weatherResponse: state.weatherResponse));
      },
    );
  }
}
