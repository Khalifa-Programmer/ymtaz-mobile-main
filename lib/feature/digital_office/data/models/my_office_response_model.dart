import 'package:json_annotation/json_annotation.dart';

part 'my_office_response_model.g.dart';

@JsonSerializable()
class MyOfficeResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  OfficeData? data;

  MyOfficeResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyOfficeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyOfficeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOfficeResponseModelToJson(this);
}

@JsonSerializable()
class OfficeData {
  @JsonKey(name: "services")
  Services? services;
  @JsonKey(name: "advisoryServices")
  AdvisoryServices? advisoryServices;
  @JsonKey(name: "appointments")
  Appointments? appointments;
  @JsonKey(name: "wallet")
  Wallet? wallet;

  OfficeData({
    this.services,
    this.advisoryServices,
    this.appointments,
  });

  factory OfficeData.fromJson(Map<String, dynamic> json) =>
      _$OfficeDataFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeDataToJson(this);
}

@JsonSerializable()
class AdvisoryServices {
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "done")
  int? done;
  @JsonKey(name: "pending")
  int? pending;
  @JsonKey(name: "late")
  int? late;
  @JsonKey(name: "percentageChange")
  int? percentageChange;
  @JsonKey(name: "changeDirection")
  String? changeDirection;
  @JsonKey(name: "amounts")
  AdvisoryServicesAmounts? amounts;

  AdvisoryServices({
    this.total,
    this.done,
    this.pending,
    this.late,
    this.percentageChange,
    this.changeDirection,
    this.amounts,
  });

  factory AdvisoryServices.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesToJson(this);
}

@JsonSerializable()
class AdvisoryServicesAmounts {
  @JsonKey(name: "total")
  dynamic total; // Changed to dynamic
  @JsonKey(name: "done")
  dynamic done; // Changed to dynamic
  @JsonKey(name: "pending")
  dynamic pending; // Changed to dynamic
  @JsonKey(name: "late")
  dynamic late; // Changed to dynamic
  @JsonKey(name: "percentageChange")
  int? percentageChange;
  @JsonKey(name: "changeDirection")
  String? changeDirection;
  @JsonKey(name: "amounts")
  AdvisoryServicesAmounts? amounts;

  AdvisoryServicesAmounts({
    this.total,
    this.done,
    this.pending,
    this.late,
    this.percentageChange,
    this.changeDirection,
  });

  factory AdvisoryServicesAmounts.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicesAmountsFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicesAmountsToJson(this);
}

@JsonSerializable()
class Services {
  @JsonKey(name: "total")
  dynamic total; // Changed to dynamic
  @JsonKey(name: "done")
  dynamic done; // Changed to dynamic
  @JsonKey(name: "pending")
  dynamic pending; // Changed to dynamic
  @JsonKey(name: "late")
  dynamic late; // Changed to dynamic
  @JsonKey(name: "percentageChange")
  int? percentageChange;
  @JsonKey(name: "changeDirection")
  String? changeDirection;
  @JsonKey(name: "amounts")
  AdvisoryServicesAmounts? amounts;

  Services({
    this.total,
    this.done,
    this.pending,
    this.late,
  });

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable()
class Appointments {
  @JsonKey(name: "total")
  dynamic total; // Changed to dynamic
  @JsonKey(name: "done")
  dynamic done; // Changed to dynamic
  @JsonKey(name: "pending")
  dynamic pending; // Changed to dynamic
  @JsonKey(name: "late")
  dynamic late; // Changed to dynamic
  @JsonKey(name: "percentageChange")
  int? percentageChange;
  @JsonKey(name: "changeDirection")
  String? changeDirection;
  @JsonKey(name: "amounts")
  AdvisoryServicesAmounts? amounts;

  Appointments({
    this.total,
    this.done,
    this.pending,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) =>
      _$AppointmentsFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentsToJson(this);
}

@JsonSerializable()
class Wallet {
  @JsonKey(name: "pendingAction")
  int? pendingAction;
  @JsonKey(name: "pendingTransfer")
  int? pendingTransfer;
  @JsonKey(name: "transferred")
  int? transferred;
  @JsonKey(name: "total")
  int? total;

  Wallet({
    this.pendingAction,
    this.pendingTransfer,
    this.transferred,
    this.total,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
