import 'package:json_annotation/json_annotation.dart';

part 'verify_provider_response.g.dart';

@JsonSerializable()
class VerifyResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;

  VerifyResponse({
    this.status,
    this.code,
    this.message,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}
