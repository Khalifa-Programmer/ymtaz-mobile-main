import 'package:json_annotation/json_annotation.dart';

part 'work_time_response_model.g.dart';

@JsonSerializable()
class WorkTimeResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  WorkTimeResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory WorkTimeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeResponseModelToJson(this);
}
