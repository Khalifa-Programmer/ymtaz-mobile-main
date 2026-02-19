import 'package:json_annotation/json_annotation.dart';

part 'elite_my_requests_model.g.dart';

@JsonSerializable()
class EliteMyRequestsModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  EliteMyRequestsModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory EliteMyRequestsModel.fromJson(Map<String, dynamic> json) => _$EliteMyRequestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EliteMyRequestsModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "requests")
  List<Request>? requests;

  Data({
    this.requests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Request {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "elite_service_category")
  EliteServiceCategory? eliteServiceCategory;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;
  @JsonKey(name: "transaction_id")
  dynamic transactionId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "files")
  List<FileElement>? files;
  @JsonKey(name: "offers")
  Offers? offers;

  Request({
    this.id,
    this.accountId,
    this.eliteServiceCategory,
    this.description,
    this.transactionComplete,
    this.transactionId,
    this.status,
    this.createdAt,
    this.files,
    this.offers,
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}

@JsonSerializable()
class EliteServiceCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  EliteServiceCategory({
    this.id,
    this.name,
  });

  factory EliteServiceCategory.fromJson(Map<String, dynamic> json) => _$EliteServiceCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$EliteServiceCategoryToJson(this);
}

@JsonSerializable()
class FileElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "elite_service_request_id")
  int? eliteServiceRequestId;
  @JsonKey(name: "advisory_services_reservations_id")
  dynamic advisoryServicesReservationsId;
  @JsonKey(name: "services_reservations_id")
  dynamic servicesReservationsId;
  @JsonKey(name: "reservations_id")
  dynamic reservationsId;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "is_voice")
  int? isVoice;
  @JsonKey(name: "is_reply")
  int? isReply;

  FileElement({
    this.id,
    this.eliteServiceRequestId,
    this.advisoryServicesReservationsId,
    this.servicesReservationsId,
    this.reservationsId,
    this.file,
    this.isVoice,
    this.isReply,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => _$FileElementFromJson(json);

  Map<String, dynamic> toJson() => _$FileElementToJson(this);
}

@JsonSerializable()
class Offers {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "elite_service_request_id")
  int? eliteServiceRequestId;
  @JsonKey(name: "advisory_service_sub")
  AdvisoryServiceSub? advisoryServiceSub;
  @JsonKey(name: "advisory_service_sub_price")
  int? advisoryServiceSubPrice;
  @JsonKey(name: "advisory_service_date")
  dynamic advisoryServiceDate;
  @JsonKey(name: "advisory_service_from_time")
  dynamic advisoryServiceFromTime;
  @JsonKey(name: "advisory_service_to_time")
  dynamic advisoryServiceToTime;
  @JsonKey(name: "service_sub")
  ServiceSub? serviceSub;
  @JsonKey(name: "service_sub_price")
  int? serviceSubPrice;
  @JsonKey(name: "reservation_type")
  ReservationType? reservationType;
  @JsonKey(name: "reservation_price")
  int? reservationPrice;
  @JsonKey(name: "reservation_date")
  DateTime? reservationDate;
  @JsonKey(name: "reservation_from_time")
  String? reservationFromTime;
  @JsonKey(name: "reservation_to_time")
  String? reservationToTime;
  @JsonKey(name: "reservation_latitude")
  String? reservationLatitude;
  @JsonKey(name: "reservation_longitude")
  String? reservationLongitude;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Offers({
    this.id,
    this.eliteServiceRequestId,
    this.advisoryServiceSub,
    this.advisoryServiceSubPrice,
    this.advisoryServiceDate,
    this.advisoryServiceFromTime,
    this.advisoryServiceToTime,
    this.serviceSub,
    this.serviceSubPrice,
    this.reservationType,
    this.reservationPrice,
    this.reservationDate,
    this.reservationFromTime,
    this.reservationToTime,
    this.reservationLatitude,
    this.reservationLongitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}

@JsonSerializable()
class AdvisoryServiceSub {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "general_category")
  GeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<LevelElement>? levels;

  AdvisoryServiceSub({
    this.id,
    this.name,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.generalCategory,
    this.levels,
  });

  factory AdvisoryServiceSub.fromJson(Map<String, dynamic> json) => _$AdvisoryServiceSubFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServiceSubToJson(this);
}

@JsonSerializable()
class GeneralCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  GeneralCategory({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory GeneralCategory.fromJson(Map<String, dynamic> json) => _$GeneralCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralCategoryToJson(this);
}

@JsonSerializable()
class PaymentCategoryType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "requires_appointment")
  int? requiresAppointment;

  PaymentCategoryType({
    this.id,
    this.name,
    this.description,
    this.requiresAppointment,
  });

  factory PaymentCategoryType.fromJson(Map<String, dynamic> json) => _$PaymentCategoryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryTypeToJson(this);
}

@JsonSerializable()
class LevelElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "level")
  AccurateSpecialtyClass? level;
  @JsonKey(name: "price")
  String? price;

  LevelElement({
    this.id,
    this.duration,
    this.level,
    this.price,
  });

  factory LevelElement.fromJson(Map<String, dynamic> json) => _$LevelElementFromJson(json);

  Map<String, dynamic> toJson() => _$LevelElementToJson(this);
}

@JsonSerializable()
class AccurateSpecialtyClass {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  AccurateSpecialtyClass({
    this.id,
    this.title,
  });

  factory AccurateSpecialtyClass.fromJson(Map<String, dynamic> json) => _$AccurateSpecialtyClassFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyClassToJson(this);
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
  @JsonKey(name: "typesImportance")
  List<TypesImportance>? typesImportance;

  ReservationType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.typesImportance,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) => _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
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
  EliteServiceCategory? reservationImportance;
  @JsonKey(name: "isYmtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer")
  Lawyer? lawyer;

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
class Lawyer {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "nationality")
  EliteServiceCategory? nationality;
  @JsonKey(name: "country")
  EliteServiceCategory? country;
  @JsonKey(name: "region")
  EliteServiceCategory? region;
  @JsonKey(name: "city")
  AccurateSpecialtyClass? city;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "currentLevel")
  int? currentLevel;
  @JsonKey(name: "currentRank")
  CurrentRank? currentRank;
  @JsonKey(name: "lastSeen")
  String? lastSeen;
  @JsonKey(name: "account_type")
  String? accountType;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "accurate_specialty")
  AccurateSpecialtyClass? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  AccurateSpecialtyClass? generalSpecialty;
  @JsonKey(name: "degree")
  Degree? degree;
  @JsonKey(name: "is_favorite")
  int? isFavorite;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "sections")
  List<SectionElement>? sections;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;
  @JsonKey(name: "hasBadge")
  dynamic hasBadge;
  @JsonKey(name: "experiences")
  List<Experience>? experiences;

  Lawyer({
    this.id,
    this.name,
    this.nationality,
    this.country,
    this.region,
    this.city,
    this.image,
    this.gender,
    this.currentLevel,
    this.currentRank,
    this.lastSeen,
    this.accountType,
    this.subscribed,
    this.about,
    this.accurateSpecialty,
    this.generalSpecialty,
    this.degree,
    this.isFavorite,
    this.special,
    this.logo,
    this.sections,
    this.permissions,
    this.hasBadge,
    this.experiences,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerToJson(this);
}

@JsonSerializable()
class CurrentRank {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "border_color")
  String? borderColor;
  @JsonKey(name: "image")
  String? image;

  CurrentRank({
    this.id,
    this.name,
    this.borderColor,
    this.image,
  });

  factory CurrentRank.fromJson(Map<String, dynamic> json) => _$CurrentRankFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentRankToJson(this);
}

@JsonSerializable()
class Degree {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "isSpecial")
  int? isSpecial;
  @JsonKey(name: "need_certificate")
  int? needCertificate;

  Degree({
    this.id,
    this.title,
    this.isSpecial,
    this.needCertificate,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);

  Map<String, dynamic> toJson() => _$DegreeToJson(this);
}

@JsonSerializable()
class Experience {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "from")
  DateTime? from;
  @JsonKey(name: "to")
  dynamic to;

  Experience({
    this.id,
    this.accountId,
    this.title,
    this.company,
    this.from,
    this.to,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Permission {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  dynamic description;

  Permission({
    this.id,
    this.name,
    this.description,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}

@JsonSerializable()
class SectionElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;

  SectionElement({
    this.id,
    this.section,
  });

  factory SectionElement.fromJson(Map<String, dynamic> json) => _$SectionElementFromJson(json);

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

  factory SectionSection.fromJson(Map<String, dynamic> json) => _$SectionSectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionSectionToJson(this);
}

@JsonSerializable()
class ServiceSub {
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
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "ymtaz_levels_prices")
  List<YmtazLevelsPrice>? ymtazLevelsPrices;

  ServiceSub({
    this.id,
    this.title,
    this.intro,
    this.details,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.needAppointment,
    this.ymtazLevelsPrices,
  });

  factory ServiceSub.fromJson(Map<String, dynamic> json) => _$ServiceSubFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceSubToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "level")
  EliteServiceCategory? level;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "isHidden")
  int? isHidden;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
    this.duration,
    this.isHidden,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) => _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}
