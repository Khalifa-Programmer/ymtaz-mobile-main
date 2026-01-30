import 'package:json_annotation/json_annotation.dart';

part 'contact_ymtaz_response.g.dart';

@JsonSerializable()
class ContactYmtazResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  ContactYmtazResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory ContactYmtazResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactYmtazResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactYmtazResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reserverType")
  String? reserverType;
  @JsonKey(name: "lawyer_id")
  dynamic lawyerId;
  @JsonKey(name: "service_user_id")
  int? serviceUserId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "subject")
  String? subject;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;

  Data({
    this.reserverType,
    this.lawyerId,
    this.serviceUserId,
    this.type,
    this.subject,
    this.details,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
