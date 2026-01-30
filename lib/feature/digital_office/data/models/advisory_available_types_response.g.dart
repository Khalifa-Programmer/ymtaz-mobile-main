// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_available_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryAvailableTypesResponse _$AdvisoryAvailableTypesResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryAvailableTypesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoryAvailableTypesResponseToJson(
        AdvisoryAvailableTypesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      generalCategoryId: (json['general_category_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      ymtazPrices: (json['ymtazPrices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActivated: json['is_activated'] as bool?,
      isHidden: json['isHidden'] as bool?,
      lawyerPrices: (json['lawyerPrices'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..minPrice = (json['min_price'] as num?)?.toInt()
      ..maxPrice = (json['max_price'] as num?)?.toInt();

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'name': instance.name,
      'description': instance.description,
      'general_category_id': instance.generalCategoryId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'ymtazPrices': instance.ymtazPrices,
      'is_activated': instance.isActivated,
      'isHidden': instance.isHidden,
      'lawyerPrices': instance.lawyerPrices,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      id: (json['id'] as num?)?.toInt(),
      price: json['price'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'duration': instance.duration,
      'isHidden': instance.isHidden,
      'level': instance.level,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
