import 'package:json_annotation/json_annotation.dart';

part 'social_media.g.dart';

@JsonSerializable()
class SocialMedia {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  SocialMedia({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "logo")
  String? logo;

  Datum({
    this.url,
    this.name,
    this.logo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
