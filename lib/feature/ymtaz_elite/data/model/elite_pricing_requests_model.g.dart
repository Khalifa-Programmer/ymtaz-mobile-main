// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elite_pricing_requests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElitePricingRequestsModel _$ElitePricingRequestsModelFromJson(
        Map<String, dynamic> json) =>
    ElitePricingRequestsModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElitePricingRequestsModelToJson(
        ElitePricingRequestsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      pendingPricing: (json['pendingPricing'] as List<dynamic>?)
          ?.map((e) => PendingPricing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pendingPricing': instance.pendingPricing,
    };

PendingPricing _$PendingPricingFromJson(Map<String, dynamic> json) =>
    PendingPricing(
      id: (json['id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      eliteServiceCategory: json['elite_service_category'] == null
          ? null
          : EliteServiceCategory.fromJson(
              json['elite_service_category'] as Map<String, dynamic>),
      description: json['description'] as String?,
      transactionComplete: (json['transaction_complete'] as num?)?.toInt(),
      transactionId: json['transaction_id'],
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FileElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: json['offers'],
    );

Map<String, dynamic> _$PendingPricingToJson(PendingPricing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'elite_service_category': instance.eliteServiceCategory,
      'description': instance.description,
      'transaction_complete': instance.transactionComplete,
      'transaction_id': instance.transactionId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'files': instance.files,
      'offers': instance.offers,
    };

EliteServiceCategory _$EliteServiceCategoryFromJson(
        Map<String, dynamic> json) =>
    EliteServiceCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EliteServiceCategoryToJson(
        EliteServiceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

FileElement _$FileElementFromJson(Map<String, dynamic> json) => FileElement(
      id: (json['id'] as num?)?.toInt(),
      eliteServiceRequestId:
          (json['elite_service_request_id'] as num?)?.toInt(),
      advisoryServicesReservationsId: json['advisory_services_reservations_id'],
      servicesReservationsId: json['services_reservations_id'],
      reservationsId: json['reservations_id'],
      file: json['file'] as String?,
      isVoice: (json['is_voice'] as num?)?.toInt(),
      isReply: (json['is_reply'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FileElementToJson(FileElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'elite_service_request_id': instance.eliteServiceRequestId,
      'advisory_services_reservations_id':
          instance.advisoryServicesReservationsId,
      'services_reservations_id': instance.servicesReservationsId,
      'reservations_id': instance.reservationsId,
      'file': instance.file,
      'is_voice': instance.isVoice,
      'is_reply': instance.isReply,
    };
