// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates_types_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatesTypesResponseModel _$DatesTypesResponseModelFromJson(
        Map<String, dynamic> json) =>
    DatesTypesResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatesTypesResponseModelToJson(
        DatesTypesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservationsTypes: (json['reservations_types'] as List<dynamic>?)
          ?.map((e) => ReservationsType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservations_types': instance.reservationsTypes,
    };

ReservationsType _$ReservationsTypeFromJson(Map<String, dynamic> json) =>
    ReservationsType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      typesImportance: (json['typesImportance'] as List<dynamic>?)
          ?.map((e) => TypesImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationsTypeToJson(ReservationsType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'typesImportance': instance.typesImportance,
    };

TypesImportance _$TypesImportanceFromJson(Map<String, dynamic> json) =>
    TypesImportance(
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

Map<String, dynamic> _$TypesImportanceToJson(TypesImportance instance) =>
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
