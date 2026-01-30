import 'package:json_annotation/json_annotation.dart';

part 'mark_notification_seen_response.g.dart';

@JsonSerializable()
class MarkNotificationSeenResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  MarkNotificationSeenResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MarkNotificationSeenResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkNotificationSeenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarkNotificationSeenResponseToJson(this);
}
