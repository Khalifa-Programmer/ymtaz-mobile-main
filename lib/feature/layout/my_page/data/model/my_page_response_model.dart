import 'package:json_annotation/json_annotation.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';

part 'my_page_response_model.g.dart';

@JsonSerializable()
class MyPageResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyPageResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyPageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyPageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "analytics")
  OfficeData? analytics;

  Data({
    this.analytics,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
