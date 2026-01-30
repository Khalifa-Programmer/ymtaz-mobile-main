import 'package:json_annotation/json_annotation.dart';

part 'avaliable_appointment_lawyer_model.g.dart';

@JsonSerializable()
class AvaliableAppointmentLawyerModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  AvaliableAppointmentLawyerModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AvaliableAppointmentLawyerModel.fromJson(Map<String, dynamic> json) => _$AvaliableAppointmentLawyerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvaliableAppointmentLawyerModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "reservation_type")
  ReservationType? reservationType;
  @JsonKey(name: "reservation_importance")
  ReservationImportance? reservationImportance;
  @JsonKey(name: "isYmtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer")
  Lawyer? lawyer;

  Datum({
    this.id,
    this.price,
    this.reservationType,
    this.reservationImportance,
    this.isYmtaz,
    this.lawyer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Lawyer {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "nationality")
  ReservationImportance? nationality;
  @JsonKey(name: "country")
  ReservationImportance? country;
  @JsonKey(name: "region")
  ReservationImportance? region;
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
class SectionElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "section")
  SectionSection? section;

  SectionElement({
    this.id,
    this.section,
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
class ReservationType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "minPrice")
  int? minPrice;
  @JsonKey(name: "maxPrice")
  int? maxPrice;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  dynamic createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "isHidden")
  int? isHidden;

  ReservationType({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isHidden,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) => _$ReservationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationTypeToJson(this);
}
