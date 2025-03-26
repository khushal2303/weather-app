import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/core/api/base_response.dart';

part 'weather_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class WeatherResponse extends BaseResponse {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  String? dtTxt;

  WeatherResponse({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.dtTxt,
  });

  factory WeatherResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});
  factory Main.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Wind {
  int? speed;
  int? deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
