// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elite_consultants_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EliteConsultantsResponse _$EliteConsultantsResponseFromJson(
        Map<String, dynamic> json) =>
    EliteConsultantsResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : EliteConsultantsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EliteConsultantsResponseToJson(
        EliteConsultantsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

EliteConsultantsData _$EliteConsultantsDataFromJson(
        Map<String, dynamic> json) =>
    EliteConsultantsData(
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EliteConsultantsDataToJson(
        EliteConsultantsData instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
      'details': instance.details,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      lawyersCount: (json['lawyers_count'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'lawyers_count': instance.lawyersCount,
      'price': instance.price,
      'duration': instance.duration,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      header: json['header'] as String?,
      footer: json['footer'] as String?,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'header': instance.header,
      'footer': instance.footer,
    };
