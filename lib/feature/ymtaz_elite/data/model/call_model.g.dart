// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallModel _$CallModelFromJson(Map<String, dynamic> json) => CallModel(
      id: json['id'] as String?,
      callerId: (json['caller_id'] as num?)?.toInt(),
      receiverId: (json['receiver_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      channelName: json['channel_name'] as String?,
      token: json['token'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$CallModelToJson(CallModel instance) => <String, dynamic>{
      'id': instance.id,
      'caller_id': instance.callerId,
      'receiver_id': instance.receiverId,
      'type': instance.type,
      'channel_name': instance.channelName,
      'token': instance.token,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
