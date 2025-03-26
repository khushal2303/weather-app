import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/core/api/base_response.dart';
import 'package:weather_app/features/weather/data/models/weather_response.dart';

part 'forcast_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class ForcastResponse extends BaseResponse {
  List<WeatherResponse>? list;

  ForcastResponse({this.list});

  factory ForcastResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey("cod") && json['cod'] is String) {
      json['cod'] = int.parse(json['cod']);
    }
    if (json.containsKey("message") && json['message'] is num) {
      json['message'] = json['message'].toString();
    }
    return _$ForcastResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ForcastResponseToJson(this);

  List<WeatherResponse> filterDataByTimeInterval(int intervalHours) {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    int startHour = currentHour - (currentHour % intervalHours);
    int endHour = startHour + intervalHours;

    return (list ?? []).where((item) {
      String dtTxt = item.dtTxt ?? '';
      String time = dtTxt.split(' ')[1].substring(0, 2);
      int hour = int.parse(time);

      return hour >= startHour && hour < endHour;
    }).toList();
  }
}
