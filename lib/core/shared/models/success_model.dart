import 'package:json_annotation/json_annotation.dart';

part 'success_model.g.dart';

@JsonSerializable()
class SuccessModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  SuccessModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) =>
      _$SuccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessModelToJson(this);
}
