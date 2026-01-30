import 'package:json_annotation/json_annotation.dart';

part 'resend_code.g.dart';

@JsonSerializable()
class ResendCode {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;

  ResendCode({
    this.status,
    this.code,
    this.message,
  });

  factory ResendCode.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeFromJson(json);

  Map<String, dynamic> toJson() => _$ResendCodeToJson(this);
}
