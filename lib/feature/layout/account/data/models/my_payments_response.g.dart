// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_payments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPaymentsResponse _$MyPaymentsResponseFromJson(Map<String, dynamic> json) =>
    MyPaymentsResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyPaymentsResponseToJson(MyPaymentsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'payments': instance.payments,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      transactionId: json['transaction_id'] as String?,
      paymentCategoryTypeName: json['payment_category_type_name'] as String?,
      mainCategoryName: json['main_category_name'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      importance: json['importance'] as String?,
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      transactionComplete: (json['transaction_complete'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'transaction_id': instance.transactionId,
      'payment_category_type_name': instance.paymentCategoryTypeName,
      'main_category_name': instance.mainCategoryName,
      'name': instance.name,
      'type': instance.type,
      'importance': instance.importance,
      'price': instance.price,
      'created_at': instance.createdAt,
      'transaction_complete': instance.transactionComplete,
    };
