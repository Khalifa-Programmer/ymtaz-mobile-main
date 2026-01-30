// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_ymtaz_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesYmtazResponseModel _$ServicesYmtazResponseModelFromJson(
        Map<String, dynamic> json) =>
    ServicesYmtazResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesYmtazResponseModelToJson(
        ServicesYmtazResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
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
      isActivated: json['is_activated'] as bool?,
      isHidden: json['isHidden'] as bool?,
    )..lawyerPrices = (json['lawyerPrices'] as List<dynamic>?)
        ?.map((e) => YmtazLevelsPrice.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'details': instance.details,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'ymtaz_levels_prices': instance.ymtazLevelsPrices,
      'is_activated': instance.isActivated,
      'isHidden': instance.isHidden,
      'lawyerPrices': instance.lawyerPrices,
    };

YmtazLevelsPrice _$YmtazLevelsPriceFromJson(Map<String, dynamic> json) =>
    YmtazLevelsPrice(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
    )..isHidden = (json['isHidden'] as num?)?.toInt();

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
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
