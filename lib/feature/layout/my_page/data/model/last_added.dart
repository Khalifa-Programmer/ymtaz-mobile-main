import 'package:json_annotation/json_annotation.dart';

part 'last_added.g.dart';

@JsonSerializable()
class LastAdded {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LastAdded({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LastAdded.fromJson(Map<String, dynamic> json) =>
      _$LastAddedFromJson(json);

  Map<String, dynamic> toJson() => _$LastAddedToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "mostBought")
  MostBought? mostBought;
  @JsonKey(name: "latestCreated")
  LatestCreated? latestCreated;

  Data({
    this.mostBought,
    this.latestCreated,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LatestCreated {
  @JsonKey(name: "advisoryServices")
  List<LatestCreatedAdvisoryService>? advisoryServices;
  @JsonKey(name: "services")
  List<LatestCreatedService>? services;
  @JsonKey(name: "appointments")
  List<Appointment>? appointments;

  LatestCreated({
    this.advisoryServices,
    this.services,
    this.appointments,
  });

  factory LatestCreated.fromJson(Map<String, dynamic> json) =>
      _$LatestCreatedFromJson(json);

  Map<String, dynamic> toJson() => _$LatestCreatedToJson(this);
}

@JsonSerializable()
class LatestCreatedAdvisoryService {
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
  PurpleGeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<LevelElement>? levels;

  LatestCreatedAdvisoryService({
    this.id,
    this.name,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.generalCategory,
    this.levels,
  });

  factory LatestCreatedAdvisoryService.fromJson(Map<String, dynamic> json) =>
      _$LatestCreatedAdvisoryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$LatestCreatedAdvisoryServiceToJson(this);
}

@JsonSerializable()
class PurpleGeneralCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  dynamic description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  PurpleGeneralCategory({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory PurpleGeneralCategory.fromJson(Map<String, dynamic> json) =>
      _$PurpleGeneralCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PurpleGeneralCategoryToJson(this);
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

  factory PaymentCategoryType.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryTypeFromJson(json);

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

  factory LevelElement.fromJson(Map<String, dynamic> json) =>
      _$LevelElementFromJson(json);

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

  factory AccurateSpecialtyClass.fromJson(Map<String, dynamic> json) =>
      _$AccurateSpecialtyClassFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyClassToJson(this);
}

@JsonSerializable()
class Appointment {
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

  Appointment({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.typesImportance,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
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
  Lawyer? lawyer;

  TypesImportance({
    this.id,
    this.price,
    this.reservationImportanceId,
    this.reservationImportance,
    this.isYmtaz,
    this.lawyer,
  });

  factory TypesImportance.fromJson(Map<String, dynamic> json) =>
      _$TypesImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$TypesImportanceToJson(this);
}

@JsonSerializable()
class Lawyer {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "nationality")
  ReservationImportance? nationality;
  @JsonKey(name: "country")
  ReservationImportance? country;
  @JsonKey(name: "region")
  ReservationImportance? region;
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
class ReservationImportance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  ReservationImportance({
    this.id,
    this.name,
  });

  factory ReservationImportance.fromJson(Map<String, dynamic> json) =>
      _$ReservationImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationImportanceToJson(this);
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

  factory CurrentRank.fromJson(Map<String, dynamic> json) =>
      _$CurrentRankFromJson(json);

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
  DateTime? to;

  Experience({
    this.id,
    this.accountId,
    this.title,
    this.company,
    this.from,
    this.to,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

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

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

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
class LatestCreatedService {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "intro")
  String? intro;
  @JsonKey(name: "details")
  dynamic details;
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

  LatestCreatedService({
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

  factory LatestCreatedService.fromJson(Map<String, dynamic> json) =>
      _$LatestCreatedServiceFromJson(json);

  Map<String, dynamic> toJson() => _$LatestCreatedServiceToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "level")
  ReservationImportance? level;
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

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) =>
      _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}

@JsonSerializable()
class MostBought {
  @JsonKey(name: "advisoryServices")
  List<MostBoughtAdvisoryService>? advisoryServices;
  @JsonKey(name: "services")
  List<MostBoughtService>? services;
  @JsonKey(name: "appointments")
  List<Appointment>? appointments;

  MostBought({
    this.advisoryServices,
    this.services,
    this.appointments,
  });

  factory MostBought.fromJson(Map<String, dynamic> json) =>
      _$MostBoughtFromJson(json);

  Map<String, dynamic> toJson() => _$MostBoughtToJson(this);
}

@JsonSerializable()
class MostBoughtAdvisoryService {
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
  FluffyGeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<LevelElement>? levels;

  MostBoughtAdvisoryService({
    this.id,
    this.name,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.generalCategory,
    this.levels,
  });

  factory MostBoughtAdvisoryService.fromJson(Map<String, dynamic> json) =>
      _$MostBoughtAdvisoryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$MostBoughtAdvisoryServiceToJson(this);
}

@JsonSerializable()
class FluffyGeneralCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  FluffyGeneralCategory({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory FluffyGeneralCategory.fromJson(Map<String, dynamic> json) =>
      _$FluffyGeneralCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FluffyGeneralCategoryToJson(this);
}

@JsonSerializable()
class MostBoughtService {
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

  MostBoughtService({
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

  factory MostBoughtService.fromJson(Map<String, dynamic> json) =>
      _$MostBoughtServiceFromJson(json);

  Map<String, dynamic> toJson() => _$MostBoughtServiceToJson(this);
}
