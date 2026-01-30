// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_advisory_services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerAdvisoryServicesResponseModel
    _$LawyerAdvisoryServicesResponseModelFromJson(Map<String, dynamic> json) =>
        LawyerAdvisoryServicesResponseModel(
          status: json['status'] as bool?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$LawyerAdvisoryServicesResponseModelToJson(
        LawyerAdvisoryServicesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lawyerServices: (json['lawyerServices'] as List<dynamic>?)
          ?.map((e) => LawyerService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawyerServices': instance.lawyerServices,
    };

LawyerService _$LawyerServiceFromJson(Map<String, dynamic> json) =>
    LawyerService(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      image: json['image'] as String?,
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      paymentCategoryId: (json['payment_category_id'] as num?)?.toInt(),
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableDates: (json['available_dates'] as List<dynamic>?)
          ?.map((e) => AvailableDate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LawyerServiceToJson(LawyerService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructions': instance.instructions,
      'image': instance.image,
      'need_appointment': instance.needAppointment,
      'payment_category_id': instance.paymentCategoryId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'types': instance.types,
      'available_dates': instance.availableDates,
    };

AvailableDate _$AvailableDateFromJson(Map<String, dynamic> json) =>
    AvailableDate(
      id: (json['id'] as num?)?.toInt(),
      advisoryServicesId: (json['advisory_services_id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      isYmtaz: (json['is_ymtaz'] as num?)?.toInt(),
      lawyerId: (json['lawyer_id'] as num?)?.toInt(),
      availableTimes: (json['available_times'] as List<dynamic>?)
          ?.map((e) => AvailableTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableDateToJson(AvailableDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'advisory_services_id': instance.advisoryServicesId,
      'date': instance.date?.toIso8601String(),
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'is_ymtaz': instance.isYmtaz,
      'lawyer_id': instance.lawyerId,
      'available_times': instance.availableTimes,
    };

AvailableTime _$AvailableTimeFromJson(Map<String, dynamic> json) =>
    AvailableTime(
      id: (json['id'] as num?)?.toInt(),
      advisoryServicesId: (json['advisory_services_id'] as num?)?.toInt(),
      advisoryServicesAvailableDatesId:
          (json['advisory_services_available_dates_id'] as num?)?.toInt(),
      timeFrom: json['time_from'] as String?,
      timeTo: json['time_to'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$AvailableTimeToJson(AvailableTime instance) =>
    <String, dynamic>{
      'id': instance.id,
      'advisory_services_id': instance.advisoryServicesId,
      'advisory_services_available_dates_id':
          instance.advisoryServicesAvailableDatesId,
      'time_from': instance.timeFrom,
      'time_to': instance.timeTo,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      advisoryServicesPrices: (json['advisory_services_prices']
              as List<dynamic>?)
          ?.map(
              (e) => AdvisoryServicesPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_id': instance.advisoryServiceId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'advisory_services_prices': instance.advisoryServicesPrices,
    };

AdvisoryServicesPrice _$AdvisoryServicesPriceFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesPrice(
      id: (json['id'] as num?)?.toInt(),
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      clientReservationsImportanceId:
          (json['client_reservations_importance_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      isYmtaz: (json['is_ymtaz'] as num?)?.toInt(),
      lawyerId: (json['lawyer_id'] as num?)?.toInt(),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryServicesPriceToJson(
        AdvisoryServicesPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'advisory_service_id': instance.advisoryServiceId,
      'client_reservations_importance_id':
          instance.clientReservationsImportanceId,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'is_ymtaz': instance.isYmtaz,
      'lawyer_id': instance.lawyerId,
      'importance': instance.importance,
    };

Importance _$ImportanceFromJson(Map<String, dynamic> json) => Importance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$ImportanceToJson(Importance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
