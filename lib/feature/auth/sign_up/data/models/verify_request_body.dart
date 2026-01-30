import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class VerifyRequestBody {
  @JsonKey(name: "otp_code")
  final String code;
  @JsonKey(name: "client_id")
  final String clientid;

  VerifyRequestBody(this.code, this.clientid);

  Map<String, dynamic> toJson() => _$VerifyRequestBodyToJson(this);
}
