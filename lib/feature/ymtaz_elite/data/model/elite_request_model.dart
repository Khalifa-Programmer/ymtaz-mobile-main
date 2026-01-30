import 'package:json_annotation/json_annotation.dart';

part 'elite_request_model.g.dart';

@JsonSerializable()
class EliteRequestModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  EliteRequestModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory EliteRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EliteRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EliteRequestModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "elite_service_category_id")
  String? eliteServiceCategoryId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "transaction_complete")
  dynamic transactionComplete;
  @JsonKey(name: "transaction_id")
  dynamic transactionId;
  @JsonKey(name: "status")
  dynamic status;
  @JsonKey(name: "files")
  List<FileElement>? files;

  Data({
    this.id,
    this.accountId,
    this.eliteServiceCategoryId,
    this.description,
    this.transactionComplete,
    this.transactionId,
    this.status,
    this.files,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
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

  factory FileElement.fromJson(Map<String, dynamic> json) =>
      _$FileElementFromJson(json);

  Map<String, dynamic> toJson() => _$FileElementToJson(this);
}
