part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable {}

final class GetWeatherByCityName extends WeatherEvent {
  final String cityName;

  GetWeatherByCityName(this.cityName);

  @override
  List<Object> get props => [cityName];
}

final class GetWeatherByLocation extends WeatherEvent {
  @override
  List<Object> get props => [];
}

final class ChangeCelsiusTemprature extends WeatherEvent {
  @override
  List<Object> get props => [];
}

final class GetForcastByLocation extends WeatherEvent {
  final double lat, lon;

  GetForcastByLocation({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
