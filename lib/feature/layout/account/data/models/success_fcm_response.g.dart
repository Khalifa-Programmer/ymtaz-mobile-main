// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_fcm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessFcmResponse _$SuccessFcmResponseFromJson(Map<String, dynamic> json) =>
    SuccessFcmResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$SuccessFcmResponseToJson(SuccessFcmResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
