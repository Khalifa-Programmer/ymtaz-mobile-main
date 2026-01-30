import 'package:json_annotation/json_annotation.dart';

part 'available_dates_response.g.dart';

@JsonSerializable()
class AvailableDatesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AvailableDatesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AvailableDatesResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableDatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDatesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "availableReservations")
  List<AvailableReservation>? availableReservations;

  Data({
    this.availableReservations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AvailableReservation {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "isYmtaz")
  int? isYmtaz;
  @JsonKey(name: "reservation_type_importance_id")
  int? reservationTypeImportanceId;
  @JsonKey(name: "reservationTypeImportance")
  ReservationTypeImportance? reservationTypeImportance;
  @JsonKey(name: "availableDateTime")
  List<AvailableDateTime>? availableDateTime;

  AvailableReservation({
    this.id,
    this.isYmtaz,
    this.reservationTypeImportanceId,
    this.reservationTypeImportance,
    this.availableDateTime,
  });

  factory AvailableReservation.fromJson(Map<String, dynamic> json) =>
      _$AvailableReservationFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableReservationToJson(this);
}

@JsonSerializable()
class AvailableDateTime {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reservation_id")
  int? reservationId;
  @JsonKey(name: "day")
  DateTime? day;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;

  AvailableDateTime({
    this.id,
    this.reservationId,
    this.day,
    this.from,
    this.to,
  });

  factory AvailableDateTime.fromJson(Map<String, dynamic> json) =>
      _$AvailableDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDateTimeToJson(this);
}

@JsonSerializable()
class ReservationTypeImportance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "reservation_importance_id")
  int? reservationImportanceId;
  @JsonKey(name: "reservation_importance")
  ReservationImportance? reservationImportance;
  @JsonKey(name: "isYmtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer")
  dynamic lawyer;

  ReservationTypeImportance({
    this.id,
    this.price,
    this.reservationImportanceId,
    this.reservationImportance,
    this.isYmtaz,
    this.lawyer,
  });

  factory ReservationTypeImportance.fromJson(Map<String, dynamic> json) =>
      _$ReservationTypeImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeImportanceToJson(this);
}

@JsonSerializable()
class ReservationImportance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  ReservationImportance({
    this.id,
    this.name,
  });

  factory ReservationImportance.fromJson(Map<String, dynamic> json) =>
      _$ReservationImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationImportanceToJson(this);
}
