// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessModel _$SuccessModelFromJson(Map<String, dynamic> json) => SuccessModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$SuccessModelToJson(SuccessModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
