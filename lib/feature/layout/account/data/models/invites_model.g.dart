// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesModel _$InvitesModelFromJson(Map<String, dynamic> json) => InvitesModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvitesModelToJson(InvitesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCode: json['phone_code'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'phone_code': instance.phoneCode,
      'status': instance.status,
    };
