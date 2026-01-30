import 'package:json_annotation/json_annotation.dart';

part 'work_days_and_times.g.dart';

@JsonSerializable()
class WorkDaysAndTimes {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  WorkDaysAndTimes({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory WorkDaysAndTimes.fromJson(Map<String, dynamic> json) =>
      _$WorkDaysAndTimesFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDaysAndTimesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "workingSchedule")
  List<WorkingSchedule>? workingSchedule;

  Data({
    this.workingSchedule,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class WorkingSchedule {
  @JsonKey(name: "service")
  String? service;
  @JsonKey(name: "days")
  List<Day>? days;

  WorkingSchedule({
    this.service,
    this.days,
  });

  factory WorkingSchedule.fromJson(Map<String, dynamic> json) =>
      _$WorkingScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingScheduleToJson(this);
}

@JsonSerializable()
class Day {
  @JsonKey(name: "dayOfWeek")
  String? dayOfWeek;
  @JsonKey(name: "timeSlots")
  List<TimeSlot>? timeSlots;

  Day({
    this.dayOfWeek,
    this.timeSlots,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class TimeSlot {
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;

  TimeSlot({
    this.from,
    this.to,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}
