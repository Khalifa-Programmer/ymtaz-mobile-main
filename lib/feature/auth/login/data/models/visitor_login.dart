import 'package:json_annotation/json_annotation.dart';

part 'visitor_login.g.dart';

@JsonSerializable()
class VisitorLogin {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  VisitorLogin({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory VisitorLogin.fromJson(Map<String, dynamic> json) =>
      _$VisitorLoginFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorLoginToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "visitor")
  Visitor? visitor;

  Data({
    this.visitor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Visitor {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  dynamic mobile;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "google_id")
  String? googleId;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "token")
  String? token;

  Visitor({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.googleId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.token,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) =>
      _$VisitorFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorToJson(this);
}
