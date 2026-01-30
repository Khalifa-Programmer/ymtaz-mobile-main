import 'package:json_annotation/json_annotation.dart';

part 'create_services_ymtaz_response_model.g.dart';

@JsonSerializable()
class CreateServicesYmtazResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  CreateServicesYmtazResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory CreateServicesYmtazResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$CreateServicesYmtazResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateServicesYmtazResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "category_id")
  dynamic categoryId;
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
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "lawyer_prices")
  List<LawyerPrice>? lawyerPrices;

  Data({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.needAppointment,
    this.lawyerPrices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LawyerPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "lawyer_id")
  int? lawyerId;
  @JsonKey(name: "service_id")
  int? serviceId;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "client_reservations_importance_id")
  int? clientReservationsImportanceId;
  @JsonKey(name: "importance")
  Importance? importance;

  LawyerPrice({
    this.id,
    this.lawyerId,
    this.serviceId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clientReservationsImportanceId,
    this.importance,
  });

  factory LawyerPrice.fromJson(Map<String, dynamic> json) =>
      _$LawyerPriceFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerPriceToJson(this);
}

@JsonSerializable()
class Importance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;

  Importance({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Importance.fromJson(Map<String, dynamic> json) =>
      _$ImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ImportanceToJson(this);
}
