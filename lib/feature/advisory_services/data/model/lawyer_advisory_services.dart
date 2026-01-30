import 'package:json_annotation/json_annotation.dart';

part 'lawyer_advisory_services.g.dart';

@JsonSerializable()
class LawyerAdvisoryServicesResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawyerAdvisoryServicesResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawyerAdvisoryServicesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$LawyerAdvisoryServicesResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LawyerAdvisoryServicesResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawyerServices")
  List<LawyerService>? lawyerServices;

  Data({
    this.lawyerServices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LawyerService {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "payment_category_id")
  int? paymentCategoryId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "types")
  List<Type>? types;
  @JsonKey(name: "available_dates")
  List<AvailableDate>? availableDates;

  LawyerService({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.image,
    this.needAppointment,
    this.paymentCategoryId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.types,
    this.availableDates,
  });

  factory LawyerService.fromJson(Map<String, dynamic> json) =>
      _$LawyerServiceFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerServiceToJson(this);
}

@JsonSerializable()
class AvailableDate {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "advisory_services_id")
  int? advisoryServicesId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  dynamic updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "is_ymtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer_id")
  int? lawyerId;
  @JsonKey(name: "available_times")
  List<AvailableTime>? availableTimes;

  AvailableDate({
    this.id,
    this.advisoryServicesId,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isYmtaz,
    this.lawyerId,
    this.availableTimes,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) =>
      _$AvailableDateFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDateToJson(this);
}

@JsonSerializable()
class AvailableTime {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "advisory_services_id")
  int? advisoryServicesId;
  @JsonKey(name: "advisory_services_available_dates_id")
  int? advisoryServicesAvailableDatesId;
  @JsonKey(name: "time_from")
  String? timeFrom;
  @JsonKey(name: "time_to")
  String? timeTo;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  dynamic updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;

  AvailableTime({
    this.id,
    this.advisoryServicesId,
    this.advisoryServicesAvailableDatesId,
    this.timeFrom,
    this.timeTo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AvailableTime.fromJson(Map<String, dynamic> json) =>
      _$AvailableTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableTimeToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_id")
  int? advisoryServiceId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "advisory_services_prices")
  List<AdvisoryServicesPrice>? advisoryServicesPrices;

  Type({
    this.id,
    this.title,
    this.advisoryServiceId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.advisoryServicesPrices,
  });



  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class AdvisoryServicesPrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "advisory_service_id")
  int? advisoryServiceId;
  @JsonKey(name: "client_reservations_importance_id")
  int? clientReservationsImportanceId;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "created_at")
  dynamic createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "is_ymtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer_id")
  int? lawyerId;
  @JsonKey(name: "importance")
  Importance? importance;

  toString() => "${importance?.title} - $price";

  AdvisoryServicesPrice({
    this.id,
    this.advisoryServiceId,
    this.clientReservationsImportanceId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isYmtaz,
    this.lawyerId,
    this.importance,
  });

  factory AdvisoryServicesPrice.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesPriceToJson(this);
}

@JsonSerializable()
class Importance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;

  Importance({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Importance.fromJson(Map<String, dynamic> json) =>
      _$ImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$ImportanceToJson(this);
}
