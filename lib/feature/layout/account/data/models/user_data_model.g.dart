// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      client: json['lawyer'] == null
          ? null
          : Client.fromJson(json['lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawyer': instance.client,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'],
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCode: json['phone_code'] as String?,
      about: json['about'] as String?,
      accurateSpecialty: json['accurate_specialty'] == null
          ? null
          : AccurateSpecialtyUser.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : AccurateSpecialtyUser.fromJson(
              json['general_specialty'] as Map<String, dynamic>),
      degree: json['degree'] == null
          ? null
          : UserDegree.fromJson(json['degree'] as Map<String, dynamic>),
      gender: json['gender'] as String?,
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      nationality: json['nationality'] == null
          ? null
          : UserNationality.fromJson(
              json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : UserCountry.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : UserRegion.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : UserCity.fromJson(json['city'] as Map<String, dynamic>),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      type: (json['type'] as num?)?.toInt(),
      identityType: (json['identity_type'] as num?)?.toInt(),
      natId: json['nat_id'] as String?,
      functionalCases: json['functional_cases'] == null
          ? null
          : AccurateSpecialtyUser.fromJson(
              json['functional_cases'] as Map<String, dynamic>),
      licenceNo: json['licence_no'] as String?,
      companyLisencesNo: json['company_lisences_no'],
      companyName: json['company_name'],
      officeRequestStatus: (json['office_request_status'] as num?)?.toInt(),
      officeRequestFrom: json['office_request_from'],
      officeRequestTo: json['office_request_to'],
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      idFile: json['id_file'] as String?,
      licenseFile: json['license_file'],
      cv: json['cv'] as String?,
      degreeCertificate: json['degree_certificate'],
      photo: json['photo'] as String?,
      companyLisencesFile: json['company_lisences_file'],
      acceptRules: (json['accept_rules'] as num?)?.toInt(),
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: json['services'] as List<dynamic>?,
      workTimes: json['work_times'] as List<dynamic>?,
      ratesCount: json['rates_count'],
      ratesAvg: json['rates_avg'],
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      digitalGuideSubscriptionPaymentStatus:
          (json['digital_guide_subscription_payment_status'] as num?)?.toInt(),
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
      confirmationType: json['confirmationType'] as String?,
      accepted: (json['accepted'] as num?)?.toInt(),
    )
      ..createdAt = json['createdAt'] as String?
      ..daysStreak = (json['daysStreak'] as num?)?.toInt()
      ..points = (json['points'] as num?)?.toInt()
      ..xp = (json['xp'] as num?)?.toInt()
      ..currentLevel = (json['currentLevel'] as num?)?.toInt()
      ..xpUntilNextLevel = (json['xpUntilNextLevel'] as num?)?.toInt()
      ..otherDegree = json['other_degree'] as String?
      ..currentRank = json['currentRank'] == null
          ? null
          : CurrentRank.fromJson(json['currentRank'] as Map<String, dynamic>)
      ..referralCode = json['referralCode'] as String?
      ..lastSeen = json['lastSeen'] as String?
      ..languages = (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'phone_code': instance.phoneCode,
      'about': instance.about,
      'createdAt': instance.createdAt,
      'accurate_specialty': instance.accurateSpecialty,
      'general_specialty': instance.generalSpecialty,
      'degree': instance.degree,
      'gender': instance.gender,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'birthday': instance.birthday?.toIso8601String(),
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'type': instance.type,
      'identity_type': instance.identityType,
      'nat_id': instance.natId,
      'functional_cases': instance.functionalCases,
      'licence_no': instance.licenceNo,
      'company_lisences_no': instance.companyLisencesNo,
      'company_name': instance.companyName,
      'office_request_status': instance.officeRequestStatus,
      'office_request_from': instance.officeRequestFrom,
      'office_request_to': instance.officeRequestTo,
      'is_favorite': instance.isFavorite,
      'special': instance.special,
      'logo': instance.logo,
      'id_file': instance.idFile,
      'license_file': instance.licenseFile,
      'cv': instance.cv,
      'degree_certificate': instance.degreeCertificate,
      'photo': instance.photo,
      'company_lisences_file': instance.companyLisencesFile,
      'accept_rules': instance.acceptRules,
      'sections': instance.sections,
      'services': instance.services,
      'work_times': instance.workTimes,
      'rates_count': instance.ratesCount,
      'rates_avg': instance.ratesAvg,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'daysStreak': instance.daysStreak,
      'points': instance.points,
      'xp': instance.xp,
      'currentLevel': instance.currentLevel,
      'xpUntilNextLevel': instance.xpUntilNextLevel,
      'confirmationType': instance.confirmationType,
      'other_degree': instance.otherDegree,
      'currentRank': instance.currentRank,
      'referralCode': instance.referralCode,
      'lastSeen': instance.lastSeen,
      'accepted': instance.accepted,
      'languages': instance.languages,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'digital_guide_subscription_payment_status':
          instance.digitalGuideSubscriptionPaymentStatus,
    };

AccurateSpecialtyUser _$AccurateSpecialtyUserFromJson(
        Map<String, dynamic> json) =>
    AccurateSpecialtyUser(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$AccurateSpecialtyUserToJson(
        AccurateSpecialtyUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

UserDegree _$UserDegreeFromJson(Map<String, dynamic> json) => UserDegree(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      needCertificate: (json['need_certificate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDegreeToJson(UserDegree instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'need_certificate': instance.needCertificate,
    };

SectionElement _$SectionElementFromJson(Map<String, dynamic> json) =>
    SectionElement(
      id: (json['id'] as num?)?.toInt(),
      section: json['section'] == null
          ? null
          : SectionSection.fromJson(json['section'] as Map<String, dynamic>),
      lawyerLicenseNo: json['lawyer_license_no'] as String?,
      lawyerLicenseFile: json['lawyer_license_file'] as String?,
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

UserCountry _$UserCountryFromJson(Map<String, dynamic> json) => UserCountry(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserCountryToJson(UserCountry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserRegion _$UserRegionFromJson(Map<String, dynamic> json) => UserRegion(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserRegionToJson(UserRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserCity _$UserCityFromJson(Map<String, dynamic> json) => UserCity(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$UserCityToJson(UserCity instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

UserNationality _$UserNationalityFromJson(Map<String, dynamic> json) =>
    UserNationality(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserNationalityToJson(UserNationality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
