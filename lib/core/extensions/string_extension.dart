import 'package:weather_app/core/constants/image_constans.dart';
import 'package:weather_app/core/extensions/date_extension.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String getWeatherImage() {
    String weather = toLowerCase();
    switch (weather) {
      case 'thunderstorm':
        return ImageConstans.imgStorm;

      case 'drizzle':
      case 'rain':
        return ImageConstans.imgRainy;

      case 'snow':
        return ImageConstans.imgSnow;

      case 'clear':
        return ImageConstans.imgSunny;

      case 'clouds':
        return ImageConstans.imgCloudy;

      case 'mist':
      case 'fog':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'sand':
      case 'ash':
        return ImageConstans.imgFog;

      case 'squall':
      case 'tornado':
        return ImageConstans.imgStormWindy;

      default:
        return ImageConstans.imgCloud;
    }
  }

  String toFormatDispayDateAndTime({String? format}) {
    return DateTime.parse(this).toFormatDispayDateAndTime(format: format);
  }
}
