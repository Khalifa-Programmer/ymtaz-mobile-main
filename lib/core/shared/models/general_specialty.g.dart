// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_specialty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralSpecialty _$GeneralSpecialtyFromJson(Map<String, dynamic> json) =>
    GeneralSpecialty(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralSpecialtyToJson(GeneralSpecialty instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      generalSpecialty: (json['GeneralSpecialty'] as List<dynamic>?)
          ?.map((e) =>
              GeneralSpecialtyElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'GeneralSpecialty': instance.generalSpecialty,
    };

GeneralSpecialtyElement _$GeneralSpecialtyElementFromJson(
        Map<String, dynamic> json) =>
    GeneralSpecialtyElement(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$GeneralSpecialtyElementToJson(
        GeneralSpecialtyElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
