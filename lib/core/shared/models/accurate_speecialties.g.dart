// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accurate_speecialties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccurateSpecialties _$AccurateSpecialtiesFromJson(Map<String, dynamic> json) =>
    AccurateSpecialties(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccurateSpecialtiesToJson(
        AccurateSpecialties instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      accurateSpecialty: (json['AccurateSpecialty'] as List<dynamic>?)
          ?.map((e) => AccurateSpecialty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'AccurateSpecialty': instance.accurateSpecialty,
    };

AccurateSpecialty _$AccurateSpecialtyFromJson(Map<String, dynamic> json) =>
    AccurateSpecialty(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$AccurateSpecialtyToJson(AccurateSpecialty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
