import 'package:json_annotation/json_annotation.dart';

part 'appointment_request_response.g.dart';

@JsonSerializable()
class AppontmentRequestResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AppontmentRequestResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AppontmentRequestResponse.fromJson(Map<String, dynamic> json) => _$AppontmentRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppontmentRequestResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservation")
  Reservation? reservation;


  Data({
    this.reservation,

  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "reservation_type_id")
  int? id;
  @JsonKey(name: "importance_id")
  dynamic importanceId;

  Reservation({
    this.id,

  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
