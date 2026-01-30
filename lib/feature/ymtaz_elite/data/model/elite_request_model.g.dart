// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elite_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliteRequestModel _$EliteRequestModelFromJson(Map<String, dynamic> json) =>
    EliteRequestModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EliteRequestModelToJson(EliteRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      eliteServiceCategoryId: json['elite_service_category_id'] as String?,
      description: json['description'] as String?,
      transactionComplete: json['transaction_complete'],
      transactionId: json['transaction_id'],
      status: json['status'],
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FileElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'elite_service_category_id': instance.eliteServiceCategoryId,
      'description': instance.description,
      'transaction_complete': instance.transactionComplete,
      'transaction_id': instance.transactionId,
      'status': instance.status,
      'files': instance.files,
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
