// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesRequestResponse _$ServicesRequestResponseFromJson(
        Map<String, dynamic> json) =>
    ServicesRequestResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesRequestResponseToJson(
        ServicesRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      serviceRequest: json['service_request'] == null
          ? null
          : ServiceRequest.fromJson(
              json['service_request'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'service_request': instance.serviceRequest,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) =>
    ServiceRequest(
      id: (json['id'] as num?)?.toInt(),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Priority.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      file: json['file'],
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

Map<String, dynamic> _$ServiceRequestToJson(ServiceRequest instance) =>
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

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
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

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
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
