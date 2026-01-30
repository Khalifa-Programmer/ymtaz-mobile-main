// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_main_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryMainCategory _$AdvisoryMainCategoryFromJson(
        Map<String, dynamic> json) =>
    AdvisoryMainCategory(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataMainCategory.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryMainCategoryToJson(
        AdvisoryMainCategory instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

DataMainCategory _$DataMainCategoryFromJson(Map<String, dynamic> json) =>
    DataMainCategory(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemMainCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataMainCategoryToJson(DataMainCategory instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ItemMainCategory _$ItemMainCategoryFromJson(Map<String, dynamic> json) =>
    ItemMainCategory(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ItemMainCategoryToJson(ItemMainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
