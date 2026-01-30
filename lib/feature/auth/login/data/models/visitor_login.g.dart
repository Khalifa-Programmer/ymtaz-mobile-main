// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorLogin _$VisitorLoginFromJson(Map<String, dynamic> json) => VisitorLogin(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VisitorLoginToJson(VisitorLogin instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      visitor: json['visitor'] == null
          ? null
          : Visitor.fromJson(json['visitor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'visitor': instance.visitor,
    };

Visitor _$VisitorFromJson(Map<String, dynamic> json) => Visitor(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'],
      email: json['email'] as String?,
      googleId: json['google_id'] as String?,
      image: json['image'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      token: json['token'] as String?,
    );

Map<String, dynamic> _$VisitorToJson(Visitor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'google_id': instance.googleId,
      'image': instance.image,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'token': instance.token,
    };
