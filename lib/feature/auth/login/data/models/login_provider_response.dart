import 'package:json_annotation/json_annotation.dart';
import 'package:yamtaz/core/shared/models/languages_response.dart';

import '../../../../layout/account/data/models/experience_model.dart';

part 'login_provider_response.g.dart';

@JsonSerializable()
class LoginProviderResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LoginProviderResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LoginProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginProviderResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "account")
  Account? account;

  Data({
    this.account,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        account: json['account'] != null
            ? Account.fromJson(json['account'] as Map<String, dynamic>)
            : (json['user'] != null
                ? Account.fromJson(json['user'] as Map<String, dynamic>)
                : null),
      );

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Account {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "second_name")
  String? secondName;
  @JsonKey(name: "third_name")
  String? thirdName;
  @JsonKey(name: "fourth_name")
  String? fourthName;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "birth_date")
  DateTime? birthday;
  @JsonKey(name: "image")
  String? photo;
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
  @JsonKey(name: "national_id")
  String? natId;
  @JsonKey(name: "functional_cases")
  AccurateSpecialtyUser? functionalCases;
  @JsonKey(name: "licence_no")
  String? licenceNo;
  @JsonKey(name: "is_favorite")
  int? isFavorite;
  @JsonKey(name: "office_request_status")
  int? officeRequestStatus;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "sections")
  List<SectionElement>? sections;
  @JsonKey(name: "rates_count")
  dynamic ratesCount;
  @JsonKey(name: "rates_avg")
  dynamic ratesAvg;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "accepted")
  int? accepted;

  @JsonKey(name: "confirmationType")
  String? confirmationType;
  @JsonKey(name: "streamio_id")
  String? streamioId;
  @JsonKey(name: "streamio_token")
  String? streamioToken;

  // New fields
  @JsonKey(name: "currentLevel")
  int? currentLevel; // Added: current level
  @JsonKey(name: "xp")
  int? xp; // Added: experience points
  @JsonKey(name: "xpUntilNextLevel")
  int? xpUntilNextLevel; // Added: XP needed for the next level
  @JsonKey(name: "currentRank")
  Rank? currentRank; // Added: Current rank with its properties
  @JsonKey(name: "lastSeen")
  String? lastSeen; // Added: last seen timestamp
  @JsonKey(name: "referralCode")
  String? referralCode; // Added: referral code
  @JsonKey(name: "email_confirmation")
  int? emailConfirmation; // Added: email confirmation status
  @JsonKey(name: "phone_confirmation")
  int? phoneConfirmation; // Added: phone confirmation status
  @JsonKey(name: "profile_complete")
  int? profileComplete; // Added: profile completion status
  @JsonKey(name: "account_type")
  String? accountType; // Added: type of account (lawyer)
  @JsonKey(name: "accurate_specialty")
  Specialty? accurateSpecialty; // Added: accurate specialty
  @JsonKey(name: "general_specialty")
  Specialty? generalSpecialty; // Added: general specialty
  @JsonKey(name: "degree")
  Degree? degree; // Added: degree information
  @JsonKey(name: "phone_code")
  int? phoneCode;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;

  @JsonKey(name: "daysStreak")
  int? daysStreak;
  @JsonKey(name: "points")
  int? points;
  @JsonKey(name: "languages")
  List<Language>? languages;

  @JsonKey(name: "other_degree")
  String? otherDegree;

  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "company_lisences_file")
  dynamic companyLisencesFile;
  @JsonKey(name: "company_lisences_no")
  dynamic companyLisencesNo;
  @JsonKey(name: "company_name")
  dynamic companyName;
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
  @JsonKey(name: "office_request_from")
  dynamic officeRequestFrom;
  @JsonKey(name: "office_request_to")
  dynamic officeRequestTo;
  @JsonKey(name: "hasBadge")
  String? hasBadge;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "experiences")
  List<Experience>? experiences;
  @JsonKey(name: 'subscription')
  Subscription? package;

  Account(
      {this.id,
      this.firstName,
      this.secondName,
      this.thirdName,
      this.fourthName,
      this.name,
      this.email,
      this.gender,
      this.phone,
      this.about,
      this.birthday,
      this.photo,
      this.isFavorite,
      this.officeRequestStatus,
      this.special,
      this.sections,
      this.ratesCount,
      this.ratesAvg,
      this.token,
      this.accepted,
      this.confirmationType,
      this.streamioId,
      this.streamioToken,
      this.currentLevel, // Added
      this.xp, // Added
      this.xpUntilNextLevel, // Added
      this.currentRank, // Added
      this.lastSeen, // Added
      this.referralCode, // Added
      this.emailConfirmation, // Added
      this.phoneConfirmation, // Added
      this.profileComplete, // Added
      this.accountType, // Added
      this.accurateSpecialty, // Added
      this.generalSpecialty, // Added
      this.degree, // Added
      this.phoneCode, // Added
      this.package});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class Subscription {
  int? id;

  @JsonKey(name: 'package')
  Package? package;

  @JsonKey(name: 'start_date')
  String? startDate;

  @JsonKey(name: 'end_date')
  String? endDate;

  Subscription({
    this.id,
    this.package,
    this.startDate,
    this.endDate,
  });

  /// Factory constructor to create a `Subscription` instance from JSON.
  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  /// Method to convert a `Subscription` instance to JSON.
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}

@JsonSerializable()
class Package {
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'durationType')
  int? durationType;

  @JsonKey(name: 'duration')
  int? duration;

  Package({
    this.id,
    this.name,
    this.durationType,
    this.duration,
  });

  /// Factory constructor to create a `Package` instance from JSON.
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  /// Method to convert a `Package` instance to JSON.
  Map<String, dynamic> toJson() => _$PackageToJson(this);
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

@JsonSerializable()
class Rank {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "border_color")
  String? borderColor;
  @JsonKey(name: "image")
  String? image;

  Rank({
    this.id,
    this.name,
    this.borderColor,
    this.image,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);

  Map<String, dynamic> toJson() => _$RankToJson(this);
}

@JsonSerializable()
class Specialty {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  Specialty({
    this.id,
    this.title,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyToJson(this);
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
