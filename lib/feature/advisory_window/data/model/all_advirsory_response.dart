import 'package:json_annotation/json_annotation.dart';

part 'all_advirsory_response.g.dart';

@JsonSerializable()
class AllAdvisoryResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AllAdvisoryResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AllAdvisoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AllAdvisoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllAdvisoryResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservations")
  List<Reservation>? reservations;

  Data({
    this.reservations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account")
  Account? account;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "files")
  List<FileElement>? files;
  @JsonKey(name: "request_status")
  String? requestStatus;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "accept_date")
  String? acceptDate;
  @JsonKey(name: "reservation_status")
  String? reservationStatus;
  @JsonKey(name: "advisory_services_sub")
  AdvisoryServicesSub? advisoryServicesSub;
  @JsonKey(name: "importance")
  Importance? importance;
  @JsonKey(name: "created_at")
  String? createdAt;
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
  @JsonKey(name: "reply_status")
  int? replyStatus;
  @JsonKey(name: "reply_subject")
  dynamic replySubject;
  @JsonKey(name: "reply_content")
  dynamic replyContent;
  @JsonKey(name: "reply_files")
  List<dynamic>? replyFiles;
  @JsonKey(name: "reply_time")
  dynamic replyTime;
  @JsonKey(name: "reply_date")
  dynamic replyDate;

  Reservation({
    this.id,
    this.account,
    this.description,
    this.files,
    this.requestStatus,
    this.paymentStatus,
    this.price,
    this.acceptDate,
    this.reservationStatus,
    this.advisoryServicesSub,
    this.importance,
    this.createdAt,
    this.lawyer,
    this.from,
    this.to,
    this.date,
    this.callId,
    this.appointmentDuration,
    this.replyStatus,
    this.replySubject,
    this.replyContent,
    this.replyFiles,
    this.replyTime,
    this.replyDate,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
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
  Importance? city;
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
  Importance? accurateSpecialty;
  @JsonKey(name: "general_specialty")
  Importance? generalSpecialty;
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
  Importance? functionalCases;
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
    this.workTimes,
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
class Importance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  Importance({
    this.id,
    this.title,
  });

  factory Importance.fromJson(Map<String, dynamic> json) =>
      _$ImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ImportanceToJson(this);
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
class WorkTime {
  @JsonKey(name: "service")
  String? service;
  @JsonKey(name: "days")
  List<Day>? days;

  WorkTime({
    this.service,
    this.days,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);

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

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class AdvisoryServicesSub {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "general_category")
  GeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<Level>? levels;

  AdvisoryServicesSub({
    this.id,
    this.name,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.generalCategory,
    this.levels,
  });

  factory AdvisoryServicesSub.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesSubFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesSubToJson(this);
}

@JsonSerializable()
class GeneralCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  GeneralCategory({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory GeneralCategory.fromJson(Map<String, dynamic> json) =>
      _$GeneralCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralCategoryToJson(this);
}

@JsonSerializable()
class PaymentCategoryType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "requires_appointment")
  int? requiresAppointment;

  PaymentCategoryType({
    this.id,
    this.name,
    this.description,
    this.requiresAppointment,
  });

  factory PaymentCategoryType.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryTypeToJson(this);
}

@JsonSerializable()
class Level {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "level")
  Importance? level;
  @JsonKey(name: "price")
  String? price;

  Level({
    this.id,
    this.duration,
    this.level,
    this.price,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}

@JsonSerializable()
class FileElement {
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "is_voice")
  int? isVoice;
  @JsonKey(name: "is_reply")
  int? isReply;

  FileElement({
    this.file,
    this.isVoice,
    this.isReply,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) =>
      _$FileElementFromJson(json);

  Map<String, dynamic> toJson() => _$FileElementToJson(this);
}
