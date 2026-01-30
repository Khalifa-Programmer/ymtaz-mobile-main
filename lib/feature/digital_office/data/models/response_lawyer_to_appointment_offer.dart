import 'package:json_annotation/json_annotation.dart';

part 'response_lawyer_to_appointment_offer.g.dart';

@JsonSerializable()
class ResponseLawyerToAppointmentOffer {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ResponseLawyerToAppointmentOffer({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ResponseLawyerToAppointmentOffer.fromJson(
          Map<String, dynamic> json) =>
      _$ResponseLawyerToAppointmentOfferFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ResponseLawyerToAppointmentOfferToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "offer")
  Offer? offer;

  Data({
    this.offer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Offer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reservation_type_id")
  int? reservationTypeId;
  @JsonKey(name: "importance_id")
  int? importanceId;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "lawyer_id")
  String? lawyerId;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "lawyer_longitude")
  String? lawyerLongitude;
  @JsonKey(name: "lawyer_latitude")
  String? lawyerLatitude;
  @JsonKey(name: "day")
  DateTime? day;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "hours")
  int? hours;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "region_id")
  int? regionId;
  @JsonKey(name: "city_id")
  int? cityId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Offer({
    this.id,
    this.reservationTypeId,
    this.importanceId,
    this.accountId,
    this.lawyerId,
    this.price,
    this.description,
    this.file,
    this.longitude,
    this.latitude,
    this.lawyerLongitude,
    this.lawyerLatitude,
    this.day,
    this.from,
    this.to,
    this.hours,
    this.status,
    this.regionId,
    this.cityId,
    this.createdAt,
    this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
