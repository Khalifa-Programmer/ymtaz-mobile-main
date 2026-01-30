import 'package:json_annotation/json_annotation.dart';

part 'services_from_provider_response.g.dart';

@JsonSerializable()
class ServicesFromProviderResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ServicesFromProviderResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesFromProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesFromProviderResponseToJson(this);
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
  String? replay;
  @JsonKey(name: "replay_file")
  dynamic replayFile;
  @JsonKey(name: "replay_time")
  String? replayTime;
  @JsonKey(name: "replay_date")
  String? replayDate;
  @JsonKey(name: "referral_status")
  int? referralStatus;
  @JsonKey(name: "requesterLawyer")
  RequesterLawyer? requesterLawyer;
  @JsonKey(name: "rate")
  dynamic rate;
  @JsonKey(name: "comment")
  dynamic comment;

  ServiceRequest({
    this.id,
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
    this.requesterLawyer,
    this.rate,
    this.comment,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestToJson(this);
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
class RequesterLawyer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "second_name")
  String? secondName;
  @JsonKey(name: "third_name")
  String? thirdName;
  @JsonKey(name: "fourth_name")
  String? fourthName;

  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "identity_type")
  int? identityType;

  @JsonKey(name: "logo")
  String? logo;

  @JsonKey(name: "photo")
  String? photo;

  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "digital_guide_subscription_payment_status")
  int? digitalGuideSubscriptionPaymentStatus;

  RequesterLawyer({
    this.id,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.name,
    this.type,
    this.identityType,
    this.logo,
    this.photo,
    this.digitalGuideSubscription,
    this.digitalGuideSubscriptionPaymentStatus,
  });

  factory RequesterLawyer.fromJson(Map<String, dynamic> json) =>
      _$RequesterLawyerFromJson(json);

  Map<String, dynamic> toJson() => _$RequesterLawyerToJson(this);
}

@JsonSerializable()
class Level {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
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
  Level? level;
  @JsonKey(name: "price")
  int? price;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) =>
      _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}
