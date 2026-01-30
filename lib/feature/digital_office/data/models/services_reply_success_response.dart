import 'package:json_annotation/json_annotation.dart';

part 'services_reply_success_response.g.dart';

@JsonSerializable()
class ServicesReplySuccessResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  ServicesReplySuccessResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesReplySuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesReplySuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesReplySuccessResponseToJson(this);
}
