// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_appointments_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessAppointmentsRequest _$SuccessAppointmentsRequestFromJson(
        Map<String, dynamic> json) =>
    SuccessAppointmentsRequest(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$SuccessAppointmentsRequestToJson(
        SuccessAppointmentsRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
