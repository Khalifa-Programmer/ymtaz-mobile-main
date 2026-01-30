// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_code_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckCodeRequestBody _$CheckCodeRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CheckCodeRequestBody(
      json['token'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$CheckCodeRequestBodyToJson(
        CheckCodeRequestBody instance) =>
    <String, dynamic>{
      'token': instance.pin_code,
      'email': instance.email,
    };
