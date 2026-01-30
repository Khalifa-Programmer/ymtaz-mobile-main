import 'package:json_annotation/json_annotation.dart';

part 'services_from_client_response.g.dart';

@JsonSerializable()
class ServicesFromClientsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ServicesFromClientsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesFromClientsResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromClientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesFromClientsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "service_requests")
  List<ServiceRequest>? serviceRequests;

  Data({
    this.serviceRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ServiceRequest {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account")
  Account? account;
  @JsonKey(name: "service")
  Service? service;
  @JsonKey(name: "priority")
  Priority? priority;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
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
  Account? lawyer;
  @JsonKey(name: "from")
  dynamic from;
  @JsonKey(name: "to")
  dynamic to;
  @JsonKey(name: "date")
  dynamic date;
  @JsonKey(name: "call_id")
  dynamic callId;
  @JsonKey(name: "appointment_duration")
  dynamic appointmentDuration;

  ServiceRequest({
    this.id,
    this.account,
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
    this.from,
    this.to,
    this.date,
    this.callId,
    this.appointmentDuration,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestToJson(this);
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
  Priority? city;
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
  Priority? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  Priority? generalSpecialty;
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
  Priority? functionalCases;
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

  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "languages")
  List<dynamic>? languages;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;
  @JsonKey(name: "hasBadge")
  String? hasBadge;

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
    this.digitalGuideSubscription,
    this.languages,
    this.permissions,
    this.hasBadge,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
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

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class YmtazLevelsPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "level")
  Country? level;
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

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) =>
      _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}
