// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'functional_cases.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionalCases _$FunctionalCasesFromJson(Map<String, dynamic> json) =>
    FunctionalCases(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FunctionalCasesToJson(FunctionalCases instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      functionalCases: (json['FunctionalCases'] as List<dynamic>?)
          ?.map((e) => FunctionalCase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'FunctionalCases': instance.functionalCases,
    };

FunctionalCase _$FunctionalCaseFromJson(Map<String, dynamic> json) =>
    FunctionalCase(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$FunctionalCaseToJson(FunctionalCase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
