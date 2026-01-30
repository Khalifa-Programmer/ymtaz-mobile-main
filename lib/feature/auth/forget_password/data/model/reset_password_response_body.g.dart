// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetResponse _$ResetResponseFromJson(Map<String, dynamic> json) =>
    ResetResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResetResponseToJson(ResetResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'client': instance.client,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      type: (json['type'] as num?)?.toInt(),
      email: json['email'] as String?,
      image: json['image'] as String?,
      nationality: json['nationality'] as String?,
      country: json['country'] as String?,
      region: json['region'] as String?,
      city: json['city'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'type': instance.type,
      'email': instance.email,
      'image': instance.image,
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'token': instance.token,
    };
