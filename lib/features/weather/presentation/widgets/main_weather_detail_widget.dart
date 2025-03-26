import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/extensions/media_extension.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

class MainWeatherDetailWidget extends StatelessWidget {
  const MainWeatherDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return SizedBox(
          width: context.width,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12.sp,
                runSpacing: 2.h,
                children: [
                  DetailInfoTile(
                    icon: Icons.thermostat,
                    title: 'Feels Like',
                    data:
                        '${state.weatherResponse?.main?.feelsLike?.toStringAsFixed(1)}°',
                  ),
                  DetailInfoTile(
                    icon: Icons.air,
                    title: 'Wind',
                    data: '${state.weatherResponse?.wind?.speed} m/s',
                  ),
                  DetailInfoTile(
                    icon: Icons.opacity,
                    title: 'Humidity',
                    data: '${state.weatherResponse?.main?.humidity}%',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailInfoTile extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;
  const DetailInfoTile({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 14.sp,
          backgroundColor: Colors.blue,
          child: Icon(
            icon,
            color: Colors.white,
            size: 14.sp,
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w300)),
            Text(data, style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
