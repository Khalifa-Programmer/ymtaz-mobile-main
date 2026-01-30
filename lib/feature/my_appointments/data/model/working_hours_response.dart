import 'package:json_annotation/json_annotation.dart';

part 'working_hours_response.g.dart';

@JsonSerializable()
class WorkingHoursResponse {
  @JsonKey(name: "days")
  List<Day>? days;

  WorkingHoursResponse({
    this.days,
  });

  factory WorkingHoursResponse.fromJson(Map<String, dynamic> json) => _$WorkingHoursResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursResponseToJson(this);
}

@JsonSerializable()
class Day {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "workingHours")
  String? workingHours;
  @JsonKey(name: "availableTimes")
  List<AvailableTime>? availableTimes;

  Day({
    this.date,
    this.workingHours,
    this.availableTimes,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class AvailableTime {
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;


  @override
  String toString() {
    return 'AvailableTime{from: $from, to: $to}';
  }

  AvailableTime({
    this.from,
    this.to,
  });

  factory AvailableTime.fromJson(Map<String, dynamic> json) => _$AvailableTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableTimeToJson(this);
}
