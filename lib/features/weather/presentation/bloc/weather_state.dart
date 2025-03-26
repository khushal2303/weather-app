part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final WeatherResponse? weatherResponse;
  final bool isCelsius;
  String get measurementUnit => isCelsius ? '°C' : '°F';
  final List<WeatherResponse> forcastList;

  const WeatherState({
    this.weatherResponse,
    this.isCelsius = true,
    this.forcastList = const [],
  });

  WeatherState copyWith({
    WeatherResponse? weatherResponse,
    bool? isCelsius,
    List<WeatherResponse>? forcastList,
  }) {
    return WeatherState(
      weatherResponse: weatherResponse ?? this.weatherResponse,
      isCelsius: isCelsius ?? this.isCelsius,
      forcastList: forcastList ?? this.forcastList,
    );
  }

  @override
  List<Object?> get props => [weatherResponse, isCelsius, forcastList];
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

final class WeatherLoading extends WeatherState {
  final bool isBusy;

  const WeatherLoading({super.weatherResponse, required this.isBusy});
  @override
  List<Object?> get props => [isBusy];
}

final class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ForcastLoading extends WeatherState {
  final bool isBusy;

  const ForcastLoading({super.weatherResponse, required this.isBusy});
  @override
  List<Object?> get props => [isBusy];
}

final class ForcastError extends WeatherState {
  final String message;

  const ForcastError({required this.message, super.weatherResponse});

  @override
  List<Object?> get props => [message];
}

final class LocationPermissionError extends WeatherState {
  final String message;
  final bool isPermanentlyDenied;

  const LocationPermissionError(
      {required this.message,
      super.weatherResponse,
      this.isPermanentlyDenied = false});

  @override
  List<Object?> get props => [message];
}
