// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_provider_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyProviderOtpRequest _$VerifyProviderOtpRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyProviderOtpRequest(
      email: json['email'] as String,
      phoneCode: (json['phone_code'] as num).toInt(),
      phone: json['phone'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyProviderOtpRequestToJson(
        VerifyProviderOtpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone_code': instance.phoneCode,
      'phone': instance.phone,
      'otp': instance.otp,
    };
