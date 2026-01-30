import 'package:json_annotation/json_annotation.dart';

part 'services_requirements_response.g.dart';

@JsonSerializable()
class ServicesRequirementsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ServicesRequirementsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesRequirementsResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesRequirementsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesRequirementsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "items")
  List<Item>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "services")
  List<Service>? services;

  @override
  String toString() {
    return '$name';
  }

  Item({
    this.id,
    this.name,
    this.services,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Service {
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

  @override
  String toString() {
    return '$title';
  }

  Service({
    this.id,
    this.title,
    this.intro,
    this.details,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.ymtazLevelsPrices,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "level")
  Level? level;
  @JsonKey(name: "price")
  int? price;

  @override
  String toString() {
    return '${level!.name}  -  السعر :  $price ر.س ';
  }

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

  @override
  String toString() {
    return '$name';
  }

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
