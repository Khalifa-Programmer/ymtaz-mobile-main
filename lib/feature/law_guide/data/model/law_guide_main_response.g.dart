// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_guide_main_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawGuideMainResponse _$LawGuideMainResponseFromJson(
        Map<String, dynamic> json) =>
    LawGuideMainResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawGuideMainResponseToJson(
        LawGuideMainResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      mainCategories: (json['mainCategories'] as List<dynamic>?)
          ?.map((e) => MainCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'mainCategories': instance.mainCategories,
    };

MainCategory _$MainCategoryFromJson(Map<String, dynamic> json) => MainCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MainCategoryToJson(MainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'count': instance.count,
    };
