// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetRequestBody _$ForgetRequestBodyFromJson(Map<String, dynamic> json) =>
    ForgetRequestBody(
      json['credential'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$ForgetRequestBodyToJson(ForgetRequestBody instance) =>
    <String, dynamic>{
      'credential': instance.email,
      'type': instance.type,
    };
