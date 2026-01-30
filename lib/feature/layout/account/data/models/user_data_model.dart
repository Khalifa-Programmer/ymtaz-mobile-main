import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/shared/models/current_rank.dart';
import '../../../../../core/shared/models/languages_response.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  UserDataResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawyer")
  Client? client;

  Data({
    this.client,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Client {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "second_name")
  String? secondName;
  @JsonKey(name: "third_name")
  dynamic thirdName;
  @JsonKey(name: "fourth_name")
  String? fourthName;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "accurate_specialty")
  AccurateSpecialtyUser? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  AccurateSpecialtyUser? generalSpecialty;
  @JsonKey(name: "degree")
  UserDegree? degree;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "day")
  String? day;
  @JsonKey(name: "month")
  String? month;
  @JsonKey(name: "year")
  String? year;
  @JsonKey(name: "birthday")
  DateTime? birthday;
  @JsonKey(name: "nationality")
  UserNationality? nationality; // Add "User" prefix
  @JsonKey(name: "country")
  UserCountry? country; // Add "User" prefix
  @JsonKey(name: "region")
  UserRegion? region; // Add "User" prefix
  @JsonKey(name: "city")
  UserCity? city; // Add "User" prefix
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "identity_type")
  int? identityType;
  @JsonKey(name: "nat_id")
  String? natId;
  @JsonKey(name: "functional_cases")
  AccurateSpecialtyUser? functionalCases;
  @JsonKey(name: "licence_no")
  String? licenceNo;
  @JsonKey(name: "company_lisences_no")
  dynamic companyLisencesNo;
  @JsonKey(name: "company_name")
  dynamic companyName;
  @JsonKey(name: "office_request_status")
  int? officeRequestStatus;
  @JsonKey(name: "office_request_from")
  dynamic officeRequestFrom;
  @JsonKey(name: "office_request_to")
  dynamic officeRequestTo;
  @JsonKey(name: "is_favorite")
  int? isFavorite;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "id_file")
  String? idFile;
  @JsonKey(name: "license_file")
  dynamic licenseFile;
  @JsonKey(name: "cv")
  String? cv;
  @JsonKey(name: "degree_certificate")
  dynamic degreeCertificate;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "company_lisences_file")
  dynamic companyLisencesFile;
  @JsonKey(name: "accept_rules")
  int? acceptRules;
  @JsonKey(name: "sections")
  List<SectionElement>? sections;
  @JsonKey(name: "services")
  List<dynamic>? services;
  @JsonKey(name: "work_times")
  List<dynamic>? workTimes;
  @JsonKey(name: "rates_count")
  dynamic ratesCount;
  @JsonKey(name: "rates_avg")
  dynamic ratesAvg;
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

  @JsonKey(name: "xpUntilNextLevel")
  int? xpUntilNextLevel;
  @JsonKey(name: "confirmationType")
  String? confirmationType;

  @JsonKey(name: "other_degree")
  String? otherDegree;
  @JsonKey(name: "currentRank")
  CurrentRank? currentRank;
  @JsonKey(name: "referralCode")
  String? referralCode;
  @JsonKey(name: "lastSeen")
  String? lastSeen;

  @JsonKey(name: "accepted")
  int? accepted;

  @JsonKey(name: "languages")
  List<Language>? languages;

  //  "digital_guide_subscription": 1,
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;

  //             "digital_guide_subscription_payment_status": 1
  @JsonKey(name: "digital_guide_subscription_payment_status")
  int? digitalGuideSubscriptionPaymentStatus;

  //

  Client({
    this.id,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.name,
    this.email,
    this.phone,
    this.phoneCode,
    this.about,
    this.accurateSpecialty,
    this.generalSpecialty,
    this.degree,
    this.gender,
    this.day,
    this.month,
    this.year,
    this.birthday,
    this.nationality,
    this.country,
    this.region,
    this.city,
    this.longitude,
    this.latitude,
    this.type,
    this.identityType,
    this.natId,
    this.functionalCases,
    this.licenceNo,
    this.companyLisencesNo,
    this.companyName,
    this.officeRequestStatus,
    this.officeRequestFrom,
    this.officeRequestTo,
    this.isFavorite,
    this.special,
    this.logo,
    this.idFile,
    this.licenseFile,
    this.cv,
    this.degreeCertificate,
    this.photo,
    this.companyLisencesFile,
    this.acceptRules,
    this.sections,
    this.services,
    this.workTimes,
    this.ratesCount,
    this.ratesAvg,
    this.digitalGuideSubscription,
    this.digitalGuideSubscriptionPaymentStatus,
    this.streamioId,
    this.streamioToken,
    this.confirmationType,
    this.accepted,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class AccurateSpecialtyUser {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  AccurateSpecialtyUser({
    this.id,
    this.title,
  });

  factory AccurateSpecialtyUser.fromJson(Map<String, dynamic> json) =>
      _$AccurateSpecialtyUserFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyUserToJson(this);
}

@JsonSerializable()
class UserDegree {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "need_certificate")
  int? needCertificate;

  UserDegree({
    this.id,
    this.title,
    this.needCertificate,
  });

  factory UserDegree.fromJson(Map<String, dynamic> json) =>
      _$UserDegreeFromJson(json);

  Map<String, dynamic> toJson() => _$UserDegreeToJson(this);
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
class UserCountry {
  // Add "User" prefix
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  UserCountry({
    this.id,
    this.name,
  });

  factory UserCountry.fromJson(Map<String, dynamic> json) =>
      _$UserCountryFromJson(json);

  Map<String, dynamic> toJson() => _$UserCountryToJson(this);
}

@JsonSerializable()
class UserRegion {
  // Add "User" prefix
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  UserRegion({
    this.id,
    this.name,
  });

  factory UserRegion.fromJson(Map<String, dynamic> json) =>
      _$UserRegionFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegionToJson(this);
}

@JsonSerializable()
class UserCity {
  // Add "User" prefix
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  UserCity({
    this.id,
    this.title,
  });

  factory UserCity.fromJson(Map<String, dynamic> json) =>
      _$UserCityFromJson(json);

  Map<String, dynamic> toJson() => _$UserCityToJson(this);
}

@JsonSerializable()
class UserNationality {
  // Add "User" prefix
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  UserNationality({
    this.id,
    this.name,
  });

  factory UserNationality.fromJson(Map<String, dynamic> json) =>
      _$UserNationalityFromJson(json);

  Map<String, dynamic> toJson() => _$UserNationalityToJson(this);
}
