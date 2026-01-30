// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_time_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTimeRequestModel _$WorkTimeRequestModelFromJson(
        Map<String, dynamic> json) =>
    WorkTimeRequestModel(
      times: (json['times'] as List<dynamic>?)
          ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkTimeRequestModelToJson(
        WorkTimeRequestModel instance) =>
    <String, dynamic>{
      'times': instance.times,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      service: json['service'] as String?,
      dayOfWeek: json['dayOfWeek'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      minsBetween: (json['minsBetween'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'service': instance.service,
      'dayOfWeek': instance.dayOfWeek,
      'from': instance.from,
      'to': instance.to,
      'minsBetween': instance.minsBetween,
    };
