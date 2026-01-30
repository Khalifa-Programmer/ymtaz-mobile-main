import 'package:json_annotation/json_annotation.dart';

part 'forget_response_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class ForgetResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  ForgetResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ForgetResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetResponseToJson(this);
}

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
