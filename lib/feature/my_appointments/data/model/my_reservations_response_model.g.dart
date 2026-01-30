// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservations_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReservationsResponseModel _$MyReservationsResponseModelFromJson(
        Map<String, dynamic> json) =>
    MyReservationsResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyReservationsResponseModelToJson(
        MyReservationsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservations': instance.reservations,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      clientId: json['client_id'],
      lawyerId: (json['lawyer_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      countryId: (json['country_id'] as num?)?.toInt(),
      regionId: (json['region_id'] as num?)?.toInt(),
      file: json['file'],
      price: json['price'] as String?,
      hours: json['hours'] as String?,
      reservationEnded: (json['reservationEnded'] as num?)?.toInt(),
      reservationEndedTime: json['reservationEndedTime'],
      reservedFromLawyer: json['reservedFromLawyer'],
      reservationType: json['reservationType'] == null
          ? null
          : ReservationType.fromJson(
              json['reservationType'] as Map<String, dynamic>),
      reservationImportance: json['reservationImportance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['reservationImportance'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'lawyer_id': instance.lawyerId,
      'description': instance.description,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'date': instance.date?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'country_id': instance.countryId,
      'region_id': instance.regionId,
      'file': instance.file,
      'price': instance.price,
      'hours': instance.hours,
      'reservationEnded': instance.reservationEnded,
      'reservationEndedTime': instance.reservationEndedTime,
      'reservedFromLawyer': instance.reservedFromLawyer,
      'reservationType': instance.reservationType,
      'reservationImportance': instance.reservationImportance,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
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

ReservationType _$ReservationTypeFromJson(Map<String, dynamic> json) =>
    ReservationType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReservationTypeToJson(ReservationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };
