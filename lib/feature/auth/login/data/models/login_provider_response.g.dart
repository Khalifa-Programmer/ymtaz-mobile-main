// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginProviderResponse _$LoginProviderResponseFromJson(
        Map<String, dynamic> json) =>
    LoginProviderResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginProviderResponseToJson(
        LoginProviderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'account': instance.account,
      'token': instance.token,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'] as String?,
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      about: json['about'] as String?,
      birthday: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      photo: json['image'] as String?,
      image: json['photo'] as String?,
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      officeRequestStatus: (json['office_request_status'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratesCount: json['rates_count'],
      ratesAvg: json['rates_avg'],
      token: json['token'] as String?,
      accepted: (json['accepted'] as num?)?.toInt(),
      confirmationType: json['confirmationType'] as String?,
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
      currentLevel: (json['currentLevel'] as num?)?.toInt(),
      xp: (json['xp'] as num?)?.toInt(),
      xpUntilNextLevel: (json['xpUntilNextLevel'] as num?)?.toInt(),
      currentRank: json['currentRank'] == null
          ? null
          : Rank.fromJson(json['currentRank'] as Map<String, dynamic>),
      lastSeen: json['lastSeen'] as String?,
      referralCode: json['referralCode'] as String?,
      emailConfirmation: (json['email_confirmation'] as num?)?.toInt(),
      phoneConfirmation: (json['phone_confirmation'] as num?)?.toInt(),
      profileComplete: (json['profile_complete'] as num?)?.toInt(),
      accountType: json['account_type'] as String?,
      accurateSpecialty: json['accurate_specialty'] == null
          ? null
          : Specialty.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : Specialty.fromJson(
              json['general_specialty'] as Map<String, dynamic>),
      degree: json['degree'] == null
          ? null
          : Degree.fromJson(json['degree'] as Map<String, dynamic>),
      phoneCode: (json['phone_code'] as num?)?.toInt(),
      package: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    )
      ..status = (json['status'] as num?)?.toInt()
      ..nationality = json['nationality'] == null
          ? null
          : UserNationality.fromJson(
              json['nationality'] as Map<String, dynamic>)
      ..country = json['country'] == null
          ? null
          : UserCountry.fromJson(json['country'] as Map<String, dynamic>)
      ..region = json['region'] == null
          ? null
          : UserRegion.fromJson(json['region'] as Map<String, dynamic>)
      ..city = json['city'] == null
          ? null
          : UserCity.fromJson(json['city'] as Map<String, dynamic>)
      ..longitude = json['longitude'] as String?
      ..latitude = json['latitude'] as String?
      ..type = (json['type'] as num?)?.toInt()
      ..identityType = (json['identity_type'] as num?)?.toInt()
      ..natId = json['national_id'] as String?
      ..functionalCases = json['functional_cases'] == null
          ? null
          : AccurateSpecialtyUser.fromJson(
              json['functional_cases'] as Map<String, dynamic>)
      ..licenceNo = json['licence_no'] as String?
      ..digitalGuideSubscription =
          (json['digital_guide_subscription'] as num?)?.toInt()
      ..daysStreak = (json['daysStreak'] as num?)?.toInt()
      ..points = (json['points'] as num?)?.toInt()
      ..languages = (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList()
      ..otherDegree = json['other_degree'] as String?
      ..createdAt = json['createdAt'] as String?
      ..companyLisencesFile = json['company_lisences_file']
      ..companyLisencesNo = json['company_lisences_no']
      ..companyName = json['company_name']
      ..logo = json['logo'] as String?
      ..idFile = json['id_file'] as String?
      ..licenseFile = json['license_file']
      ..cv = json['cv'] as String?
      ..degreeCertificate = json['degree_certificate']
      ..officeRequestFrom = json['office_request_from']
      ..officeRequestTo = json['office_request_to']
      ..hasBadge = json['hasBadge'] as String?
      ..subscribed = json['subscribed'] as bool?
      ..experiences = (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'name': instance.name,
      'status': instance.status,
      'email': instance.email,
      'gender': instance.gender,
      'phone': instance.phone,
      'about': instance.about,
      'birth_date': instance.birthday?.toIso8601String(),
      'image': instance.photo,
      'photo': instance.image,
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'type': instance.type,
      'identity_type': instance.identityType,
      'national_id': instance.natId,
      'functional_cases': instance.functionalCases,
      'licence_no': instance.licenceNo,
      'is_favorite': instance.isFavorite,
      'office_request_status': instance.officeRequestStatus,
      'special': instance.special,
      'sections': instance.sections,
      'rates_count': instance.ratesCount,
      'rates_avg': instance.ratesAvg,
      'token': instance.token,
      'accepted': instance.accepted,
      'confirmationType': instance.confirmationType,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'currentLevel': instance.currentLevel,
      'xp': instance.xp,
      'xpUntilNextLevel': instance.xpUntilNextLevel,
      'currentRank': instance.currentRank,
      'lastSeen': instance.lastSeen,
      'referralCode': instance.referralCode,
      'email_confirmation': instance.emailConfirmation,
      'phone_confirmation': instance.phoneConfirmation,
      'profile_complete': instance.profileComplete,
      'account_type': instance.accountType,
      'accurate_specialty': instance.accurateSpecialty,
      'general_specialty': instance.generalSpecialty,
      'degree': instance.degree,
      'phone_code': instance.phoneCode,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'daysStreak': instance.daysStreak,
      'points': instance.points,
      'languages': instance.languages,
      'other_degree': instance.otherDegree,
      'createdAt': instance.createdAt,
      'company_lisences_file': instance.companyLisencesFile,
      'company_lisences_no': instance.companyLisencesNo,
      'company_name': instance.companyName,
      'logo': instance.logo,
      'id_file': instance.idFile,
      'license_file': instance.licenseFile,
      'cv': instance.cv,
      'degree_certificate': instance.degreeCertificate,
      'office_request_from': instance.officeRequestFrom,
      'office_request_to': instance.officeRequestTo,
      'hasBadge': instance.hasBadge,
      'subscribed': instance.subscribed,
      'experiences': instance.experiences,
      'subscription': instance.package,
    };

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: (json['id'] as num?)?.toInt(),
      package: json['package'] == null
          ? null
          : Package.fromJson(json['package'] as Map<String, dynamic>),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      durationType: (json['durationType'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'durationType': instance.durationType,
      'duration': instance.duration,
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

Rank _$RankFromJson(Map<String, dynamic> json) => Rank(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      borderColor: json['border_color'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$RankToJson(Rank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'border_color': instance.borderColor,
      'image': instance.image,
    };

Specialty _$SpecialtyFromJson(Map<String, dynamic> json) => Specialty(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$SpecialtyToJson(Specialty instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      isSpecial: (json['isSpecial'] as num?)?.toInt(),
      needCertificate: (json['need_certificate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isSpecial': instance.isSpecial,
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
