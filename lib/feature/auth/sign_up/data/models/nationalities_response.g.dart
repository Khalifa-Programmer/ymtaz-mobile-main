// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nationalities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalitiesResponse _$NationalitiesResponseFromJson(
        Map<String, dynamic> json) =>
    NationalitiesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NationalitiesResponseToJson(
        NationalitiesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      nationalities: (json['nationalities'] as List<dynamic>?)
          ?.map((e) => Nationality.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'nationalities': instance.nationalities,
    };

Nationality _$NationalityFromJson(Map<String, dynamic> json) => Nationality(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NationalityToJson(Nationality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
