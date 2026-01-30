// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyRequestBody _$VerifyRequestBodyFromJson(Map<String, dynamic> json) =>
    VerifyRequestBody(
      json['otp_code'] as String,
      json['client_id'] as String,
    );

Map<String, dynamic> _$VerifyRequestBodyToJson(VerifyRequestBody instance) =>
    <String, dynamic>{
      'otp_code': instance.code,
      'client_id': instance.clientid,
    };
