import 'package:json_annotation/json_annotation.dart';

part 'appointment_offers_lawyer.g.dart';

@JsonSerializable()
class AppointmentOffersLawyer {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AppointmentOffersLawyer({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AppointmentOffersLawyer.fromJson(Map<String, dynamic> json) =>
      _$AppointmentOffersLawyerFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentOffersLawyerToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "offers")
  Offers? offers;

  Data({
    this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Offers {
  @JsonKey(name: "cancelled-by-client")
  List<Offer>? cancelledByClient;
  @JsonKey(name: "pending-offer")
  List<Offer>? pendingOffer;
  @JsonKey(name: "pending-acceptance")
  List<Offer>? pendingAcceptance;

  Offers({
    this.cancelledByClient,
    this.pendingOffer,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}

@JsonSerializable()
class CancelledByClient {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reservation_type")
  ReservationType? reservationType;
  @JsonKey(name: "importance")
  CityId? importance;
  @JsonKey(name: "account_id")
  Id? accountId;
  @JsonKey(name: "lawyer_id")
  Id? lawyerId;
  @JsonKey(name: "price")
  dynamic price;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "day")
  DateTime? day;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "hours")
  int? hours;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "region_id")
  RegionId? regionId;
  @JsonKey(name: "city_id")
  CityId? cityId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  CancelledByClient({
    this.id,
    this.reservationType,
    this.importance,
    this.accountId,
    this.lawyerId,
    this.price,
    this.description,
    this.file,
    this.longitude,
    this.latitude,
    this.day,
    this.from,
    this.to,
    this.hours,
    this.status,
    this.regionId,
    this.cityId,
    this.createdAt,
    this.updatedAt,
  });

  factory CancelledByClient.fromJson(Map<String, dynamic> json) =>
      _$CancelledByClientFromJson(json);

  Map<String, dynamic> toJson() => _$CancelledByClientToJson(this);
}

@JsonSerializable()
class Id {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "nationality")
  Country? nationality;
  @JsonKey(name: "country")
  Country? country;
  @JsonKey(name: "region")
  Country? region;
  @JsonKey(name: "city")
  CityId? city;
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
  CityId? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  CityId? generalSpecialty;
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

  Id({
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
  });

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);
}

@JsonSerializable()
class CityId {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  CityId({
    this.id,
    this.title,
  });

  factory CityId.fromJson(Map<String, dynamic> json) => _$CityIdFromJson(json);

  Map<String, dynamic> toJson() => _$CityIdToJson(this);
}

@JsonSerializable()
class Country {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
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
class RegionId {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "cities")
  List<CityId>? cities;

  RegionId({
    this.id,
    this.name,
    this.cities,
  });

  factory RegionId.fromJson(Map<String, dynamic> json) =>
      _$RegionIdFromJson(json);

  Map<String, dynamic> toJson() => _$RegionIdToJson(this);
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

  ReservationType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) =>
      _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
}

@JsonSerializable()
class Offer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reservation_type")
  ReservationType? reservationType;
  @JsonKey(name: "importance")
  CityId? importance;
  @JsonKey(name: "account_id")
  AccountId? accountId;
  @JsonKey(name: "lawyer_id")
  Id? lawyerId;
  @JsonKey(name: "price")
  dynamic price;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "day")
  DateTime? day;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "hours")
  int? hours;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "region_id")
  RegionId? regionId;
  @JsonKey(name: "city_id")
  CityId? cityId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Offer({
    this.id,
    this.reservationType,
    this.importance,
    this.accountId,
    this.lawyerId,
    this.price,
    this.description,
    this.file,
    this.longitude,
    this.latitude,
    this.day,
    this.from,
    this.to,
    this.hours,
    this.status,
    this.regionId,
    this.cityId,
    this.createdAt,
    this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}

@JsonSerializable()
class AccountId {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "nationality")
  Country? nationality;
  @JsonKey(name: "country")
  Country? country;
  @JsonKey(name: "region")
  Country? region;
  @JsonKey(name: "city")
  CityId? city;
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
  CityId? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  CityId? generalSpecialty;
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

  AccountId({
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
  });

  factory AccountId.fromJson(Map<String, dynamic> json) =>
      _$AccountIdFromJson(json);

  Map<String, dynamic> toJson() => _$AccountIdToJson(this);
}
