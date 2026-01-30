// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_lawyer_to_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLawyerToOffer _$ResponseLawyerToOfferFromJson(
        Map<String, dynamic> json) =>
    ResponseLawyerToOffer(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseLawyerToOfferToJson(
        ResponseLawyerToOffer instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      offer: json['offer'] == null
          ? null
          : Offer.fromJson(json['offer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'offer': instance.offer,
    };

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: (json['id'] as num?)?.toInt(),
      serviceId: (json['service_id'] as num?)?.toInt(),
      importanceId: (json['importance_id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      description: json['description'] as String?,
      lawyerId: json['lawyer_id'] as String?,
      price: json['price'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'importance_id': instance.importanceId,
      'account_id': instance.accountId,
      'description': instance.description,
      'lawyer_id': instance.lawyerId,
      'price': instance.price,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
