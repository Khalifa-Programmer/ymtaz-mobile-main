// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashResponse _$SplashResponseFromJson(Map<String, dynamic> json) =>
    SplashResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$SplashResponseToJson(SplashResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
