import 'package:json_annotation/json_annotation.dart';

part 'edit_provider_response.g.dart';

@JsonSerializable()
class EditProviderResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  EditProviderResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory EditProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditProviderResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawyer")
  Lawyer? lawyer;

  Data({
    this.lawyer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Lawyer {
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
  @JsonKey(name: "email")
  String? email;
  // @JsonKey(name: "gender")
  // String? gender;
  // @JsonKey(name: "phone")
  // String? phone;
  // @JsonKey(name: "about")
  // String? about;
  // @JsonKey(name: "birthday")
  // DateTime? birthday;
  // @JsonKey(name: "photo")
  // String? photo;
  // @JsonKey(name: "is_favorite")
  // int? isFavorite;
  // @JsonKey(name: "office_request_status")
  // int? officeRequestStatus;
  // @JsonKey(name: "special")
  // int? special;
  // @JsonKey(name: "sections")
  // List<SectionElement>? sections;
  // @JsonKey(name: "rates_count")
  // dynamic ratesCount;
  // @JsonKey(name: "rates_avg")
  // dynamic ratesAvg;
  @JsonKey(name: "token")
  dynamic token;
  @JsonKey(name: "accepted")
  int? accepted;
  @JsonKey(name: "active")
  int? active;
  @JsonKey(name: "confirmationType")
  String? confirmationType;
  // @JsonKey(name: "languages")
  // List<Language>? languages;
  // @JsonKey(name: "streamio_id")
  // String? streamioId;
  // @JsonKey(name: "streamio_token")
  // String? streamioToken;
  // @JsonKey(name: "createdAt")
  // String? createdAt;

  Lawyer({
    this.id,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.name,
    this.email,
    // this.gender,
    // this.phone,
    // this.about,
    // this.birthday,
    // this.photo,
    // this.isFavorite,
    // this.officeRequestStatus,
    // this.special,
    // this.sections,
    // this.ratesCount,
    // this.ratesAvg,
    this.token,
    this.accepted,
    this.active,
    this.confirmationType,
    // this.languages,
    // this.streamioId,
    // this.streamioToken,
    // this.createdAt,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerToJson(this);
}

@JsonSerializable()
class Language {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Language({
    this.id,
    this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
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
