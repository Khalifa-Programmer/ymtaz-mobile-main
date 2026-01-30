import 'package:json_annotation/json_annotation.dart';

import '../../../forensic_guide/data/model/judicial_guide_response_model.dart';
import '../../../my_appointments/data/model/dates_types_response_model.dart';
import 'digital_search_response_model.dart';

part 'fast_search_response_model.g.dart';

@JsonSerializable()
class FastSearchResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  FastSearchResponseModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory FastSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FastSearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FastSearchResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawyers")
  List<Lawyer>? lawyers;
  @JsonKey(name: "services")
  List<Service>? services;
  @JsonKey(name: "advisoryServicesTypes")
  List<AdvisoryServicesType>? advisoryServicesTypes;
  @JsonKey(name: "appointmentTypes")
  List<ReservationsType>? appointmentTypes;
  @JsonKey(name: "judicialGuide")
  List<JudicialGuide>? judicialGuide;

  Data({
    this.lawyers,
    this.services,
    this.advisoryServicesTypes,
    this.appointmentTypes,
    this.judicialGuide,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AdvisoryServicesType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePrice>? advisoryServicePrices;

  AdvisoryServicesType({
    this.id,
    this.title,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.advisoryServicePrices,
  });

  factory AdvisoryServicesType.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesTypeToJson(this);
}

@JsonSerializable()
class AdvisoryServicePrice {
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

  AdvisoryServicePrice({
    this.id,
    this.title,
    this.advisoryServiceId,
    this.requestLevel,
    this.price,
  });

  factory AdvisoryServicePrice.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicePriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceToJson(this);
}

@JsonSerializable()
class SectionElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;
  @JsonKey(name: "lawyer_license_no")
  String? lawyerLicenseNo;
  @JsonKey(name: "lawyer_license_file")
  String? lawyerLicenseFile;

  SectionElement({
    this.id,
    this.section,
    this.lawyerLicenseNo,
    this.lawyerLicenseFile,
  });

  factory SectionElement.fromJson(Map<String, dynamic> json) =>
      _$SectionElementFromJson(json);

  Map<String, dynamic> toJson() => _$SectionElementToJson(this);
}

@JsonSerializable()
class SectionSection {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "need_license")
  int? needLicense;
  @JsonKey(name: "lawyers_count")
  int? lawyersCount;

  SectionSection({
    this.id,
    this.title,
    this.image,
    this.needLicense,
    this.lawyersCount,
  });

  factory SectionSection.fromJson(Map<String, dynamic> json) =>
      _$SectionSectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionSectionToJson(this);
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

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
