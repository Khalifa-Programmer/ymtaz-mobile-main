import 'package:json_annotation/json_annotation.dart';

part 'remove_response.g.dart';

@JsonSerializable()
class RemoveResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  RemoveResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory RemoveResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveResponseToJson(this);
}
