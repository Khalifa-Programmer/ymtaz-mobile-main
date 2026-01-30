import 'package:json_annotation/json_annotation.dart';

part 'success_fcm_response.g.dart';

@JsonSerializable()
class SuccessFcmResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  SuccessFcmResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SuccessFcmResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessFcmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessFcmResponseToJson(this);
}
