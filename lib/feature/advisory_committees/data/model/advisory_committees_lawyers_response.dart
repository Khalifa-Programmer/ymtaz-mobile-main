import 'package:json_annotation/json_annotation.dart';

part 'advisory_committees_lawyers_response.g.dart';

@JsonSerializable()
class AdvisoryCommitteesLawyersResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryCommitteesLawyersResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryCommitteesLawyersResponse.fromJson(Map<String, dynamic> json) => _$AdvisoryCommitteesLawyersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryCommitteesLawyersResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "advisors_available_counts")
  int? advisorsAvailableCounts;
  @JsonKey(name: "advisors")
  List<Advisor>? advisors;

  Data({
    this.id,
    this.title,
    this.image,
    this.advisorsAvailableCounts,
    this.advisors,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Advisor {
  @JsonKey(name: "id")
  int? id;
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
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "accurate_specialty")
  AccurateSpecialty? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  AccurateSpecialty? generalSpecialty;
  @JsonKey(name: "degree")
  Degree? degree;
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
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "identity_type")
  int? identityType;
  @JsonKey(name: "nat_id")
  String? natId;
  @JsonKey(name: "functional_cases")
  AccurateSpecialty? functionalCases;
  @JsonKey(name: "company_lisences_no")
  dynamic companyLisencesNo;
  @JsonKey(name: "company_name")
  String? companyName;
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
  @JsonKey(name: "cv")
  String? cv;
  @JsonKey(name: "degree_certificate")
  String? degreeCertificate;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "company_lisences_file")
  dynamic companyLisencesFile;
  @JsonKey(name: "accept_rules")
  int? acceptRules;
  @JsonKey(name: "sections")
  List<SectionElement>? sections;
  @JsonKey(name: "work_times")
  List<dynamic>? workTimes;
  @JsonKey(name: "rates_count")
  dynamic ratesCount;
  @JsonKey(name: "rates_avg")
  dynamic ratesAvg;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "digital_guide_subscription_payment_status")
  int? digitalGuideSubscriptionPaymentStatus;
  @JsonKey(name: "accepted")
  int? accepted;

  Advisor({
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
    this.companyLisencesNo,
    this.companyName,
    this.officeRequestStatus,
    this.officeRequestFrom,
    this.officeRequestTo,
    this.isFavorite,
    this.special,
    this.logo,
    this.idFile,
    this.cv,
    this.degreeCertificate,
    this.photo,
    this.companyLisencesFile,
    this.acceptRules,
    this.sections,
    this.workTimes,
    this.ratesCount,
    this.ratesAvg,
    this.digitalGuideSubscription,
    this.digitalGuideSubscriptionPaymentStatus,
    this.accepted,
  });

  factory Advisor.fromJson(Map<String, dynamic> json) => _$AdvisorFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisorToJson(this);
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
class Degree {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "need_certificate")
  int? needCertificate;

  Degree({
    this.id,
    this.title,
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
