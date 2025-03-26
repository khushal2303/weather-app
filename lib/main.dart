import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/services/hive_service.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/di/injector.dart';
import 'package:weather_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection().init();
  await sl<HiveService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) {
        return BlocProvider(
          create: (context) => sl<ThemeBloc>(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Weather App',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.themeMode,
                home: const WeatherPage(),
              );
            },
          ),
        );
      },
    );
  }
}
