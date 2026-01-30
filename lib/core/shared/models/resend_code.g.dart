// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendCode _$ResendCodeFromJson(Map<String, dynamic> json) => ResendCode(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResendCodeToJson(ResendCode instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
