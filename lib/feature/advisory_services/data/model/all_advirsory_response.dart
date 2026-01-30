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
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "file")
  dynamic file;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "accept_date")
  dynamic acceptDate;
  @JsonKey(name: "reservation_status")
  String? reservationStatus;
  @JsonKey(name: "advisory_services_id")
  AdvisoryServicesId? advisoryServicesId;
  @JsonKey(name: "type")
  Importance? type;
  @JsonKey(name: "importance")
  Importance? importance;
  @JsonKey(name: "appointment")
  Appointment? appointment;
  @JsonKey(name: "lawyer")
  dynamic lawyer;
  @JsonKey(name: "rate")
  dynamic rate;
  @JsonKey(name: "comment")
  dynamic comment;
  @JsonKey(name: "reply")
  Reply? reply;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "call_id")
  String? callId;
  @JsonKey(name: "created_at")
  String? createdAt;

  Reservation({
    this.id,
    this.description,
    this.file,
    this.paymentStatus,
    this.price,
    this.acceptDate,
    this.reservationStatus,
    this.advisoryServicesId,
    this.type,
    this.importance,
    this.appointment,
    this.lawyer,
    this.rate,
    this.comment,
    this.reply,
    this.createdAt
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
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePrice>? advisoryServicePrices;

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
    this.advisoryServicePrices,
  });

  factory AdvisoryServicesId.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesIdFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesIdToJson(this);
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

@JsonSerializable()
class AvailableDate {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "times")
  List<Appointment>? times;

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
class Appointment {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "time_from")
  String? timeFrom;
  @JsonKey(name: "time_to")
  String? timeTo;
  @JsonKey(name: "date")
  DateTime? date;

  Appointment({
    this.id,
    this.timeFrom,
    this.timeTo,
    this.date,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
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
class Reply {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "reply")
  String? reply;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "attachment")
  dynamic attachment;
  @JsonKey(name: "created_at")
  String? createdAt;

  Reply({
    this.id,
    this.reply,
    this.from,
    this.attachment,
    this.createdAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
