import 'package:json_annotation/json_annotation.dart';

part 'about_ymtaz.g.dart';

@JsonSerializable()
class AboutYmtaz {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AboutYmtaz({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AboutYmtaz.fromJson(Map<String, dynamic> json) =>
      _$AboutYmtazFromJson(json);

  Map<String, dynamic> toJson() => _$AboutYmtazToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "intro")
  String? intro;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "servicesCount")
  int? servicesCount;
  @JsonKey(name: "clients")
  int? clients;
  @JsonKey(name: "countries")
  int? countries;

  Data({
    this.intro,
    this.description,
    this.servicesCount,
    this.clients,
    this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
