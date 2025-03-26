import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/common_widget/custom_textfield.dart';
import 'package:weather_app/core/common_widget/text_view.dart';
import 'package:weather_app/core/constants/image_constans.dart';
import 'package:weather_app/core/extensions/string_extension.dart';
import 'package:weather_app/core/extensions/widget_extension.dart';
import 'package:weather_app/core/services/permissions_service.dart';
import 'package:weather_app/di/injector.dart';
import 'package:weather_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/five_day_weather_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/main_weather_detail_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/main_weather_info_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_info_header_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>(),
      child: const WeatherPageUI(),
    );
  }
}

class WeatherPageUI extends StatefulWidget {
  const WeatherPageUI({super.key});

  @override
  State<WeatherPageUI> createState() => _WeatherPageUIState();
}

class _WeatherPageUIState extends State<WeatherPageUI>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<WeatherBloc>().add(GetWeatherByLocation());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<WeatherBloc>().add(GetWeatherByLocation());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ChangeThemeMode());
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: Column(
          children: [
            CustomSearchTextField(
              onChanged: (p0) {
                context.read<WeatherBloc>().add(GetWeatherByCityName(p0));
              },
            ),
            2.h.hSpace,
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherError) {
                  return Expanded(
                    child: ErrorWidget(
                      error: state.message,
                    ),
                  );
                }
                if (state is LocationPermissionError) {
                  return Expanded(
                    child: LocationErrorWidget(
                      error: state.message,
                      isPermanentlyDenied: state.isPermanentlyDenied,
                    ),
                  );
                }
                return Expanded(
                  child: Skeletonizer(
                    enabled: state is WeatherLoading && state.isBusy,
                    child: SingleChildScrollView(
                        child: Column(
                      spacing: 2.h,
                      children: [
                        WeatherInfoHeaderWidget(),
                        MainWeatherInfoWidget(),
                        MainWeatherDetailWidget(),
                        FiveDayWeatherWidget(),
                      ],
                    )),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String error;
  const ErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          15.h.hSpace,
          Text(
            error.toTitleCase(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          1.h.hSpace,
          Image.asset(ImageConstans.imgError),
        ],
      ),
    );
  }
}

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final bool isPermanentlyDenied;
  const LocationErrorWidget(
      {super.key, required this.error, required this.isPermanentlyDenied});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          12.h.hSpace,
          Text(
            error,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          1.h.hSpace,
          TextButton(
            onPressed: () {
              if (isPermanentlyDenied) {
                _openAppSettings(context);
              } else {
                context.read<WeatherBloc>().add(GetWeatherByLocation());
              }
            },
            child: TextView(
              "Try Again",
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(ImageConstans.imgLocError),
        ],
      ),
    );
  }

  Future<void> _openAppSettings(BuildContext context) async {
    await sl<PermissionsService>().openAppSettings();
    context.read<WeatherBloc>().add(GetWeatherByLocation());
  }
}
