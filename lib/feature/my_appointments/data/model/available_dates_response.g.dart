// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_dates_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableDatesResponse _$AvailableDatesResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableDatesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableDatesResponseToJson(
        AvailableDatesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      availableReservations: (json['availableReservations'] as List<dynamic>?)
          ?.map((e) => AvailableReservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'availableReservations': instance.availableReservations,
    };

AvailableReservation _$AvailableReservationFromJson(
        Map<String, dynamic> json) =>
    AvailableReservation(
      id: (json['id'] as num?)?.toInt(),
      isYmtaz: (json['isYmtaz'] as num?)?.toInt(),
      reservationTypeImportanceId:
          (json['reservation_type_importance_id'] as num?)?.toInt(),
      reservationTypeImportance: json['reservationTypeImportance'] == null
          ? null
          : ReservationTypeImportance.fromJson(
              json['reservationTypeImportance'] as Map<String, dynamic>),
      availableDateTime: (json['availableDateTime'] as List<dynamic>?)
          ?.map((e) => AvailableDateTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableReservationToJson(
        AvailableReservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isYmtaz': instance.isYmtaz,
      'reservation_type_importance_id': instance.reservationTypeImportanceId,
      'reservationTypeImportance': instance.reservationTypeImportance,
      'availableDateTime': instance.availableDateTime,
    };

AvailableDateTime _$AvailableDateTimeFromJson(Map<String, dynamic> json) =>
    AvailableDateTime(
      id: (json['id'] as num?)?.toInt(),
      reservationId: (json['reservation_id'] as num?)?.toInt(),
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$AvailableDateTimeToJson(AvailableDateTime instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reservation_id': instance.reservationId,
      'day': instance.day?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
    };

ReservationTypeImportance _$ReservationTypeImportanceFromJson(
        Map<String, dynamic> json) =>
    ReservationTypeImportance(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      reservationImportanceId:
          (json['reservation_importance_id'] as num?)?.toInt(),
      reservationImportance: json['reservation_importance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['reservation_importance'] as Map<String, dynamic>),
      isYmtaz: (json['isYmtaz'] as num?)?.toInt(),
      lawyer: json['lawyer'],
    );

Map<String, dynamic> _$ReservationTypeImportanceToJson(
        ReservationTypeImportance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'reservation_importance_id': instance.reservationImportanceId,
      'reservation_importance': instance.reservationImportance,
      'isYmtaz': instance.isYmtaz,
      'lawyer': instance.lawyer,
    };

ReservationImportance _$ReservationImportanceFromJson(
        Map<String, dynamic> json) =>
    ReservationImportance(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ReservationImportanceToJson(
        ReservationImportance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
