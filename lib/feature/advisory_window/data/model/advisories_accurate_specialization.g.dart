// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisories_accurate_specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoriesAccurateSpecialization _$AdvisoriesAccurateSpecializationFromJson(
        Map<String, dynamic> json) =>
    AdvisoriesAccurateSpecialization(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AdvisoriesAccurateData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoriesAccurateSpecializationToJson(
        AdvisoriesAccurateSpecialization instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AdvisoriesAccurateData _$AdvisoriesAccurateDataFromJson(
        Map<String, dynamic> json) =>
    AdvisoriesAccurateData(
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoriesAccurateDataToJson(
        AdvisoriesAccurateData instance) =>
    <String, dynamic>{
      'subCategories': instance.subCategories,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      generalCategory: json['general_category'] == null
          ? null
          : GeneralCategory.fromJson(
              json['general_category'] as Map<String, dynamic>),
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => LevelElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'general_category': instance.generalCategory,
      'levels': instance.levels,
    };

GeneralCategory _$GeneralCategoryFromJson(Map<String, dynamic> json) =>
    GeneralCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      paymentCategoryType: json['payment_category_type'] == null
          ? null
          : PaymentCategoryType.fromJson(
              json['payment_category_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralCategoryToJson(GeneralCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'payment_category_type': instance.paymentCategoryType,
    };

PaymentCategoryType _$PaymentCategoryTypeFromJson(Map<String, dynamic> json) =>
    PaymentCategoryType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      requiresAppointment: (json['requires_appointment'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentCategoryTypeToJson(
        PaymentCategoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'requires_appointment': instance.requiresAppointment,
    };

LevelElement _$LevelElementFromJson(Map<String, dynamic> json) => LevelElement(
      id: (json['id'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : LevelLevel.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LevelElementToJson(LevelElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'level': instance.level,
    };

LevelLevel _$LevelLevelFromJson(Map<String, dynamic> json) => LevelLevel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LevelLevelToJson(LevelLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
