// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_committees_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryCommitteesResponse _$AdvisoryCommitteesResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryCommitteesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryCommitteesResponseToJson(
        AdvisoryCommitteesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              CategoryAdvisorCommitte.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'categories': instance.categories,
    };

CategoryAdvisorCommitte _$CategoryAdvisorCommitteFromJson(
        Map<String, dynamic> json) =>
    CategoryAdvisorCommitte(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      advisorsAvailableCounts:
          (json['advisors_available_counts'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryAdvisorCommitteToJson(
        CategoryAdvisorCommitte instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'advisors_available_counts': instance.advisorsAvailableCounts,
    };
