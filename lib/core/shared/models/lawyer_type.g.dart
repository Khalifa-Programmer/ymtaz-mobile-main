// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerTypes _$LawyerTypesFromJson(Map<String, dynamic> json) => LawyerTypes(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawyerTypesToJson(LawyerTypes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'types': instance.types,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      needCompanyName: (json['need_company_name'] as num?)?.toInt(),
      needCompanyLicenceNo: (json['need_company_licence_no'] as num?)?.toInt(),
      needCompanyLicenceFile:
          (json['need_company_licence_file'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'need_company_name': instance.needCompanyName,
      'need_company_licence_no': instance.needCompanyLicenceNo,
      'need_company_licence_file': instance.needCompanyLicenceFile,
    };
