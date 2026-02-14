import 'package:json_annotation/json_annotation.dart';

part 'appointment_offers_client.g.dart';

@JsonSerializable()
class AppointmentOffersClient {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AppointmentOffersClient({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AppointmentOffersClient.fromJson(Map<String, dynamic> json) => _$AppointmentOffersClientFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentOffersClientToJson(this);
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
  @JsonKey(name: "accepted")
  List<Accepted>? accepted;
  @JsonKey(name: "pending-acceptance")
  List<Offer>? pendingAcceptance;
  @JsonKey(name: "pending-offer")
  List<Offer>? pendingOffer;
  @JsonKey(name: "cancelled-by-client")
  List<Offer>? cancelledByClient;

  Offers({
    this.accepted,
    this.pendingAcceptance,
    this.pendingOffer,
    this.cancelledByClient,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}

@JsonSerializable()
class Accepted {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account")
  Account? account;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "country_id")
  dynamic countryId;
  @JsonKey(name: "region_id")
  int? regionId;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "hours")
  int? hours;
  @JsonKey(name: "reservation_started")
  int? reservationStarted;
  @JsonKey(name: "reservation_startedTime")
  String? reservationStartedTime;
  @JsonKey(name: "reservation_code")
  String? reservationCode;
  @JsonKey(name: "lawyer")
  Lawyer? lawyer;
  @JsonKey(name: "reservationType")
  ReservationType? reservationType;
  @JsonKey(name: "reservationImportance")
  ReservationImportance? reservationImportance;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Accepted({
    this.id,
    this.account,
    this.description,
    this.longitude,
    this.latitude,
    this.date,
    this.from,
    this.to,
    this.countryId,
    this.regionId,
    this.file,
    this.price,
    this.hours,
    this.reservationStarted,
    this.reservationStartedTime,
    this.reservationCode,
    this.lawyer,
    this.reservationType,
    this.reservationImportance,
    this.createdAt,
    this.updatedAt,
  });

  factory Accepted.fromJson(Map<String, dynamic> json) => _$AcceptedFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedToJson(this);
}

@JsonSerializable()
class Account {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "phone_code")
  int? phoneCode;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "nationality")
  Country? nationality;
  @JsonKey(name: "country")
  Country? country;
  @JsonKey(name: "region")
  Country? region;
  @JsonKey(name: "city")
  ReservationImportance? city;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "token")
  dynamic token;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "streamio_id")
  String? streamioId;
  @JsonKey(name: "streamio_token")
  String? streamioToken;
  @JsonKey(name: "daysStreak")
  int? daysStreak;
  @JsonKey(name: "points")
  int? points;
  @JsonKey(name: "xp")
  int? xp;
  @JsonKey(name: "currentLevel")
  int? currentLevel;
  @JsonKey(name: "currentRank")
  CurrentRank? currentRank;
  @JsonKey(name: "xpUntilNextLevel")
  int? xpUntilNextLevel;
  @JsonKey(name: "referralCode")
  String? referralCode;
  @JsonKey(name: "lastSeen")
  String? lastSeen;
  @JsonKey(name: "email_confirmation")
  int? emailConfirmation;
  @JsonKey(name: "phone_confirmation")
  int? phoneConfirmation;
  @JsonKey(name: "profile_complete")
  int? profileComplete;
  @JsonKey(name: "account_type")
  String? accountType;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "second_name")
  String? secondName;
  @JsonKey(name: "third_name")
  dynamic thirdName;
  @JsonKey(name: "fourth_name")
  String? fourthName;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "accurate_specialty")
  ReservationImportance? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  ReservationImportance? generalSpecialty;
  @JsonKey(name: "degree")
  Degree? degree;
  @JsonKey(name: "day")
  String? day;
  @JsonKey(name: "month")
  String? month;
  @JsonKey(name: "year")
  String? year;
  @JsonKey(name: "birth_date")
  String? birthDate;
  @JsonKey(name: "identity_type")
  int? identityType;
  @JsonKey(name: "national_id")
  String? nationalId;
  @JsonKey(name: "functional_cases")
  ReservationImportance? functionalCases;
  @JsonKey(name: "company_name")
  String? companyName;
  @JsonKey(name: "is_favorite")
  int? isFavorite;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "id_file")
  String? idFile;
  @JsonKey(name: "cv")
  String? cv;
  @JsonKey(name: "degree_certificate")
  String? degreeCertificate;
  @JsonKey(name: "company_licences_no")
  dynamic companyLicencesNo;
  @JsonKey(name: "company_licenses_file")
  dynamic companyLicensesFile;
  @JsonKey(name: "sections")
  List<AccountSection>? sections;
  @JsonKey(name: "work_times")
  List<WorkTime>? workTimes;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "languages")
  List<dynamic>? languages;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;
  @JsonKey(name: "hasBadge")
  dynamic hasBadge;

  Account({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.phoneCode,
    this.type,
    this.image,
    this.nationality,
    this.country,
    this.region,
    this.city,
    this.longitude,
    this.latitude,
    this.gender,
    this.token,
    this.status,
    this.createdAt,
    this.streamioId,
    this.streamioToken,
    this.daysStreak,
    this.points,
    this.xp,
    this.currentLevel,
    this.currentRank,
    this.xpUntilNextLevel,
    this.referralCode,
    this.lastSeen,
    this.emailConfirmation,
    this.phoneConfirmation,
    this.profileComplete,
    this.accountType,
    this.subscribed,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.about,
    this.accurateSpecialty,
    this.generalSpecialty,
    this.degree,
    this.day,
    this.month,
    this.year,
    this.birthDate,
    this.identityType,
    this.nationalId,
    this.functionalCases,
    this.companyName,
    this.isFavorite,
    this.special,
    this.logo,
    this.idFile,
    this.cv,
    this.degreeCertificate,
    this.companyLicencesNo,
    this.companyLicensesFile,
    this.sections,
    this.workTimes,
    this.digitalGuideSubscription,
    this.languages,
    this.permissions,
    this.hasBadge,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class ReservationImportance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  ReservationImportance({
    this.id,
    this.title,
  });

  factory ReservationImportance.fromJson(Map<String, dynamic> json) => _$ReservationImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationImportanceToJson(this);
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

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

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
class AccountSection {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;
  @JsonKey(name: "lawyer_license_no")
  String? lawyerLicenseNo;
  @JsonKey(name: "lawyer_license_file")
  String? lawyerLicenseFile;

  AccountSection({
    this.id,
    this.section,
    this.lawyerLicenseNo,
    this.lawyerLicenseFile,
  });

  factory AccountSection.fromJson(Map<String, dynamic> json) => _$AccountSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AccountSectionToJson(this);
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
class WorkTime {
  @JsonKey(name: "service")
  String? service;
  @JsonKey(name: "days")
  List<Day>? days;

  WorkTime({
    this.service,
    this.days,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) => _$WorkTimeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);
}

@JsonSerializable()
class Day {
  @JsonKey(name: "dayOfWeek")
  String? dayOfWeek;
  @JsonKey(name: "timeSlots")
  List<TimeSlot>? timeSlots;

  Day({
    this.dayOfWeek,
    this.timeSlots,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class TimeSlot {
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;

  TimeSlot({
    this.from,
    this.to,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class Lawyer {
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
  ReservationImportance? city;
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
  ReservationImportance? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  ReservationImportance? generalSpecialty;
  @JsonKey(name: "degree")
  Degree? degree;
  @JsonKey(name: "is_favorite")
  int? isFavorite;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "sections")
  List<LawyerSection>? sections;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;
  @JsonKey(name: "hasBadge")
  dynamic hasBadge;

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
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerToJson(this);
}

@JsonSerializable()
class LawyerSection {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;

  LawyerSection({
    this.id,
    this.section,
  });

  factory LawyerSection.fromJson(Map<String, dynamic> json) => _$LawyerSectionFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerSectionToJson(this);
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

  factory ReservationType.fromJson(Map<String, dynamic> json) => _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
}

@JsonSerializable()
class Offer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reservation_type")
  ReservationType? reservationType;
  @JsonKey(name: "importance")
  ReservationImportance? importance;
  @JsonKey(name: "account_id")
  Lawyer? accountId;
  @JsonKey(name: "lawyer_id")
  Lawyer? lawyerId;
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
  ReservationImportance? cityId;
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
class RegionId {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "cities")
  List<ReservationImportance>? cities;

  RegionId({
    this.id,
    this.name,
    this.cities,
  });

  factory RegionId.fromJson(Map<String, dynamic> json) => _$RegionIdFromJson(json);

  Map<String, dynamic> toJson() => _$RegionIdToJson(this);
}
