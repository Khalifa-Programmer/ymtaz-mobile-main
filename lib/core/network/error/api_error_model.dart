import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ApiErrorModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "errors")
  Errors? errors;

  Data({
    this.errors,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Errors {
  @JsonKey(name: "email")
  List<String>? email;
  @JsonKey(name: "degree_certificate")
  List<String>? degreeCertificate;
  @JsonKey(name: "license_file")
  List<String>? licenseFile;
  @JsonKey(name: "cv")
  List<String>? cv;

  Errors({
    this.email,
    this.degreeCertificate,
    this.licenseFile,
    this.cv,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorsToJson(this);
}
