import 'package:json_annotation/json_annotation.dart';

part 'recent_joined_lawyers_model.g.dart';

@JsonSerializable()
class RecentJoinedLawyersModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  RecentJoinedLawyersModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory RecentJoinedLawyersModel.fromJson(Map<String, dynamic> json) =>
      _$RecentJoinedLawyersModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecentJoinedLawyersModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "newAdvisories")
  List<NewAdvisory>? newAdvisories;

  Data({
    this.newAdvisories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class NewAdvisory {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "profile_photo")
  String? photo;

  @JsonKey(name: "city")
  CityRel? cityRel;

  NewAdvisory({
    this.id,
    this.name,
    this.photo,
    this.cityRel,
  });

  factory NewAdvisory.fromJson(Map<String, dynamic> json) =>
      _$NewAdvisoryFromJson(json);

  Map<String, dynamic> toJson() => _$NewAdvisoryToJson(this);
}

@JsonSerializable()
class CityRel {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  CityRel({
    this.id,
    this.title,
  });

  factory CityRel.fromJson(Map<String, dynamic> json) =>
      _$CityRelFromJson(json);

  Map<String, dynamic> toJson() => _$CityRelToJson(this);
}
