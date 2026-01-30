// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestBody _$SignUpRequestBodyFromJson(Map<String, dynamic> json) =>
    SignUpRequestBody(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      phoneCode: json['phone_code'] as String,
      type: (json['type'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      activationType: (json['activation_type'] as num).toInt(),
      countryId: (json['country_id'] as num).toInt(),
      cityId: (json['city_id'] as num).toInt(),
      nationalityId: (json['nationality_id'] as num).toInt(),
      regionId: (json['region_id'] as num).toInt(),
      gender: json['gender'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      referredBy: json['referred_by'] as String?,
    );

Map<String, dynamic> _$SignUpRequestBodyToJson(SignUpRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'phone_code': instance.phoneCode,
      'type': instance.type,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'activation_type': instance.activationType,
      'country_id': instance.countryId,
      'city_id': instance.cityId,
      'nationality_id': instance.nationalityId,
      'region_id': instance.regionId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'referred_by': instance.referredBy,
    };
