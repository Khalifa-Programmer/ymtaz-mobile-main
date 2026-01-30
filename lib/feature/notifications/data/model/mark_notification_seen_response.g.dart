// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notification_seen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkNotificationSeenResponse _$MarkNotificationSeenResponseFromJson(
        Map<String, dynamic> json) =>
    MarkNotificationSeenResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$MarkNotificationSeenResponseToJson(
        MarkNotificationSeenResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
