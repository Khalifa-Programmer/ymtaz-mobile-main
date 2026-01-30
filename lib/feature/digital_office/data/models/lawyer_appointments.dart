import 'package:json_annotation/json_annotation.dart';

part 'lawyer_appointments.g.dart';

@JsonSerializable()
class LawyerAppointments {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<ReservationType>? data;

  LawyerAppointments({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawyerAppointments.fromJson(Map<String, dynamic> json) =>
      _$LawyerAppointmentsFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerAppointmentsToJson(this);
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
  @JsonKey(name: "isHidden")
  bool? isHidden;
  @JsonKey(name: "ymtazPrices")
  List<Price>? ymtazPrices;
  @JsonKey(name: "is_activated")
  bool? isActivated;
  @JsonKey(name: "lawyerPrices")
  List<Price>? lawyerPrices;

  ReservationType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.isHidden,
    this.ymtazPrices,
    this.isActivated,
    this.lawyerPrices,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) =>
      _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
}

@JsonSerializable()
class Price {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "isHidden")
  int? isHidden;
  @JsonKey(name: "level")
  Level? level;

  Price({
    this.id,
    this.price,
    this.isHidden,
    this.level,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Level {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  dynamic name;

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
