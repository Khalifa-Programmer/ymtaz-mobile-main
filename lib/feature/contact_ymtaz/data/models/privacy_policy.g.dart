// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyPolicy _$PrivacyPolicyFromJson(Map<String, dynamic> json) =>
    PrivacyPolicy(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivacyPolicyToJson(PrivacyPolicy instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      intro: json['intro'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'intro': instance.intro,
      'description': instance.description,
    };
