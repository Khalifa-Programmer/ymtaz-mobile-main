import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class ForgetRequestBody {
  @JsonKey(name: "credential")
  final String email;
  @JsonKey(name: "type")
  final String type;

  ForgetRequestBody(this.email, this.type);

  Map<String, dynamic> toJson() => _$ForgetRequestBodyToJson(this);
}
