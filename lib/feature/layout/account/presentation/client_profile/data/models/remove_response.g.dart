// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveResponse _$RemoveResponseFromJson(Map<String, dynamic> json) =>
    RemoveResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$RemoveResponseToJson(RemoveResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
