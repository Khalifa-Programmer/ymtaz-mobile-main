import 'package:json_annotation/json_annotation.dart';

part 'call_model.g.dart';

@JsonSerializable()
class CallModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "caller_id")
  final int? callerId;
  @JsonKey(name: "receiver_id")
  final int? receiverId;
  @JsonKey(name: "type")
  final String? type; // audio or video
  @JsonKey(name: "channel_name")
  final String? channelName;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "status")
  final String? status; // calling, ringing, accepted, rejected, missed, ended
  @JsonKey(name: "created_at")
  final String? createdAt;

  CallModel({
    this.id,
    this.callerId,
    this.receiverId,
    this.type,
    this.channelName,
    this.token,
    this.status,
    this.createdAt,
  });

  factory CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);

  Map<String, dynamic> toJson() => _$CallModelToJson(this);
}
