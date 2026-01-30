// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_page_lawyer_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageLawyerResponseModel _$MyPageLawyerResponseModelFromJson(
        Map<String, dynamic> json) =>
    MyPageLawyerResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyPageLawyerResponseModelToJson(
        MyPageLawyerResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservations: json['reservations'] as List<dynamic>?,
      advisoryServices: (json['advisoryServices'] as List<dynamic>?)
          ?.map((e) => AdvisoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservations': instance.reservations,
      'advisoryServices': instance.advisoryServices,
      'services': instance.services,
    };

AdvisoryService _$AdvisoryServiceFromJson(Map<String, dynamic> json) =>
    AdvisoryService(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      file: json['file'],
      paymentStatus: json['payment_status'] as String?,
      price: json['price'],
      acceptDate: json['accept_date'],
      reservationStatus: json['reservation_status'] as String?,
      advisoryServicesId: json['advisory_services_id'] == null
          ? null
          : AdvisoryServicesId.fromJson(
              json['advisory_services_id'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      importance: json['importance'],
      appointment: json['appointment'],
      lawyer: json['lawyer'],
      rate: json['rate'],
      comment: json['comment'],
      reply: json['reply'],
    );

Map<String, dynamic> _$AdvisoryServiceToJson(AdvisoryService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'file': instance.file,
      'payment_status': instance.paymentStatus,
      'price': instance.price,
      'accept_date': instance.acceptDate,
      'reservation_status': instance.reservationStatus,
      'advisory_services_id': instance.advisoryServicesId,
      'type': instance.type,
      'importance': instance.importance,
      'appointment': instance.appointment,
      'lawyer': instance.lawyer,
      'rate': instance.rate,
      'comment': instance.comment,
      'reply': instance.reply,
    };

AdvisoryServicesId _$AdvisoryServicesIdFromJson(Map<String, dynamic> json) =>
    AdvisoryServicesId(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      phone: json['phone'],
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      image: json['image'] as String?,
      paymentCategory: json['payment_category'] == null
          ? null
          : PaymentCategory.fromJson(
              json['payment_category'] as Map<String, dynamic>),
      availableDates: json['available_dates'] as List<dynamic>?,
    );

Map<String, dynamic> _$AdvisoryServicesIdToJson(AdvisoryServicesId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructions': instance.instructions,
      'phone': instance.phone,
      'need_appointment': instance.needAppointment,
      'image': instance.image,
      'payment_category': instance.paymentCategory,
      'available_dates': instance.availableDates,
    };

PaymentCategory _$PaymentCategoryFromJson(Map<String, dynamic> json) =>
    PaymentCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      paymentMethod: json['payment_method'] as String?,
      count: json['count'],
      period: json['period'],
    );

Map<String, dynamic> _$PaymentCategoryToJson(PaymentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'payment_method': instance.paymentMethod,
      'count': instance.count,
      'period': instance.period,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      advisoryServicePrices: (json['advisory_service_prices'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
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

ServiceElement _$ServiceElementFromJson(Map<String, dynamic> json) =>
    ServiceElement(
      id: (json['id'] as num?)?.toInt(),
      service: json['service'] == null
          ? null
          : ServiceService.fromJson(json['service'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Priority.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      file: json['file'] as String?,
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      requestStatus: (json['request_status'] as num?)?.toInt(),
      forAdmin: json['for_admin'] as String?,
      replayStatus: json['replay_status'] as String?,
      replay: json['replay'],
      replayFile: json['replay_file'],
      replayTime: json['replay_time'],
      replayDate: json['replay_date'],
      referralStatus: (json['referral_status'] as num?)?.toInt(),
      lawyer: json['lawyer'],
      rate: json['rate'],
      comment: json['comment'],
    );

Map<String, dynamic> _$ServiceElementToJson(ServiceElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'priority': instance.priority,
      'description': instance.description,
      'file': instance.file,
      'price': instance.price,
      'created_at': instance.createdAt,
      'request_status': instance.requestStatus,
      'for_admin': instance.forAdmin,
      'replay_status': instance.replayStatus,
      'replay': instance.replay,
      'replay_file': instance.replayFile,
      'replay_time': instance.replayTime,
      'replay_date': instance.replayDate,
      'referral_status': instance.referralStatus,
      'lawyer': instance.lawyer,
      'rate': instance.rate,
      'comment': instance.comment,
    };

Priority _$PriorityFromJson(Map<String, dynamic> json) => Priority(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PriorityToJson(Priority instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

ServiceService _$ServiceServiceFromJson(Map<String, dynamic> json) =>
    ServiceService(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      intro: json['intro'] as String?,
      details: json['details'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      ymtazLevelsPrices: (json['ymtaz_levels_prices'] as List<dynamic>?)
          ?.map((e) => YmtazLevelsPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceServiceToJson(ServiceService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'details': instance.details,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'ymtaz_levels_prices': instance.ymtazLevelsPrices,
    };

YmtazLevelsPrice _$YmtazLevelsPriceFromJson(Map<String, dynamic> json) =>
    YmtazLevelsPrice(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
