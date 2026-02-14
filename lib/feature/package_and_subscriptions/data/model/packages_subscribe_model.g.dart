// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_subscribe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagesSubscribeModel _$PackagesSubscribeModelFromJson(
        Map<String, dynamic> json) =>
    PackagesSubscribeModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackagesSubscribeModelToJson(
        PackagesSubscribeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'subscription': instance.subscription,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      packageId: (json['package_id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionComplete: (json['transaction_complete'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'package_id': instance.packageId,
      'account_id': instance.accountId,
      'transaction_id': instance.transactionId,
      'transaction_complete': instance.transactionComplete,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
