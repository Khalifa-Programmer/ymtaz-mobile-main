import 'package:json_annotation/json_annotation.dart';

part 'privacy_policy.g.dart';

@JsonSerializable()
class PrivacyPolicy {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PrivacyPolicy({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) =>
      _$PrivacyPolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyPolicyToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "intro")
  String? intro;
  @JsonKey(name: "description")
  String? description;

  Data({
    this.intro,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
