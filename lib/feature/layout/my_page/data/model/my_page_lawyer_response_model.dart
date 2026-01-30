import 'package:json_annotation/json_annotation.dart';

part 'my_page_lawyer_response_model.g.dart';

@JsonSerializable()
class MyPageLawyerResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyPageLawyerResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyPageLawyerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyPageLawyerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPageLawyerResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservations")
  List<dynamic>? reservations;
  @JsonKey(name: "advisoryServices")
  List<AdvisoryService>? advisoryServices;
  @JsonKey(name: "services")
  List<ServiceElement>? services;

  Data({
    this.reservations,
    this.advisoryServices,
    this.services,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AdvisoryService {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "price")
  dynamic price;
  @JsonKey(name: "accept_date")
  dynamic acceptDate;
  @JsonKey(name: "reservation_status")
  String? reservationStatus;
  @JsonKey(name: "advisory_services_id")
  AdvisoryServicesId? advisoryServicesId;
  @JsonKey(name: "type")
  Type? type;
  @JsonKey(name: "importance")
  dynamic importance;
  @JsonKey(name: "appointment")
  dynamic appointment;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "rate")
  dynamic rate;
  @JsonKey(name: "comment")
  dynamic comment;
  @JsonKey(name: "reply")
  dynamic reply;

  AdvisoryService({
    this.id,
    this.description,
    this.file,
    this.paymentStatus,
    this.price,
    this.acceptDate,
    this.reservationStatus,
    this.advisoryServicesId,
    this.type,
    this.importance,
    this.appointment,
    this.lawyer,
    this.rate,
    this.comment,
    this.reply,
  });

  factory AdvisoryService.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServiceToJson(this);
}

@JsonSerializable()
class AdvisoryServicesId {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "phone")
  dynamic phone;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "payment_category")
  PaymentCategory? paymentCategory;
  @JsonKey(name: "available_dates")
  List<dynamic>? availableDates;

  AdvisoryServicesId({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.phone,
    this.needAppointment,
    this.image,
    this.paymentCategory,
    this.availableDates,
  });

  factory AdvisoryServicesId.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesIdFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesIdToJson(this);
}

@JsonSerializable()
class PaymentCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "count")
  dynamic count;
  @JsonKey(name: "period")
  dynamic period;

  PaymentCategory({
    this.id,
    this.name,
    this.paymentMethod,
    this.count,
    this.period,
  });

  factory PaymentCategory.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryToJson(this);
}

@JsonSerializable()
class Type {
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

  Type({
    this.id,
    this.title,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.advisoryServicePrices,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
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
class ServiceElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "service")
  ServiceService? service;
  @JsonKey(name: "priority")
  Priority? priority;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "request_status")
  int? requestStatus;
  @JsonKey(name: "for_admin")
  String? forAdmin;
  @JsonKey(name: "replay_status")
  String? replayStatus;
  @JsonKey(name: "replay")
  dynamic replay;
  @JsonKey(name: "replay_file")
  dynamic replayFile;
  @JsonKey(name: "replay_time")
  dynamic replayTime;
  @JsonKey(name: "replay_date")
  dynamic replayDate;
  @JsonKey(name: "referral_status")
  int? referralStatus;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "rate")
  dynamic rate;
  @JsonKey(name: "comment")
  dynamic comment;

  ServiceElement({
    this.id,
    this.service,
    this.priority,
    this.description,
    this.file,
    this.price,
    this.createdAt,
    this.requestStatus,
    this.forAdmin,
    this.replayStatus,
    this.replay,
    this.replayFile,
    this.replayTime,
    this.replayDate,
    this.referralStatus,
    this.lawyer,
    this.rate,
    this.comment,
  });

  factory ServiceElement.fromJson(Map<String, dynamic> json) =>
      _$ServiceElementFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceElementToJson(this);
}

@JsonSerializable()
class Priority {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  Priority({
    this.id,
    this.title,
  });

  factory Priority.fromJson(Map<String, dynamic> json) =>
      _$PriorityFromJson(json);

  Map<String, dynamic> toJson() => _$PriorityToJson(this);
}

@JsonSerializable()
class ServiceService {
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

  ServiceService({
    this.id,
    this.title,
    this.intro,
    this.details,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.ymtazLevelsPrices,
  });

  factory ServiceService.fromJson(Map<String, dynamic> json) =>
      _$ServiceServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceServiceToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
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
