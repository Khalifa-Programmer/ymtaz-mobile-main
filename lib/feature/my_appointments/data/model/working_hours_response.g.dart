// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHoursResponse _$WorkingHoursResponseFromJson(
        Map<String, dynamic> json) =>
    WorkingHoursResponse(
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkingHoursResponseToJson(
        WorkingHoursResponse instance) =>
    <String, dynamic>{
      'days': instance.days,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      workingHours: json['workingHours'] as String?,
      availableTimes: (json['availableTimes'] as List<dynamic>?)
          ?.map((e) => AvailableTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'workingHours': instance.workingHours,
      'availableTimes': instance.availableTimes,
    };

AvailableTime _$AvailableTimeFromJson(Map<String, dynamic> json) =>
    AvailableTime(
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$AvailableTimeToJson(AvailableTime instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
