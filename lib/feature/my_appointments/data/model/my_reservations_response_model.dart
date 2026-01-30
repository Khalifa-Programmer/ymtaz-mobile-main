import 'package:json_annotation/json_annotation.dart';

part 'my_reservations_response_model.g.dart';

@JsonSerializable()
class MyReservationsResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyReservationsResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyReservationsResponseModel.fromJson(Map<String, dynamic> json) => _$MyReservationsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyReservationsResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservations")
  List<Reservation>? reservations;

  Data({
    this.reservations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "client_id")
  dynamic clientId;
  @JsonKey(name: "lawyer_id")
  int? lawyerId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "country_id")
  int? countryId;
  @JsonKey(name: "region_id")
  int? regionId;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "hours")
  String? hours;
  @JsonKey(name: "reservationEnded")
  int? reservationEnded;
  @JsonKey(name: "reservationEndedTime")
  dynamic reservationEndedTime;
  @JsonKey(name: "reservedFromLawyer")
  dynamic reservedFromLawyer;
  @JsonKey(name: "reservationType")
  ReservationType? reservationType;
  @JsonKey(name: "reservationImportance")
  ReservationImportance? reservationImportance;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Reservation({
    this.id,
    this.clientId,
    this.lawyerId,
    this.description,
    this.longitude,
    this.latitude,
    this.date,
    this.from,
    this.to,
    this.countryId,
    this.regionId,
    this.file,
    this.price,
    this.hours,
    this.reservationEnded,
    this.reservationEndedTime,
    this.reservedFromLawyer,
    this.reservationType,
    this.reservationImportance,
    this.createdAt,
    this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
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

  factory ReservationImportance.fromJson(Map<String, dynamic> json) => _$ReservationImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationImportanceToJson(this);
}

@JsonSerializable()
class ReservationType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "minPrice")
  int? minPrice;
  @JsonKey(name: "maxPrice")
  int? maxPrice;

  ReservationType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) => _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
}
