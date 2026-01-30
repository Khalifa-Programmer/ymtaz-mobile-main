import 'package:json_annotation/json_annotation.dart';

part 'services_request_response.g.dart';

@JsonSerializable()
class ServicesRequestResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ServicesRequestResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ServicesRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesRequestResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "service_request")
  ServiceRequest? serviceRequest;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_url")
  String? paymentUrl;

  Data({
    this.serviceRequest,
    this.transactionId,
    this.paymentUrl,
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
  dynamic replay;
  @JsonKey(name: "replay_file")
  dynamic replayFile;
  @JsonKey(name: "replay_time")
  dynamic replayTime;
  @JsonKey(name: "replay_date")
  dynamic replayDate;
  @JsonKey(name: "referral_status")
  int? referralStatus;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
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
    this.lawyer,
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
