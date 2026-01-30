import 'package:json_annotation/json_annotation.dart';

part 'my_clients_response.g.dart';

@JsonSerializable()
class MyClientsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyClientsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyClientsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyClientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyClientsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "clients")
  List<Client>? clients;

  Data({
    this.clients,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Client {
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
  AccurateSpecialty? city;
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
  AccurateSpecialty? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  AccurateSpecialty? generalSpecialty;
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

  Client({
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

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
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
