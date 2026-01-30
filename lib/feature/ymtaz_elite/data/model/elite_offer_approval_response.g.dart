// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elite_offer_approval_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliteOfferApprovalResponse _$EliteOfferApprovalResponseFromJson(
        Map<String, dynamic> json) =>
    EliteOfferApprovalResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : EliteOfferApprovalData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EliteOfferApprovalResponseToJson(
        EliteOfferApprovalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

EliteOfferApprovalData _$EliteOfferApprovalDataFromJson(
        Map<String, dynamic> json) =>
    EliteOfferApprovalData(
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$EliteOfferApprovalDataToJson(
        EliteOfferApprovalData instance) =>
    <String, dynamic>{
      'payment_url': instance.paymentUrl,
    };
