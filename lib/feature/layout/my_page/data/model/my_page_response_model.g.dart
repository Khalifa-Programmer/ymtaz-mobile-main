// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_page_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPageResponseModel _$MyPageResponseModelFromJson(Map<String, dynamic> json) =>
    MyPageResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyPageResponseModelToJson(
        MyPageResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      analytics: json['analytics'] == null
          ? null
          : OfficeData.fromJson(json['analytics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'analytics': instance.analytics,
    };
