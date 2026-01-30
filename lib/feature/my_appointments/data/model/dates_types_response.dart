// import 'package:json_annotation/json_annotation.dart';
//
// part 'dates_types_response.g.dart';
//
// @JsonSerializable()
// class DatesTypesResponse {
//   @JsonKey(name: "status")
//   bool? status;
//   @JsonKey(name: "code")
//   int? code;
//   @JsonKey(name: "message")
//   String? message;
//   @JsonKey(name: "data")
//   Data? data;
//
//   DatesTypesResponse({
//     this.status,
//     this.code,
//     this.message,
//     this.data,
//   });
//
//   factory DatesTypesResponse.fromJson(Map<String, dynamic> json) =>
//       _$DatesTypesResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DatesTypesResponseToJson(this);
// }
//
// @JsonSerializable()
// class Data {
//   @JsonKey(name: "reservations_types")
//   List<ReservationsType>? reservationsTypes;
//
//   Data({
//     this.reservationsTypes,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DataToJson(this);
// }
//
// @JsonSerializable()
// class ReservationsType {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "name")
//   String? name;
//   @JsonKey(name: "minPrice")
//   int? minPrice;
//   @JsonKey(name: "maxPrice")
//   int? maxPrice;
//   @JsonKey(name: "ymtazPrices")
//   List<Price>? ymtazPrices;
//   @JsonKey(name: "lawyerPrices")
//   List<Price>? lawyerPrices;
//   @JsonKey(name: "is_activated")
//   bool? isActivated;
//   @JsonKey(name: "isHidden")
//   bool? isHidden;
//
//   @override
//   toString() => "$name";
//
//   ReservationsType({
//     this.id,
//     this.name,
//     this.minPrice,
//     this.maxPrice,
//   });
//
//   factory ReservationsType.fromJson(Map<String, dynamic> json) =>
//       _$ReservationsTypeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ReservationsTypeToJson(this);
// }
// @JsonSerializable()
// class Price {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "price")
//   int? price;
//   @JsonKey(name: "isHidden")
//   int? isHidden;
//   @JsonKey(name: "level")
//   Level? level;
//
//   Price({
//     this.id,
//     this.price,
//     this.isHidden,
//     this.level,
//   });
//
//   factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PriceToJson(this);
// }
// @JsonSerializable()
// class Level {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "name")
//   String? name;
//
//   Level({
//     this.id,
//     this.name,
//   });
//
//   factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$LevelToJson(this);
// }
//
//
// @JsonSerializable()
// class TypesImportance {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "price")
//   int? price;
//   @JsonKey(name: "reservation_importance_id")
//   int? reservationImportanceId;
//   @JsonKey(name: "reservation_importance")
//   ReservationImportance? reservationImportance;
//   @JsonKey(name: "isYmtaz")
//   int? isYmtaz;
//   @JsonKey(name: "lawyer")
//   dynamic lawyer;
//   @JsonKey(name: "availableReservations")
//   List<AvailableReservation>? availableReservations;
//
//   toString() => "${reservationImportance?.name}   ${price}  ر.س";
//
//   TypesImportance({
//     this.id,
//     this.price,
//     this.reservationImportanceId,
//     this.reservationImportance,
//     this.isYmtaz,
//     this.lawyer,
//     this.availableReservations,
//   });
//
//   factory TypesImportance.fromJson(Map<String, dynamic> json) =>
//       _$TypesImportanceFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TypesImportanceToJson(this);
// }
//
// @JsonSerializable()
// class AvailableReservation {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "isYmtaz")
//   int? isYmtaz;
//   @JsonKey(name: "availableDateTime")
//   AvailableDateTime? availableDateTime;
//
//   toString() =>
//       "${availableDateTime?.day?.day} / ${availableDateTime?.day?.month} / ${availableDateTime?.day?.year}  ${availableDateTime?.from} - ${availableDateTime?.to}";
//
//   AvailableReservation({
//     this.id,
//     this.isYmtaz,
//     this.availableDateTime,
//   });
//
//   factory AvailableReservation.fromJson(Map<String, dynamic> json) =>
//       _$AvailableReservationFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AvailableReservationToJson(this);
// }
//
// @JsonSerializable()
// class AvailableDateTime {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "reservation_id")
//   int? reservationId;
//   @JsonKey(name: "day")
//   DateTime? day;
//   @JsonKey(name: "from")
//   String? from;
//   @JsonKey(name: "to")
//   String? to;
//
//   toString() => "${day?.day} / ${day?.month} / ${day?.year}  $from - $to";
//
//   AvailableDateTime({
//     this.id,
//     this.reservationId,
//     this.day,
//     this.from,
//     this.to,
//   });
//
//   factory AvailableDateTime.fromJson(Map<String, dynamic> json) =>
//       _$AvailableDateTimeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AvailableDateTimeToJson(this);
// }
//
// @JsonSerializable()
// class ReservationImportance {
//   @JsonKey(name: "id")
//   int? id;
//   @JsonKey(name: "name")
//   String? name;
//
//   ReservationImportance({
//     this.id,
//     this.name,
//   });
//
//   factory ReservationImportance.fromJson(Map<String, dynamic> json) =>
//       _$ReservationImportanceFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ReservationImportanceToJson(this);
// }
