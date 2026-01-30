// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_days_and_times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkDaysAndTimes _$WorkDaysAndTimesFromJson(Map<String, dynamic> json) =>
    WorkDaysAndTimes(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkDaysAndTimesToJson(WorkDaysAndTimes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      workingSchedule: (json['workingSchedule'] as List<dynamic>?)
          ?.map((e) => WorkingSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'workingSchedule': instance.workingSchedule,
    };

WorkingSchedule _$WorkingScheduleFromJson(Map<String, dynamic> json) =>
    WorkingSchedule(
      service: json['service'] as String?,
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkingScheduleToJson(WorkingSchedule instance) =>
    <String, dynamic>{
      'service': instance.service,
      'days': instance.days,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      dayOfWeek: json['dayOfWeek'] as String?,
      timeSlots: (json['timeSlots'] as List<dynamic>?)
          ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'timeSlots': instance.timeSlots,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
