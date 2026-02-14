import 'package:json_annotation/json_annotation.dart';

import '../../../layout/account/data/models/experience_model.dart';

part 'lawyer_model.g.dart';

@JsonSerializable()
class LawyerModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawyerModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerModelFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "account")
  Account? account;

  Data({
    this.account,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
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
  @JsonKey(name: "photo")
  String? photo;

  @JsonKey(name: "nationality")
  Country? nationality;
  @JsonKey(name: "country")
  Country? country;
  @JsonKey(name: "region")
  Country? region;
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
  dynamic streamioId;
  @JsonKey(name: "streamio_token")
  dynamic streamioToken;
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
  @JsonKey(name: "company_license_file")
  dynamic companyLicenseFile;
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
  dynamic degreeCertificate;
  @JsonKey(name: "company_licenses_file")
  dynamic companyLicensesFile;
  @JsonKey(name: "sections")
  List<SectionElement>? sections;
  @JsonKey(name: "work_times")
  List<dynamic>? workTimes;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "languages")
  List<Country>? languages;
  @JsonKey(name: "hasBadge")
  String? hasBadge;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "experiences")
  List<Experience>? experiences;

  Account({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.phoneCode,
    this.type,
    this.image,
    this.photo,
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
    this.companyLicenseFile,
    this.companyName,
    this.isFavorite,
    this.special,
    this.logo,
    this.idFile,
    this.cv,
    this.degreeCertificate,
    this.companyLicensesFile,
    this.sections,
    this.workTimes,
    this.digitalGuideSubscription,
    this.languages,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
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

  factory AccurateSpecialty.fromJson(Map<String, dynamic> json) =>
      _$AccurateSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyToJson(this);
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
class SectionElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;
  @JsonKey(name: "lawyer_license_no")
  String? lawyerLicenseNo;
  @JsonKey(name: "lawyer_license_file")
  dynamic lawyerLicenseFile;

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
