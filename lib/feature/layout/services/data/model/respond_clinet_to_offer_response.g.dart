// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_clinet_to_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondClinetToOfferResponse _$RespondClinetToOfferResponseFromJson(
        Map<String, dynamic> json) =>
    RespondClinetToOfferResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RespondClinetToOfferResponseToJson(
        RespondClinetToOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      serviceRequest: json['service_request'] == null
          ? null
          : ServiceRequest.fromJson(
              json['service_request'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'service_request': instance.serviceRequest,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) =>
    ServiceRequest(
      accountId: json['account_id'] as String?,
      typeId: (json['type_id'] as num?)?.toInt(),
      priority: (json['priority'] as num?)?.toInt(),
      description: json['description'] as String?,
      forAdmin: (json['for_admin'] as num?)?.toInt(),
      reservedFromLawyerId: json['reserved_from_lawyer_id'] as String?,
      paymentStatus: (json['payment_status'] as num?)?.toInt(),
      price: json['price'] as String?,
      acceptRules: (json['accept_rules'] as num?)?.toInt(),
      transactionComplete: (json['transaction_complete'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      requestStatus: (json['request_status'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      transactionId: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$ServiceRequestToJson(ServiceRequest instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'type_id': instance.typeId,
      'priority': instance.priority,
      'description': instance.description,
      'for_admin': instance.forAdmin,
      'reserved_from_lawyer_id': instance.reservedFromLawyerId,
      'payment_status': instance.paymentStatus,
      'price': instance.price,
      'accept_rules': instance.acceptRules,
      'transaction_complete': instance.transactionComplete,
      'status': instance.status,
      'request_status': instance.requestStatus,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'transaction_id': instance.transactionId,
    };
