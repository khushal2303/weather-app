import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class BaseResponse {
  int? cod;
  String? message;

  BaseResponse({
    this.cod,
    this.message,
  });
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey("cod") && json['cod'] is String) {
      json['cod'] = int.parse(json['cod']);
    }
    return _$BaseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
