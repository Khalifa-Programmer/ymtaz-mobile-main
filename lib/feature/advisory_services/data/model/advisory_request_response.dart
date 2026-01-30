import 'package:json_annotation/json_annotation.dart';

part 'advisory_request_response.g.dart';

@JsonSerializable()
class AdvisoryRequestResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryRequestResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryRequestResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "reservation")
  Reservation? reservation;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_url")
  String? paymentUrl;

  Data({
    this.reservation,
    this.transactionId,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "replay_status")
  int? replayStatus;
  @JsonKey(name: "replay_subject")
  dynamic replaySubject;
  @JsonKey(name: "replay_content")
  dynamic replayContent;
  @JsonKey(name: "replay_file")
  dynamic replayFile;
  @JsonKey(name: "replay_time")
  dynamic replayTime;
  @JsonKey(name: "replay_date")
  dynamic replayDate;
  @JsonKey(name: "accept_date")
  dynamic acceptDate;
  @JsonKey(name: "reservation_status")
  String? reservationStatus;
  @JsonKey(name: "advisory_services_id")
  AdvisoryServicesId? advisoryServicesId;
  @JsonKey(name: "type")
  Type? type;
  @JsonKey(name: "importance")
  Importance? importance;
  @JsonKey(name: "appointment")
  dynamic appointment;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "rate")
  dynamic rate;
  @JsonKey(name: "comment")
  dynamic comment;

  Reservation({
    this.id,
    this.description,
    this.file,
    this.paymentStatus,
    this.price,
    this.replayStatus,
    this.replaySubject,
    this.replayContent,
    this.replayFile,
    this.replayTime,
    this.replayDate,
    this.acceptDate,
    this.reservationStatus,
    this.advisoryServicesId,
    this.type,
    this.importance,
    this.appointment,
    this.lawyer,
    this.rate,
    this.comment,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}

@JsonSerializable()
class AdvisoryServicesId {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "phone")
  dynamic phone;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "payment_category")
  PaymentCategory? paymentCategory;
  @JsonKey(name: "available_dates")
  List<AvailableDate>? availableDates;

  AdvisoryServicesId({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.phone,
    this.needAppointment,
    this.image,
    this.paymentCategory,
    this.availableDates,
  });

  factory AdvisoryServicesId.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesIdFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesIdToJson(this);
}

@JsonSerializable()
class AvailableDate {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "times")
  List<Time>? times;

  AvailableDate({
    this.id,
    this.date,
    this.times,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) =>
      _$AvailableDateFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDateToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "time_from")
  String? timeFrom;
  @JsonKey(name: "time_to")
  String? timeTo;

  Time({
    this.id,
    this.timeFrom,
    this.timeTo,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class PaymentCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "count")
  dynamic count;
  @JsonKey(name: "period")
  dynamic period;

  PaymentCategory({
    this.id,
    this.name,
    this.paymentMethod,
    this.count,
    this.period,
  });

  factory PaymentCategory.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryToJson(this);
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
class Type {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePrice>? advisoryServicePrices;

  Type({
    this.id,
    this.title,
    this.advisoryServicePrices,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class AdvisoryServicePrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_id")
  int? advisoryServiceId;
  @JsonKey(name: "request_level")
  int? requestLevel;
  @JsonKey(name: "price")
  int? price;

  AdvisoryServicePrice({
    this.id,
    this.title,
    this.advisoryServiceId,
    this.requestLevel,
    this.price,
  });

  factory AdvisoryServicePrice.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicePriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceToJson(this);
}
