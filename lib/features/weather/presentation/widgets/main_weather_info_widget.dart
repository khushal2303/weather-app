import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/extensions/string_extension.dart';
import 'package:weather_app/core/extensions/widget_extension.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

class MainWeatherInfoWidget extends StatelessWidget {
  const MainWeatherInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final bool isLoading = state is WeatherLoading && state.isBusy;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              state.isCelsius
                                  ? state.weatherResponse?.main?.temp
                                          ?.toStringAsFixed(1) ??
                                      ''
                                  : state.weatherResponse?.main?.temp
                                          ?.toFahrenheit() ??
                                      '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 86,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              state.measurementUnit,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      state.weatherResponse?.weather?.first.description
                              ?.toTitleCase() ??
                          '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 148.0,
                width: 148.0,
                child: isLoading ||
                        (state.weatherResponse?.weather?.isEmpty ?? true)
                    ? null
                    : Image.asset(
                        state.weatherResponse?.weather?.first.main
                                ?.getWeatherImage() ??
                            "",
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
