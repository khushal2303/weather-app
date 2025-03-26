import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/api/app_dio.dart';
import 'package:weather_app/core/services/hive_service.dart';
import 'package:weather_app/core/services/permissions_service.dart';
import 'package:weather_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_focast_usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_city_usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_latlon_usecase.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  Future<void> init() async {
    sl.registerLazySingleton<PermissionsService>(
        () => PermissionsServiceImpl());

    sl.registerLazySingleton<Dio>(() => AppDio.getInstance());

    sl.registerLazySingleton<HiveService>(() => HiveService());

    /* ==================== Theme Start ======================== **/

    // Weather BLoC
    sl.registerFactory<ThemeBloc>(
      () => ThemeBloc(),
    );

    /* ==================== Theme End ======================== **/

    /* ==================== Weather Start ======================== **/

    // Weather BLoC
    sl.registerFactory<WeatherBloc>(
      () => WeatherBloc(
        getWeatherByCityUsecase: sl(),
        getWeatherByLatlonUsecase: sl(),
        getFocastUsecase: sl(),
      ),
    );

    // Weather Usecases
    sl.registerLazySingleton<GetWeatherByCityUsecase>(
      () => GetWeatherByCityUsecase(
        repository: sl(),
      ),
    );
    sl.registerLazySingleton<GetWeatherByLatlonUsecase>(
      () => GetWeatherByLatlonUsecase(
        repository: sl(),
      ),
    );
    sl.registerLazySingleton<GetFocastUsecase>(
      () => GetFocastUsecase(
        repository: sl(),
      ),
    );

    // Repository
    sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        remoteDatasource: sl(),
        localDatasource: sl(),
      ),
    );

    // Datasources
    sl.registerLazySingleton<WeatherRemoteDatasource>(
      () => WeatherRemoteDatasourceImpl(
        dio: sl(),
      ),
    );
    sl.registerLazySingleton<WeatherLocalDatasource>(
      () => WeatherLocalDatasourceImpl(
        hiveService: sl(),
      ),
    );
    /* ==================== Weather End ======================== **/
  }
}
