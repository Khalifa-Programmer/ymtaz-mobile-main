// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_reply_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesReplySuccessResponse _$ServicesReplySuccessResponseFromJson(
        Map<String, dynamic> json) =>
    ServicesReplySuccessResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$ServicesReplySuccessResponseToJson(
        ServicesReplySuccessResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
