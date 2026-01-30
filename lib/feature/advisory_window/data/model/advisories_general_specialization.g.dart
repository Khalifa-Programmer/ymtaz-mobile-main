// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisories_general_specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoriesGeneralSpecialization _$AdvisoriesGeneralSpecializationFromJson(
        Map<String, dynamic> json) =>
    AdvisoriesGeneralSpecialization(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => AdvisoriesGeneralData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoriesGeneralSpecializationToJson(
        AdvisoriesGeneralSpecialization instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AdvisoriesGeneralData _$AdvisoriesGeneralDataFromJson(
        Map<String, dynamic> json) =>
    AdvisoriesGeneralData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      paymentCategoryType: json['payment_category_type'] == null
          ? null
          : PaymentCategoryType.fromJson(
              json['payment_category_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoriesGeneralDataToJson(
        AdvisoriesGeneralData instance) =>
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
