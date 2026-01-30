// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_time_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTimeResponseModel _$WorkTimeResponseModelFromJson(
        Map<String, dynamic> json) =>
    WorkTimeResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$WorkTimeResponseModelToJson(
        WorkTimeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
