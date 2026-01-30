import 'package:json_annotation/json_annotation.dart';

part 'service_lawyer_offres_response.g.dart';
@JsonSerializable()
class ServiceLawyerOffresResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ServiceLawyerOffresResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServiceLawyerOffresResponse.fromJson(Map<String, dynamic> json) => _$ServiceLawyerOffresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceLawyerOffresResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "offers")
  Offers? offers;

  Data({
    this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Offers {
  @JsonKey(name: "pending-acceptance")
  List<Declined>? pendingAcceptance;
  @JsonKey(name: "pending-offer")
  List<Declined>? pendingOffer;
  @JsonKey(name: "cancelled-by-client")
  List<dynamic>? cancelledByClient;
  @JsonKey(name: "declined")
  List<Declined>? declined;

  Offers({
    this.pendingAcceptance,
    this.pendingOffer,
    this.cancelledByClient,
    this.declined,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}

@JsonSerializable()
class Declined {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account")
  dynamic account;
  @JsonKey(name: "service")
  Service? service;
  @JsonKey(name: "priority")
  Priority? priority;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "files")
  List<FileElement>? files;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Declined({
    this.id,
    this.account,
    this.service,
    this.priority,
    this.description,
    this.files,
    this.price,
    this.lawyer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Declined.fromJson(Map<String, dynamic> json) => _$DeclinedFromJson(json);

  Map<String, dynamic> toJson() => _$DeclinedToJson(this);
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

  factory FileElement.fromJson(Map<String, dynamic> json) => _$FileElementFromJson(json);

  Map<String, dynamic> toJson() => _$FileElementToJson(this);
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

  factory Priority.fromJson(Map<String, dynamic> json) => _$PriorityFromJson(json);

  Map<String, dynamic> toJson() => _$PriorityToJson(this);
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

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

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
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "isHidden")
  int? isHidden;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
    this.duration,
    this.isHidden,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) => _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
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
