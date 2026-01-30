// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_ymtaz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactYmtazResponse _$ContactYmtazResponseFromJson(
        Map<String, dynamic> json) =>
    ContactYmtazResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContactYmtazResponseToJson(
        ContactYmtazResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reserverType: json['reserverType'] as String?,
      lawyerId: json['lawyer_id'],
      serviceUserId: (json['service_user_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      subject: json['subject'] as String?,
      details: json['details'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reserverType': instance.reserverType,
      'lawyer_id': instance.lawyerId,
      'service_user_id': instance.serviceUserId,
      'type': instance.type,
      'subject': instance.subject,
      'details': instance.details,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
