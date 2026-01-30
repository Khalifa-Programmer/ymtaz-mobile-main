// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_code_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckCodeResponse _$CheckCodeResponseFromJson(Map<String, dynamic> json) =>
    CheckCodeResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckCodeResponseToJson(CheckCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      passCode: json['pass_code'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pass_code': instance.passCode,
    };
