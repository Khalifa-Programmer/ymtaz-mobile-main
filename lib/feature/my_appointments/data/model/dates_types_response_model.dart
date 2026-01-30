import 'package:json_annotation/json_annotation.dart';

part 'dates_types_response_model.g.dart';

@JsonSerializable()
class DatesTypesResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  DatesTypesResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory DatesTypesResponseModel.fromJson(Map<String, dynamic> json) => _$DatesTypesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DatesTypesResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservations_types")
  List<ReservationsType>? reservationsTypes;

  Data({
    this.reservationsTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ReservationsType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "minPrice")
  int? minPrice;
  @JsonKey(name: "maxPrice")
  int? maxPrice;
  @JsonKey(name: "typesImportance")
  List<TypesImportance>? typesImportance;




  ReservationsType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.typesImportance,
  });

  factory ReservationsType.fromJson(Map<String, dynamic> json) => _$ReservationsTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationsTypeToJson(this);
}

@JsonSerializable()
class TypesImportance {
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
  // مستوى متوسط سعر ١٠٠ ريال   عرض المستوى والسعر

  @override
  String toString() {
    return '${reservationImportance?.name}';
  }



  TypesImportance({
    this.id,
    this.price,
    this.reservationImportanceId,
    this.reservationImportance,
    this.isYmtaz,
    this.lawyer,
  });

  factory TypesImportance.fromJson(Map<String, dynamic> json) => _$TypesImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$TypesImportanceToJson(this);
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
