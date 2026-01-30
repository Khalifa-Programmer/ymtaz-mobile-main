import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class ResetPasswordRequestBody {
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: 'token')
  final String otpCode;

  ResetPasswordRequestBody(this.password, this.email, this.otpCode);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
