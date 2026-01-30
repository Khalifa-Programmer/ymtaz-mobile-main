import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'elite_pricing_requests_model.g.dart';

@JsonSerializable()
class ElitePricingRequestsModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ElitePricingRequestsModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ElitePricingRequestsModel.fromJson(Map<String, dynamic> json) => _$ElitePricingRequestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ElitePricingRequestsModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "pendingPricing")
  List<PendingPricing>? pendingPricing;

  Data({
    this.pendingPricing,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class PendingPricing {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "elite_service_category")
  EliteServiceCategory? eliteServiceCategory;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;
  @JsonKey(name: "transaction_id")
  dynamic transactionId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "files")
  List<FileElement>? files;
  @JsonKey(name: "offers")
  dynamic offers;

  PendingPricing({
    this.id,
    this.accountId,
    this.eliteServiceCategory,
    this.description,
    this.transactionComplete,
    this.transactionId,
    this.status,
    this.createdAt,
    this.files,
    this.offers,
  });

  factory PendingPricing.fromJson(Map<String, dynamic> json) => _$PendingPricingFromJson(json);

  Map<String, dynamic> toJson() => _$PendingPricingToJson(this);
}

@JsonSerializable()
class EliteServiceCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  EliteServiceCategory({
    this.id,
    this.name,
  });

  factory EliteServiceCategory.fromJson(Map<String, dynamic> json) => _$EliteServiceCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$EliteServiceCategoryToJson(this);
}

@JsonSerializable()
class FileElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "elite_service_request_id")
  int? eliteServiceRequestId;
  @JsonKey(name: "advisory_services_reservations_id")
  dynamic advisoryServicesReservationsId;
  @JsonKey(name: "services_reservations_id")
  dynamic servicesReservationsId;
  @JsonKey(name: "reservations_id")
  dynamic reservationsId;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "is_voice")
  int? isVoice;
  @JsonKey(name: "is_reply")
  int? isReply;

  FileElement({
    this.id,
    this.eliteServiceRequestId,
    this.advisoryServicesReservationsId,
    this.servicesReservationsId,
    this.reservationsId,
    this.file,
    this.isVoice,
    this.isReply,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => _$FileElementFromJson(json);

  Map<String, dynamic> toJson() => _$FileElementToJson(this);
}
