// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      phoneCode: json['phone_code'] as String,
      type: (json['type'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      referredBy: json['referred_by'] as String?,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
        RegisterRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'phone_code': instance.phoneCode,
      'type': instance.type,
      'email': instance.email,
      'password': instance.password,
      'referred_by': instance.referredBy,
    };
