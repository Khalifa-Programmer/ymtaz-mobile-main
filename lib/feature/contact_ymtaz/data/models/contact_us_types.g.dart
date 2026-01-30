// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsTypes _$ContactUsTypesFromJson(Map<String, dynamic> json) =>
    ContactUsTypes(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContactUsTypesToJson(ContactUsTypes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      contactTypes: (json['contactTypes'] as List<dynamic>?)
          ?.map((e) => ContactType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'contactTypes': instance.contactTypes,
    };

ContactType _$ContactTypeFromJson(Map<String, dynamic> json) => ContactType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ContactTypeToJson(ContactType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
