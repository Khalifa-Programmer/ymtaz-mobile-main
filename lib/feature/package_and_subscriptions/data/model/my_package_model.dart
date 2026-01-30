import 'package:json_annotation/json_annotation.dart';

part 'my_package_model.g.dart';

@JsonSerializable()
class MyPackageModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyPackageModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyPackageModel.fromJson(Map<String, dynamic> json) => _$MyPackageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPackageModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "package")
  Package? package;
  @JsonKey(name: "remaining_services")
  int? remainingServices;
  @JsonKey(name: "remaining_advisory_services")
  int? remainingAdvisoryServices;
  @JsonKey(name: "remaining_reservations")
  int? remainingReservations;
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;

  Data({
    this.id,
    this.package,
    this.remainingServices,
    this.remainingAdvisoryServices,
    this.remainingReservations,
    this.startDate,
    this.endDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Package {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "durationType")
  int? durationType;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "priceBeforeDiscount")
  int? priceBeforeDiscount;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "number_of_advisory_services")
  int? numberOfAdvisoryServices;
  @JsonKey(name: "number_of_services")
  int? numberOfServices;
  @JsonKey(name: "number_of_reservations")
  int? numberOfReservations;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "services")
  List<Service>? services;
  @JsonKey(name: "advisoryServicesTypes")
  List<AdvisoryServicesType>? advisoryServicesTypes;
  @JsonKey(name: "reservations")
  List<Reservation>? reservations;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;

  Package({
    this.id,
    this.name,
    this.instructions,
    this.durationType,
    this.duration,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.numberOfAdvisoryServices,
    this.numberOfServices,
    this.numberOfReservations,
    this.subscribed,
    this.services,
    this.advisoryServicesTypes,
    this.reservations,
    this.permissions,
  });

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
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

  factory AdvisoryServicesType.fromJson(Map<String, dynamic> json) => _$AdvisoryServicesTypeFromJson(json);

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

  factory AdvisoryServicePrice.fromJson(Map<String, dynamic> json) => _$AdvisoryServicePriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceToJson(this);
}

@JsonSerializable()
class Reservation {
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

  Reservation({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.typesImportance,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
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

  factory TypesImportance.fromJson(Map<String, dynamic> json) => _$TypesImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$TypesImportanceToJson(this);
}

@JsonSerializable()
class Lawyer {
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
  ReservationImportance? nationality;
  @JsonKey(name: "country")
  ReservationImportance? country;
  @JsonKey(name: "region")
  ReservationImportance? region;
  @JsonKey(name: "city")
  AccurateSpecialty? city;
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
  AccurateSpecialty? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  AccurateSpecialty? generalSpecialty;
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
  AccurateSpecialty? functionalCases;
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
  List<SectionElement>? sections;
  @JsonKey(name: "work_times")
  List<WorkTime>? workTimes;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "languages")
  List<ReservationImportance>? languages;
  @JsonKey(name: "permissions")
  List<ReservationImportance>? permissions;
  @JsonKey(name: "hasBadge")
  String? hasBadge;

  Lawyer({
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

  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerToJson(this);
}

@JsonSerializable()
class AccurateSpecialty {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  AccurateSpecialty({
    this.id,
    this.title,
  });

  factory AccurateSpecialty.fromJson(Map<String, dynamic> json) => _$AccurateSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyToJson(this);
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

  factory ReservationImportance.fromJson(Map<String, dynamic> json) => _$ReservationImportanceFromJson(json);

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
class SectionElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;
  @JsonKey(name: "lawyer_license_no")
  dynamic lawyerLicenseNo;
  @JsonKey(name: "lawyer_license_file")
  dynamic lawyerLicenseFile;

  SectionElement({
    this.id,
    this.section,
    this.lawyerLicenseNo,
    this.lawyerLicenseFile,
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
  @JsonKey(name: "need_appointment")
  int? needAppointment;
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
    this.needAppointment,
    this.ymtazLevelsPrices,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "level")
  ReservationImportance? level;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "isHidden")
  int? isHidden;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
    this.isHidden,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) => _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}

@JsonSerializable()
class Permission {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Permission({
    this.id,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}
