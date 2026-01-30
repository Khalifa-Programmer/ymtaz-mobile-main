// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_provider_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpProviderResponse _$SignUpProviderResponseFromJson(
        Map<String, dynamic> json) =>
    SignUpProviderResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpProviderResponseToJson(
        SignUpProviderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lawyer: json['lawyer'] == null
          ? null
          : Lawyer.fromJson(json['lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawyer': instance.lawyer,
    };

Lawyer _$LawyerFromJson(Map<String, dynamic> json) => Lawyer(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'] as bool?,
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      about: json['about'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      photo: json['photo'] as String?,
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      officeRequestStatus: (json['office_request_status'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratesCount: json['rates_count'],
      ratesAvg: json['rates_avg'],
      token: json['token'],
      accepted: (json['accepted'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      confirmationType: json['confirmationType'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
      streamioId: json['streamio_id'],
      streamioToken: json['streamio_token'],
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$LawyerToJson(Lawyer instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'phone': instance.phone,
      'about': instance.about,
      'birthday': instance.birthday?.toIso8601String(),
      'photo': instance.photo,
      'is_favorite': instance.isFavorite,
      'office_request_status': instance.officeRequestStatus,
      'special': instance.special,
      'sections': instance.sections,
      'rates_count': instance.ratesCount,
      'rates_avg': instance.ratesAvg,
      'token': instance.token,
      'accepted': instance.accepted,
      'active': instance.active,
      'confirmationType': instance.confirmationType,
      'languages': instance.languages,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'createdAt': instance.createdAt,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SectionElement _$SectionElementFromJson(Map<String, dynamic> json) =>
    SectionElement(
      id: (json['id'] as num?)?.toInt(),
      section: json['section'] == null
          ? null
          : SectionSection.fromJson(json['section'] as Map<String, dynamic>),
      lawyerLicenseNo: json['lawyer_license_no'] as String?,
      lawyerLicenseFile: json['lawyer_license_file'],
    );

Map<String, dynamic> _$SectionElementToJson(SectionElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section': instance.section,
      'lawyer_license_no': instance.lawyerLicenseNo,
      'lawyer_license_file': instance.lawyerLicenseFile,
    };

SectionSection _$SectionSectionFromJson(Map<String, dynamic> json) =>
    SectionSection(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      needLicense: (json['need_license'] as num?)?.toInt(),
      lawyersCount: (json['lawyers_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SectionSectionToJson(SectionSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'need_license': instance.needLicense,
      'lawyers_count': instance.lawyersCount,
    };
