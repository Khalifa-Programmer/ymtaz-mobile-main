// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_joined_lawyers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentJoinedLawyersModel _$RecentJoinedLawyersModelFromJson(
        Map<String, dynamic> json) =>
    RecentJoinedLawyersModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecentJoinedLawyersModelToJson(
        RecentJoinedLawyersModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      newAdvisories: (json['newAdvisories'] as List<dynamic>?)
          ?.map((e) => NewAdvisory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'newAdvisories': instance.newAdvisories,
    };

NewAdvisory _$NewAdvisoryFromJson(Map<String, dynamic> json) => NewAdvisory(
      id: json['id'] as String?,
      name: json['name'] as String?,
      photo: json['profile_photo'] as String?,
      cityRel: json['city'] == null
          ? null
          : CityRel.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewAdvisoryToJson(NewAdvisory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_photo': instance.photo,
      'city': instance.cityRel,
    };

CityRel _$CityRelFromJson(Map<String, dynamic> json) => CityRel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityRelToJson(CityRel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
