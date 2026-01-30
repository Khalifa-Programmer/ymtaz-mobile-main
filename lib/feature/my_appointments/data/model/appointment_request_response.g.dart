// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppontmentRequestResponse _$AppontmentRequestResponseFromJson(
        Map<String, dynamic> json) =>
    AppontmentRequestResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppontmentRequestResponseToJson(
        AppontmentRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservation: json['reservation'] == null
          ? null
          : Reservation.fromJson(json['reservation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservation': instance.reservation,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['reservation_type_id'] as num?)?.toInt(),
    )..importanceId = json['importance_id'];

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservation_type_id': instance.id,
      'importance_id': instance.importanceId,
    };
