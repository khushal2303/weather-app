// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forcast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForcastResponse _$ForcastResponseFromJson(Map<String, dynamic> json) =>
    ForcastResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..cod = (json['cod'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForcastResponseToJson(ForcastResponse instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'list': instance.list?.map((e) => e.toJson()).toList(),
    };
