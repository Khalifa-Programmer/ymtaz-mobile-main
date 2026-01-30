import 'package:json_annotation/json_annotation.dart';

part 'iban_model.g.dart';

@JsonSerializable()
class IbanModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  IbanModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory IbanModel.fromJson(Map<String, dynamic> json) =>
      _$IbanModelFromJson(json);

  Map<String, dynamic> toJson() => _$IbanModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "account_bank_info")
  AccountBankInfo? accountBankInfo;

  Data({
    this.accountBankInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AccountBankInfo {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "bank_name")
  String? bankName;
  @JsonKey(name: "account_number")
  String? accountNumber;

  AccountBankInfo({
    this.id,
    this.accountId,
    this.bankName,
    this.accountNumber,
  });

  factory AccountBankInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountBankInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountBankInfoToJson(this);
}
