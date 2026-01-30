import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_code_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class CheckCodeRequestBody {
  @JsonKey(name: 'token')
  final String pin_code;
  @JsonKey(name: 'email')
  final String email;

  CheckCodeRequestBody(this.pin_code, this.email);

  Map<String, dynamic> toJson() => _$CheckCodeRequestBodyToJson(this);
}
