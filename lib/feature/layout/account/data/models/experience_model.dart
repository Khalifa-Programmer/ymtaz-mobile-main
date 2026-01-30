import 'package:json_annotation/json_annotation.dart';

part 'experience_model.g.dart';

@JsonSerializable()
class ExperienceModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ExperienceModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "account_experiences")
  List<Experience>? Experiences;

  Data({
    this.Experiences,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Experience {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "from")
  DateTime? from;
  @JsonKey(name: "to")
  DateTime? to;

  Experience({
    this.id,
    this.accountId,
    this.title,
    this.company,
    this.from,
    this.to,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
