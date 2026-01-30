// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_ymtaz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutYmtaz _$AboutYmtazFromJson(Map<String, dynamic> json) => AboutYmtaz(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AboutYmtazToJson(AboutYmtaz instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      intro: json['intro'] as String?,
      description: json['description'] as String?,
      servicesCount: (json['servicesCount'] as num?)?.toInt(),
      clients: (json['clients'] as num?)?.toInt(),
      countries: (json['countries'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'intro': instance.intro,
      'description': instance.description,
      'servicesCount': instance.servicesCount,
      'clients': instance.clients,
      'countries': instance.countries,
    };
