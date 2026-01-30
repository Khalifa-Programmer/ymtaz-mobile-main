import 'package:json_annotation/json_annotation.dart';

part 'verify_provider_otp_request.g.dart';

@JsonSerializable()
class VerifyProviderOtpRequest {
  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phone_code')
  int phoneCode;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'otp')
  String otp;

  VerifyProviderOtpRequest({
    required this.email,
    required this.phoneCode,
    required this.phone,
    required this.otp,
  });

  factory VerifyProviderOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyProviderOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyProviderOtpRequestToJson(this);
}
