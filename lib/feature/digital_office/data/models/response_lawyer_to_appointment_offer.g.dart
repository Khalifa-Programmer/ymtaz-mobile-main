// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_lawyer_to_appointment_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLawyerToAppointmentOffer _$ResponseLawyerToAppointmentOfferFromJson(
        Map<String, dynamic> json) =>
    ResponseLawyerToAppointmentOffer(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseLawyerToAppointmentOfferToJson(
        ResponseLawyerToAppointmentOffer instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      offer: json['offer'] == null
          ? null
          : Offer.fromJson(json['offer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'offer': instance.offer,
    };

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: (json['id'] as num?)?.toInt(),
      reservationTypeId: (json['reservation_type_id'] as num?)?.toInt(),
      importanceId: (json['importance_id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      lawyerId: json['lawyer_id'] as String?,
      price: json['price'] as String?,
      description: json['description'] as String?,
      file: json['file'],
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      lawyerLongitude: json['lawyer_longitude'] as String?,
      lawyerLatitude: json['lawyer_latitude'] as String?,
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      hours: (json['hours'] as num?)?.toInt(),
      status: json['status'] as String?,
      regionId: (json['region_id'] as num?)?.toInt(),
      cityId: (json['city_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'reservation_type_id': instance.reservationTypeId,
      'importance_id': instance.importanceId,
      'account_id': instance.accountId,
      'lawyer_id': instance.lawyerId,
      'price': instance.price,
      'description': instance.description,
      'file': instance.file,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'lawyer_longitude': instance.lawyerLongitude,
      'lawyer_latitude': instance.lawyerLatitude,
      'day': instance.day?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'hours': instance.hours,
      'status': instance.status,
      'region_id': instance.regionId,
      'city_id': instance.cityId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
