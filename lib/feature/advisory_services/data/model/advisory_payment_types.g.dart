// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_payment_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryPaymentsResponse _$AdvisoryPaymentsResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryPaymentsResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryPaymentsResponseToJson(
        AdvisoryPaymentsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      paymentMethod: json['payment_method'] as String?,
      count: json['count'],
      period: json['period'],
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'payment_method': instance.paymentMethod,
      'count': instance.count,
      'period': instance.period,
    };
