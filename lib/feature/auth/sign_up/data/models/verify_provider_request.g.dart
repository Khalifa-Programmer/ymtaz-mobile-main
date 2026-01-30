// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_provider_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyProviderRequest _$VerifyProviderRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyProviderRequest(
      email: json['email'] as String,
      phoneCode: (json['phone_code'] as num).toInt(),
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$VerifyProviderRequestToJson(
        VerifyProviderRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone_code': instance.phoneCode,
      'phone': instance.phone,
    };
