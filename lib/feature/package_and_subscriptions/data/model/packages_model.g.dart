// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagesModel _$PackagesModelFromJson(Map<String, dynamic> json) =>
    PackagesModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackagesModelToJson(PackagesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'packages': instance.packages,
    };

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      instructions: json['instructions'] as String?,
      durationType: (json['durationType'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      priceBeforeDiscount: (json['priceBeforeDiscount'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
      numberOfAdvisoryServices:
          (json['number_of_advisory_services'] as num?)?.toInt(),
      numberOfServices: (json['number_of_services'] as num?)?.toInt(),
      numberOfReservations: (json['number_of_reservations'] as num?)?.toInt(),
      subscribed: json['subscribed'] as bool?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      advisoryServicesTypes: (json['advisoryServicesTypes'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicesType.fromJson(e as Map<String, dynamic>))
          .toList(),
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'instructions': instance.instructions,
      'durationType': instance.durationType,
      'duration': instance.duration,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'number_of_advisory_services': instance.numberOfAdvisoryServices,
      'number_of_services': instance.numberOfServices,
      'number_of_reservations': instance.numberOfReservations,
      'subscribed': instance.subscribed,
      'services': instance.services,
      'advisoryServicesTypes': instance.advisoryServicesTypes,
      'reservations': instance.reservations,
      'permissions': instance.permissions,
    };

AdvisoryServicesType _$AdvisoryServicesTypeFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesType(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      advisoryServicePrices: (json['advisory_service_prices'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoryServicesTypeToJson(
        AdvisoryServicesType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'advisory_service_prices': instance.advisoryServicePrices,
    };

AdvisoryServicePrice _$AdvisoryServicePriceFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicePrice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      requestLevel: (json['request_level'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdvisoryServicePriceToJson(
        AdvisoryServicePrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_id': instance.advisoryServiceId,
      'request_level': instance.requestLevel,
      'price': instance.price,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      typesImportance: (json['typesImportance'] as List<dynamic>?)
          ?.map((e) => TypesImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
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

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      intro: json['intro'] as String?,
      details: json['details'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      ymtazLevelsPrices: (json['ymtaz_levels_prices'] as List<dynamic>?)
          ?.map((e) => YmtazLevelsPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'details': instance.details,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'need_appointment': instance.needAppointment,
      'ymtaz_levels_prices': instance.ymtazLevelsPrices,
    };

YmtazLevelsPrice _$YmtazLevelsPriceFromJson(Map<String, dynamic> json) =>
    YmtazLevelsPrice(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : ReservationImportance.fromJson(
              json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
      'isHidden': instance.isHidden,
    };

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
