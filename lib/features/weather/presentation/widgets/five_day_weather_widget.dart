import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/extensions/string_extension.dart';
import 'package:weather_app/core/extensions/widget_extension.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

class FiveDayWeatherWidget extends StatelessWidget {
  const FiveDayWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5-Day Forecast',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        2.h.hSpace,
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.forcastList.length,
              itemBuilder: (context, index) {
                final WeatherResponse weather = state.forcastList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            index == 0
                                ? 'Today'
                                : weather.dtTxt?.toFormatDispayDateAndTime(
                                        format: 'EEEE') ??
                                    "",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (weather.weather?.isNotEmpty ?? false) ...[
                              Image.asset(
                                weather.weather?.first.main
                                        ?.getWeatherImage() ??
                                    "",
                                fit: BoxFit.cover,
                              ),
                              6.sp.hSpace,
                            ],
                            Text(
                                weather.weather?.first.description
                                        ?.toTitleCase() ??
                                    "",
                                style: TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            !state.isCelsius
                                ? '${weather.main?.tempMin?.toFahrenheit()}°/${weather.main?.tempMax?.toFahrenheit()}°'
                                : '${weather.main?.tempMin?.toStringAsFixed(1)}°/${weather.main?.tempMax?.toStringAsFixed(1)}°',
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 12.sp.hSpace,
            );
          },
        ),
        5.h.hSpace,
      ],
    );
  }
}
