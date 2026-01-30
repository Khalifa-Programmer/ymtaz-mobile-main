import 'package:json_annotation/json_annotation.dart';

part 'check_code_response_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class CheckCodeResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  CheckCodeResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory CheckCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckCodeResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "pass_code")
  String? passCode;

  Data({
    this.passCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
