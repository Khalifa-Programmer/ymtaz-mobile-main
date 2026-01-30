import 'package:json_annotation/json_annotation.dart';

part 'invites_model.g.dart';

@JsonSerializable()
class InvitesModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  InvitesModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory InvitesModel.fromJson(Map<String, dynamic> json) =>
      _$InvitesModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "status")
  int? status;

  Datum({
    this.id,
    this.email,
    this.phone,
    this.phoneCode,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
