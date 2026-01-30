import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class LoginRequestBody {
  @JsonKey(name: "email")
  final String email;
  final String password;

  LoginRequestBody(this.email, this.password);

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
