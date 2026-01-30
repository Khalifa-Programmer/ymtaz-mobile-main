import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'reply_to_offer_appointment_response.g.dart';

@JsonSerializable()
class ReplyToOfferAppointmentResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ReplyToOfferAppointmentResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ReplyToOfferAppointmentResponse.fromJson(Map<String, dynamic> json) => _$ReplyToOfferAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToOfferAppointmentResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservation")
  Reservation? reservation;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_url")
  String? paymentUrl;

  Data({
    this.reservation,
    this.transactionId,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "reservation_type_id")
  int? reservationTypeId;
  @JsonKey(name: "importance_id")
  int? importanceId;
  @JsonKey(name: "reserved_from_lawyer_id")
  String? reservedFromLawyerId;
  @JsonKey(name: "hours")
  int? hours;
  @JsonKey(name: "region_id")
  int? regionId;
  @JsonKey(name: "city_id")
  int? cityId;
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
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;
  @JsonKey(name: "request_status")
  int? requestStatus;
  @JsonKey(name: "reservation_code")
  String? reservationCode;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "transaction_id")
  String? transactionId;

  Reservation({
    this.reservationTypeId,
    this.importanceId,
    this.reservedFromLawyerId,
    this.hours,
    this.regionId,
    this.cityId,
    this.longitude,
    this.latitude,
    this.lawyerLongitude,
    this.lawyerLatitude,
    this.day,
    this.from,
    this.to,
    this.accountId,
    this.description,
    this.price,
    this.transactionComplete,
    this.requestStatus,
    this.reservationCode,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.transactionId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
