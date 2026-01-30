import 'package:json_annotation/json_annotation.dart';

part 'verify_provider_request.g.dart';

@JsonSerializable()
class VerifyProviderRequest {
  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phone_code')
  int phoneCode;

  @JsonKey(name: 'phone')
  String phone;

  VerifyProviderRequest({
    required this.email,
    required this.phoneCode,
    required this.phone,
  });

  factory VerifyProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyProviderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyProviderRequestToJson(this);
}
