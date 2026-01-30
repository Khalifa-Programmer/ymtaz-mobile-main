import 'package:json_annotation/json_annotation.dart';

part 'splash_response.g.dart';

@JsonSerializable()
class SplashResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  SplashResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SplashResponse.fromJson(Map<String, dynamic> json) =>
      _$SplashResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SplashResponseToJson(this);
}
