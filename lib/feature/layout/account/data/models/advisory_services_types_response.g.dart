// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_services_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryServicesTypesResponse _$AdvisoryServicesTypesResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesTypesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryServicesTypesResponseToJson(
        AdvisoryServicesTypesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServicePrices: (json['advisory_service_prices'] as List<dynamic>?)
          ?.map((e) =>
              AdvisoryServicePriceFromTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_prices': instance.advisoryServicePrices,
    };

AdvisoryServicePriceFromTypes _$AdvisoryServicePriceFromTypesFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicePriceFromTypes(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      requestLevel: (json['request_level'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdvisoryServicePriceFromTypesToJson(
        AdvisoryServicePriceFromTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_id': instance.advisoryServiceId,
      'request_level': instance.requestLevel,
      'price': instance.price,
    };
