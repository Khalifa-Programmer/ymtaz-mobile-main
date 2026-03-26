import 'package:json_annotation/json_annotation.dart';

part 'agora_token_response.g.dart';

@JsonSerializable()
class AgoraTokenResponse {
  final String? token;
  final String? channel;

  AgoraTokenResponse({this.token, this.channel});

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenResponseToJson(this);
}
