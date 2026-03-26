import 'package:json_annotation/json_annotation.dart';

part 'agora_token_request.g.dart';

@JsonSerializable()
class AgoraTokenRequest {
  final String channel;

  AgoraTokenRequest({required this.channel});

  factory AgoraTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenRequestToJson(this);
}
