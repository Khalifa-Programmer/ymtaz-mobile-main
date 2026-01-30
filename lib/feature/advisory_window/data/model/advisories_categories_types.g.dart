// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisories_categories_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoriesCategoriesTypes _$AdvisoriesCategoriesTypesFromJson(
        Map<String, dynamic> json) =>
    AdvisoriesCategoriesTypes(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoriesCategoriesTypesToJson(
        AdvisoriesCategoriesTypes instance) =>
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
      name: json['name'] as String?,
      description: json['description'],
      requiresAppointment: (json['requires_appointment'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'requires_appointment': instance.requiresAppointment,
    };
