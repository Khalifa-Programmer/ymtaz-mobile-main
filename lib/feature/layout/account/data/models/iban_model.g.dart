// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iban_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IbanModel _$IbanModelFromJson(Map<String, dynamic> json) => IbanModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IbanModelToJson(IbanModel instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      accountBankInfo: json['account_bank_info'] == null
          ? null
          : AccountBankInfo.fromJson(
              json['account_bank_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'account_bank_info': instance.accountBankInfo,
    };

AccountBankInfo _$AccountBankInfoFromJson(Map<String, dynamic> json) =>
    AccountBankInfo(
      id: (json['id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      bankName: json['bank_name'] as String?,
      accountNumber: json['account_number'] as String?,
    );

Map<String, dynamic> _$AccountBankInfoToJson(AccountBankInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'bank_name': instance.bankName,
      'account_number': instance.accountNumber,
    };
