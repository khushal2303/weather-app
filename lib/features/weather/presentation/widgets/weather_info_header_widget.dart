import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/extensions/date_extension.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

class WeatherInfoHeaderWidget extends StatelessWidget {
  static double boxWidth = 28.sp;
  static double boxHeight = 24.sp;

  const WeatherInfoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      "${state.weatherResponse?.name}, ${state.weatherResponse?.sys?.country}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  FittedBox(
                    child: Text(
                      DateTime.now().toFormatDispayDateAndTime(),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context
                          .read<WeatherBloc>()
                          .add(ChangeCelsiusTemprature()),
                      child: Container(
                        height: boxHeight,
                        width: boxWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: state.isCelsius
                              ? Colors.blue
                              : Colors.grey.shade200,
                        ),
                        child: Text(
                          '°C',
                          style: TextStyle(
                              fontSize: 16,
                              color: state.isCelsius
                                  ? Colors.white
                                  : Colors.grey.shade600),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context
                          .read<WeatherBloc>()
                          .add(ChangeCelsiusTemprature()),
                      child: Container(
                        height: boxHeight,
                        width: boxWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: !state.isCelsius
                              ? Colors.blue
                              : Colors.grey.shade200,
                        ),
                        child: Text(
                          '°F',
                          style: TextStyle(
                              fontSize: 16,
                              color: !state.isCelsius
                                  ? Colors.white
                                  : Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
