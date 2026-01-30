import 'package:json_annotation/json_annotation.dart';

part 'my_advisors_response.g.dart';

@JsonSerializable()
class MyAdvisorsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyAdvisorsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyAdvisorsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyAdvisorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyAdvisorsResponseToJson(this);
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
  Importance? type;
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
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "phone")
  dynamic phone;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "image")
  dynamic image;
  @JsonKey(name: "available_dates")
  List<dynamic>? availableDates;

  AdvisoryServicesId({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.price,
    this.phone,
    this.needAppointment,
    this.image,
    this.availableDates,
  });

  factory AdvisoryServicesId.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesIdFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesIdToJson(this);
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
