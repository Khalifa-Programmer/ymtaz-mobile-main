import 'package:json_annotation/json_annotation.dart';

part 'packages_model.g.dart';

@JsonSerializable()
class PackagesModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PackagesModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => _$PackagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackagesModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "packages")
  List<Package>? packages;

  Data({
    this.packages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Package {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "durationType")
  int? durationType;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "priceBeforeDiscount")
  int? priceBeforeDiscount;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "number_of_advisory_services")
  int? numberOfAdvisoryServices;
  @JsonKey(name: "number_of_services")
  int? numberOfServices;
  @JsonKey(name: "number_of_reservations")
  int? numberOfReservations;
  @JsonKey(name: "subscribed")
  bool? subscribed;
  @JsonKey(name: "services")
  List<Service>? services;
  @JsonKey(name: "advisoryServicesTypes")
  List<AdvisoryServicesType>? advisoryServicesTypes;
  @JsonKey(name: "reservations")
  List<Reservation>? reservations;
  @JsonKey(name: "permissions")
  List<Permission>? permissions;

  Package({
    this.id,
    this.name,
    this.instructions,
    this.durationType,
    this.duration,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.numberOfAdvisoryServices,
    this.numberOfServices,
    this.numberOfReservations,
    this.subscribed,
    this.services,
    this.advisoryServicesTypes,
    this.reservations,
    this.permissions,
  });

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@JsonSerializable()
class AdvisoryServicesType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePrice>? advisoryServicePrices;

  AdvisoryServicesType({
    this.id,
    this.title,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.advisoryServicePrices,
  });

  factory AdvisoryServicesType.fromJson(Map<String, dynamic> json) => _$AdvisoryServicesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesTypeToJson(this);
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

  factory AdvisoryServicePrice.fromJson(Map<String, dynamic> json) => _$AdvisoryServicePriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "minPrice")
  int? minPrice;
  @JsonKey(name: "maxPrice")
  int? maxPrice;
  @JsonKey(name: "typesImportance")
  List<TypesImportance>? typesImportance;

  Reservation({
    this.id,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.typesImportance,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}

@JsonSerializable()
class TypesImportance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "reservation_importance_id")
  int? reservationImportanceId;
  @JsonKey(name: "reservation_importance")
  ReservationImportance? reservationImportance;
  @JsonKey(name: "isYmtaz")
  int? isYmtaz;
  @JsonKey(name: "lawyer")
  dynamic lawyer;

  TypesImportance({
    this.id,
    this.price,
    this.reservationImportanceId,
    this.reservationImportance,
    this.isYmtaz,
    this.lawyer,
  });

  factory TypesImportance.fromJson(Map<String, dynamic> json) => _$TypesImportanceFromJson(json);

  Map<String, dynamic> toJson() => _$TypesImportanceToJson(this);
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
  ReservationImportance? level;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "isHidden")
  int? isHidden;

  YmtazLevelsPrice({
    this.id,
    this.level,
    this.price,
    this.isHidden,
  });

  factory YmtazLevelsPrice.fromJson(Map<String, dynamic> json) => _$YmtazLevelsPriceFromJson(json);

  Map<String, dynamic> toJson() => _$YmtazLevelsPriceToJson(this);
}
@JsonSerializable()
class Permission {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Permission({
    this.id,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}
