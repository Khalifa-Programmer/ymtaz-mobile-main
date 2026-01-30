import 'package:json_annotation/json_annotation.dart';

part 'work_time_request_model.g.dart';

@JsonSerializable()
class WorkTimeRequestModel {
  @JsonKey(name: "times")
  List<Time>? times;

  WorkTimeRequestModel({
    this.times,
  });

  factory WorkTimeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeRequestModelToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: "service")
  String? service;
  @JsonKey(name: "dayOfWeek")
  String? dayOfWeek;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "minsBetween")
  int? minsBetween;

  Time({
    this.service,
    this.dayOfWeek,
    this.from,
    this.to,
    this.minsBetween,
  });

  @override
  String toString() {
    return 'Time{service: $service, dayOfWeek: $dayOfWeek, from: $from, to: $to, minsBetween: $minsBetween}';
  }

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}
