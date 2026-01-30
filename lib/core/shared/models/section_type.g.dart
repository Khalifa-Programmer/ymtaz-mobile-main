// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionsType _$SectionsTypeFromJson(Map<String, dynamic> json) => SectionsType(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionsTypeToJson(SectionsType instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      digitalGuideCategories: (json['DigitalGuideCategories'] as List<dynamic>?)
          ?.map((e) => DigitalGuideCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'DigitalGuideCategories': instance.digitalGuideCategories,
    };

DigitalGuideCategory _$DigitalGuideCategoryFromJson(
        Map<String, dynamic> json) =>
    DigitalGuideCategory(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      needLicense: (json['need_license'] as num?)?.toInt(),
      lawyersCount: (json['lawyers_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DigitalGuideCategoryToJson(
        DigitalGuideCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'need_license': instance.needLicense,
      'lawyers_count': instance.lawyersCount,
    };
