// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_lawyer_offres_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceLawyerOffresResponse _$ServiceLawyerOffresResponseFromJson(
        Map<String, dynamic> json) =>
    ServiceLawyerOffresResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceLawyerOffresResponseToJson(
        ServiceLawyerOffresResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      offers: json['offers'] == null
          ? null
          : Offers.fromJson(json['offers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'offers': instance.offers,
    };

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      pendingAcceptance: (json['pending-acceptance'] as List<dynamic>?)
          ?.map((e) => Declined.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOffer: (json['pending-offer'] as List<dynamic>?)
          ?.map((e) => Declined.fromJson(e as Map<String, dynamic>))
          .toList(),
      cancelledByClient: json['cancelled-by-client'] as List<dynamic>?,
      declined: (json['declined'] as List<dynamic>?)
          ?.map((e) => Declined.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'pending-acceptance': instance.pendingAcceptance,
      'pending-offer': instance.pendingOffer,
      'cancelled-by-client': instance.cancelledByClient,
      'declined': instance.declined,
    };

Declined _$DeclinedFromJson(Map<String, dynamic> json) => Declined(
      id: (json['id'] as num?)?.toInt(),
      account: json['account'],
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Priority.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FileElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as String?,
      lawyer: json['lawyer'],
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DeclinedToJson(Declined instance) => <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'service': instance.service,
      'priority': instance.priority,
      'description': instance.description,
      'files': instance.files,
      'price': instance.price,
      'lawyer': instance.lawyer,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

FileElement _$FileElementFromJson(Map<String, dynamic> json) => FileElement(
      file: json['file'] as String?,
      isVoice: (json['is_voice'] as num?)?.toInt(),
      isReply: (json['is_reply'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FileElementToJson(FileElement instance) =>
    <String, dynamic>{
      'file': instance.file,
      'is_voice': instance.isVoice,
      'is_reply': instance.isReply,
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
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
      'duration': instance.duration,
      'isHidden': instance.isHidden,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
