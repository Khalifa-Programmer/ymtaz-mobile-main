
import 'package:json_annotation/json_annotation.dart';

part 'lawyer_services_response_model.g.dart';

@JsonSerializable()
class LawyerServicesResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  LawyerServicesResponseModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory LawyerServicesResponseModel.fromJson(Map<String, dynamic> json) => _$LawyerServicesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerServicesResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawyerServices")
  List<LawyerService>? lawyerServices;

  Data({
    this.lawyerServices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LawyerService {
  @JsonKey(name: "service_id")
  int? serviceId;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "request_level_id")
  dynamic requestLevelId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "intro")
  String? intro;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "section_id")
  int? sectionId;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "sections")
  String? sections;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "lawyer_prices")
  List<LawyerPrice>? lawyerPrices;

  LawyerService({
    this.serviceId,
    this.categoryId,
    this.requestLevelId,
    this.title,
    this.image,
    this.intro,
    this.details,
    this.slug,
    this.sectionId,
    this.minPrice,
    this.maxPrice,
    this.sections,
    this.ymtazPrice,
    this.status,
    this.needAppointment,
    this.lawyerPrices,
  });

  factory LawyerService.fromJson(Map<String, dynamic> json) => _$LawyerServiceFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerServiceToJson(this);
}

@JsonSerializable()
class LawyerPrice {
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "importance")
  Importance? importance;


  @override
  String toString() {
    return '  ${importance!.title} - ${price } ريال';
  }

  LawyerPrice({
    this.price,
    this.importance,
  });

  factory LawyerPrice.fromJson(Map<String, dynamic> json) => _$LawyerPriceFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerPriceToJson(this);
}

@JsonSerializable()
class Importance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  Importance({
    this.id,
    this.title,
  });

  factory Importance.fromJson(Map<String, dynamic> json) => _$ImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ImportanceToJson(this);
}
