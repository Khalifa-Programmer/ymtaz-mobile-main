import 'package:json_annotation/json_annotation.dart';

part 'points_rules.g.dart';

@JsonSerializable()
class PointsRules {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PointsRules({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory PointsRules.fromJson(Map<String, dynamic> json) =>
      _$PointsRulesFromJson(json);

  Map<String, dynamic> toJson() => _$PointsRulesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "activities")
  List<Activity>? activities;

  Data({
    this.activities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Activity {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "experience_points")
  String? experiencePoints;

  Activity({
    this.id,
    this.name,
    this.experiencePoints,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
