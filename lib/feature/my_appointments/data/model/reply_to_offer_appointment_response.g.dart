// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_to_offer_appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyToOfferAppointmentResponse _$ReplyToOfferAppointmentResponseFromJson(
        Map<String, dynamic> json) =>
    ReplyToOfferAppointmentResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyToOfferAppointmentResponseToJson(
        ReplyToOfferAppointmentResponse instance) =>
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
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservation': instance.reservation,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      reservationTypeId: (json['reservation_type_id'] as num?)?.toInt(),
      importanceId: (json['importance_id'] as num?)?.toInt(),
      reservedFromLawyerId: json['reserved_from_lawyer_id'] as String?,
      hours: (json['hours'] as num?)?.toInt(),
      regionId: (json['region_id'] as num?)?.toInt(),
      cityId: (json['city_id'] as num?)?.toInt(),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      lawyerLongitude: json['lawyer_longitude'] as String?,
      lawyerLatitude: json['lawyer_latitude'] as String?,
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      accountId: json['account_id'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      transactionComplete: (json['transaction_complete'] as num?)?.toInt(),
      requestStatus: (json['request_status'] as num?)?.toInt(),
      reservationCode: json['reservation_code'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservation_type_id': instance.reservationTypeId,
      'importance_id': instance.importanceId,
      'reserved_from_lawyer_id': instance.reservedFromLawyerId,
      'hours': instance.hours,
      'region_id': instance.regionId,
      'city_id': instance.cityId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'lawyer_longitude': instance.lawyerLongitude,
      'lawyer_latitude': instance.lawyerLatitude,
      'day': instance.day?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'account_id': instance.accountId,
      'description': instance.description,
      'price': instance.price,
      'transaction_complete': instance.transactionComplete,
      'request_status': instance.requestStatus,
      'reservation_code': instance.reservationCode,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'transaction_id': instance.transactionId,
    };
