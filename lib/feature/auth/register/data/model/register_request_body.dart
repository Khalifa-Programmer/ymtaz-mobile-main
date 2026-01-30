import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class RegisterRequestBody {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'phone_code')
  final String phoneCode;

  @JsonKey(name: 'type')
  final int type;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'referred_by')
  final String? referredBy;

  RegisterRequestBody({
    required this.name,
    required this.mobile,
    required this.phoneCode,
    required this.type,
    required this.email,
    required this.password,
    this.referredBy,
  });

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
