import 'package:json_annotation/json_annotation.dart';

part 'advisory_services_types_response.g.dart';

@JsonSerializable()
class AdvisoryServicesTypesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryServicesTypesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryServicesTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesTypesResponseToJson(this);
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
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePriceFromTypes>? advisoryServicePrices;

  @override
  String toString() {
    return '$title ';
  }

  Item({
    this.id,
    this.title,
    this.advisoryServicePrices,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class AdvisoryServicePriceFromTypes {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_id")
  int? advisoryServiceId;
  @JsonKey(name: "request_level")
  int? requestLevel;
  @JsonKey(name: "price")
  int? price;

  @override
  String toString() {
    return '$title  - $price ريال ';
  }

  AdvisoryServicePriceFromTypes({
    this.id,
    this.title,
    this.advisoryServiceId,
    this.requestLevel,
    this.price,
  });

  factory AdvisoryServicePriceFromTypes.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicePriceFromTypesFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceFromTypesToJson(this);
}
