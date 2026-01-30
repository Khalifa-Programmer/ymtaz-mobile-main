// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_appointments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerAppointments _$LawyerAppointmentsFromJson(Map<String, dynamic> json) =>
    LawyerAppointments(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReservationType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LawyerAppointmentsToJson(LawyerAppointments instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ReservationType _$ReservationTypeFromJson(Map<String, dynamic> json) =>
    ReservationType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      isHidden: json['isHidden'] as bool?,
      ymtazPrices: (json['ymtazPrices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActivated: json['is_activated'] as bool?,
      lawyerPrices: (json['lawyerPrices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationTypeToJson(ReservationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'isHidden': instance.isHidden,
      'ymtazPrices': instance.ymtazPrices,
      'is_activated': instance.isActivated,
      'lawyerPrices': instance.lawyerPrices,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'isHidden': instance.isHidden,
      'level': instance.level,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'],
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
