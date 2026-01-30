import 'package:json_annotation/json_annotation.dart';

part 'my_contact_ymtaz_Response.g.dart';

@JsonSerializable()
class MyContactYmtazResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  MyContactYmtazResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory MyContactYmtazResponse.fromJson(Map<String, dynamic> json) =>
      _$MyContactYmtazResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyContactYmtazResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "contactRequests")
  List<ContactRequest>? contactRequests;

  Data({
    this.contactRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ContactRequest {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reserverType")
  String? reserverType;
  @JsonKey(name: "service_user_id")
  int? serviceUserId;
  @JsonKey(name: "lawyer_id")
  dynamic lawyerId;
  @JsonKey(name: "subject")
  String? subject;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "reply_subject")
  dynamic replySubject;
  @JsonKey(name: "reply_description")
  dynamic replyDescription;
  @JsonKey(name: "reply_user_id")
  dynamic replyUserId;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "user")
  dynamic user;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "client")
  Client? client;

  ContactRequest({
    this.id,
    this.reserverType,
    this.serviceUserId,
    this.lawyerId,
    this.subject,
    this.details,
    this.type,
    this.replySubject,
    this.replyDescription,
    this.replyUserId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.lawyer,
    this.client,
  });

  factory ContactRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRequestToJson(this);
}

@JsonSerializable()
class Client {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "country_id")
  int? countryId;
  @JsonKey(name: "city_id")
  String? cityId;
  @JsonKey(name: "username")
  dynamic username;
  @JsonKey(name: "myname")
  String? myname;
  @JsonKey(name: "image")
  dynamic image;
  @JsonKey(name: "mobil")
  String? mobil;
  @JsonKey(name: "nationality_id")
  String? nationalityId;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "pass_code")
  dynamic passCode;
  @JsonKey(name: "pass_reset")
  int? passReset;
  @JsonKey(name: "accept_rules")
  dynamic acceptRules;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "active")
  int? active;
  @JsonKey(name: "activation_type")
  int? activationType;
  @JsonKey(name: "active_otp")
  dynamic activeOtp;
  @JsonKey(name: "device_id")
  dynamic deviceId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "region_id")
  String? regionId;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "accepted")
  int? accepted;
  @JsonKey(name: "streamio_id")
  String? streamioId;
  @JsonKey(name: "streamio_token")
  String? streamioToken;
  @JsonKey(name: "confirmationType")
  dynamic confirmationType;
  @JsonKey(name: "confirmationOtp")
  dynamic confirmationOtp;

  Client({
    this.id,
    this.countryId,
    this.cityId,
    this.username,
    this.myname,
    this.image,
    this.mobil,
    this.nationalityId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.passCode,
    this.passReset,
    this.acceptRules,
    this.type,
    this.active,
    this.activationType,
    this.activeOtp,
    this.deviceId,
    this.deletedAt,
    this.longitude,
    this.latitude,
    this.regionId,
    this.phoneCode,
    this.gender,
    this.accepted,
    this.streamioId,
    this.streamioToken,
    this.confirmationType,
    this.confirmationOtp,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
