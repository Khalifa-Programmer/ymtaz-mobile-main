// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degrees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Degrees _$DegreesFromJson(Map<String, dynamic> json) => Degrees(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DegreesToJson(Degrees instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      degrees: (json['Degrees'] as List<dynamic>?)
          ?.map((e) => Degree.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Degrees': instance.degrees,
    };

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      isSpecial: (json['isSpecial'] as num?)?.toInt(),
      needCertificate: (json['need_certificate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isSpecial': instance.isSpecial,
      'need_certificate': instance.needCertificate,
    };
