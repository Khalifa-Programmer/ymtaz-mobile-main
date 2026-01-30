// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponseModel _$FavoriteResponseModelFromJson(
        Map<String, dynamic> json) =>
    FavoriteResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavoriteResponseModelToJson(
        FavoriteResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      favouriteLawyers: (json['favouriteLawyers'] as List<dynamic>?)
          ?.map((e) => FavouriteLawyer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'favouriteLawyers': instance.favouriteLawyers,
    };

FavouriteLawyer _$FavouriteLawyerFromJson(Map<String, dynamic> json) =>
    FavouriteLawyer(
      id: (json['id'] as num?)?.toInt(),
      userType: json['userType'] as String?,
      serviceUserId: json['service_user_id'],
      lawyerId: (json['lawyer_id'] as num?)?.toInt(),
      favLawyerId: (json['fav_lawyer_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      favLawyer: json['fav_lawyer'] == null
          ? null
          : FavLawyer.fromJson(json['fav_lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavouriteLawyerToJson(FavouriteLawyer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userType': instance.userType,
      'service_user_id': instance.serviceUserId,
      'lawyer_id': instance.lawyerId,
      'fav_lawyer_id': instance.favLawyerId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'fav_lawyer': instance.favLawyer,
    };

FavLawyer _$FavLawyerFromJson(Map<String, dynamic> json) => FavLawyer(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'],
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      city: (json['city'] as num?)?.toInt(),
      photo: json['photo'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      degree: (json['degree'] as num?)?.toInt(),
      degreeCertificate: json['degree_certificate'],
      phoneCode: json['phone_code'] as String?,
      phone: json['phone'] as String?,
      about: json['about'] as String?,
      natId: json['nat_id'] as String?,
      licenceNo: json['licence_no'] as String?,
      isAdvisor: (json['is_advisor'] as num?)?.toInt(),
      advisorCatId: (json['advisor_cat_id'] as num?)?.toInt(),
      showInAdvoisoryWebsite:
          (json['show_in_advoisory_website'] as num?)?.toInt(),
      accepted: (json['accepted'] as num?)?.toInt(),
      sections: json['sections'] as String?,
      twitter: json['twitter'],
      username: json['username'] as String?,
      countryId: (json['country_id'] as num?)?.toInt(),
      passCode: json['pass_code'],
      passReset: (json['pass_reset'] as num?)?.toInt(),
      officeRequest: (json['office_request'] as num?)?.toInt(),
      officeRequestStatus: (json['office_request_status'] as num?)?.toInt(),
      paidStatus: (json['paid_status'] as num?)?.toInt(),
      officeRequestFrom: json['office_request_from'],
      officeRequestTo: json['office_request_to'],
      acceptRules: (json['accept_rules'] as num?)?.toInt(),
      licenseImage: json['license_image'],
      idImage: json['id_image'],
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      digitalGuideSubscriptionPaymentStatus:
          (json['digital_guide_subscription_payment_status'] as num?)?.toInt(),
      showAtDigitalGuide: (json['show_at_digital_guide'] as num?)?.toInt(),
      digitalGuideSubscriptionFrom: json['digital_guide_subscription_from'],
      digitalGuideSubscriptionTo: json['digital_guide_subscription_to'],
      special: (json['special'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      deviceId: json['device_id'],
      nationality: (json['nationality'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      otherDegree: json['other_degree'],
      companyName: json['company_name'] as String?,
      companyLisencesNo: json['company_lisences_no'],
      companyLisencesFile: json['company_lisences_file'],
      region: (json['region'] as num?)?.toInt(),
      otherCity: json['other_city'],
      identityType: (json['identity_type'] as num?)?.toInt(),
      otherIdetityType: json['other_idetity_type'],
      hasLicenceNo: (json['has_licence_no'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      idFile: json['id_file'] as String?,
      licenseFile: json['license_file'],
      otherEntityName: json['other_entity_name'],
      elseCity: json['else_city'],
      personalImage: json['personal_image'],
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      electronicIdCode: json['electronic_id_code'],
      generalSpecialty: (json['general_specialty'] as num?)?.toInt(),
      accurateSpecialty: (json['accurate_specialty'] as num?)?.toInt(),
      cv: json['cv'],
      district: json['district'],
      profileComplete: (json['profile_complete'] as num?)?.toInt(),
      functionalCases: (json['functional_cases'] as num?)?.toInt(),
      activateEmail: (json['activate_email'] as num?)?.toInt(),
      activateEmailOtp: json['activate_email_otp'] as String?,
    );

Map<String, dynamic> _$FavLawyerToJson(FavLawyer instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'name': instance.name,
      'city': instance.city,
      'photo': instance.photo,
      'email': instance.email,
      'gender': instance.gender,
      'degree': instance.degree,
      'degree_certificate': instance.degreeCertificate,
      'phone_code': instance.phoneCode,
      'phone': instance.phone,
      'about': instance.about,
      'nat_id': instance.natId,
      'licence_no': instance.licenceNo,
      'is_advisor': instance.isAdvisor,
      'advisor_cat_id': instance.advisorCatId,
      'show_in_advoisory_website': instance.showInAdvoisoryWebsite,
      'accepted': instance.accepted,
      'sections': instance.sections,
      'twitter': instance.twitter,
      'username': instance.username,
      'country_id': instance.countryId,
      'pass_code': instance.passCode,
      'pass_reset': instance.passReset,
      'office_request': instance.officeRequest,
      'office_request_status': instance.officeRequestStatus,
      'paid_status': instance.paidStatus,
      'office_request_from': instance.officeRequestFrom,
      'office_request_to': instance.officeRequestTo,
      'accept_rules': instance.acceptRules,
      'license_image': instance.licenseImage,
      'id_image': instance.idImage,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'digital_guide_subscription_payment_status':
          instance.digitalGuideSubscriptionPaymentStatus,
      'show_at_digital_guide': instance.showAtDigitalGuide,
      'digital_guide_subscription_from': instance.digitalGuideSubscriptionFrom,
      'digital_guide_subscription_to': instance.digitalGuideSubscriptionTo,
      'special': instance.special,
      'type': instance.type,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'device_id': instance.deviceId,
      'nationality': instance.nationality,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'birthday': instance.birthday?.toIso8601String(),
      'other_degree': instance.otherDegree,
      'company_name': instance.companyName,
      'company_lisences_no': instance.companyLisencesNo,
      'company_lisences_file': instance.companyLisencesFile,
      'region': instance.region,
      'other_city': instance.otherCity,
      'identity_type': instance.identityType,
      'other_idetity_type': instance.otherIdetityType,
      'has_licence_no': instance.hasLicenceNo,
      'logo': instance.logo,
      'id_file': instance.idFile,
      'license_file': instance.licenseFile,
      'other_entity_name': instance.otherEntityName,
      'else_city': instance.elseCity,
      'personal_image': instance.personalImage,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'electronic_id_code': instance.electronicIdCode,
      'general_specialty': instance.generalSpecialty,
      'accurate_specialty': instance.accurateSpecialty,
      'cv': instance.cv,
      'district': instance.district,
      'profile_complete': instance.profileComplete,
      'functional_cases': instance.functionalCases,
      'activate_email': instance.activateEmail,
      'activate_email_otp': instance.activateEmailOtp,
    };
