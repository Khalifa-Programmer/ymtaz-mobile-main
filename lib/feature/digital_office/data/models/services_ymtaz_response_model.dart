import 'package:json_annotation/json_annotation.dart';

part 'services_ymtaz_response_model.g.dart';

@JsonSerializable()
class ServicesYmtazResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ServicesYmtazResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesYmtazResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesYmtazResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesYmtazResponseModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "intro")
  String? intro;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "ymtaz_levels_prices")
  List<YmtazLevelsPrice>? ymtazLevelsPrices;
  @JsonKey(name: "is_activated")
  bool? isActivated;
  @JsonKey(name: "isHidden")
  bool? isHidden;
  @JsonKey(name: "lawyerPrices")
  List<YmtazLevelsPrice>? lawyerPrices;

  @override
  String toString() {
    return '$title';
  }

  Datum({
    this.id,
    this.title,
    this.intro,
    this.details,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.ymtazLevelsPrices,
    this.isActivated,
    this.isHidden,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "isHidden")
  int? isHidden;
  @JsonKey(name: "level")
  Level? level;
  @JsonKey(name: "price")
  int? price;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) =>
      _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}

@JsonSerializable()
class Level {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
