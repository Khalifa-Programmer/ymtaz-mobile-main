// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_from_provider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesFromProviderResponse _$ServicesFromProviderResponseFromJson(
        Map<String, dynamic> json) =>
    ServicesFromProviderResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesFromProviderResponseToJson(
        ServicesFromProviderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      serviceRequests: (json['service_requests'] as List<dynamic>?)
          ?.map((e) => ServiceRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'service_requests': instance.serviceRequests,
    };

ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) =>
    ServiceRequest(
      id: (json['id'] as num?)?.toInt(),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Priority.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      file: json['file'],
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      requestStatus: (json['request_status'] as num?)?.toInt(),
      forAdmin: json['for_admin'] as String?,
      replayStatus: json['replay_status'] as String?,
      replay: json['replay'] as String?,
      replayFile: json['replay_file'],
      replayTime: json['replay_time'] as String?,
      replayDate: json['replay_date'] as String?,
      referralStatus: (json['referral_status'] as num?)?.toInt(),
      requesterLawyer: json['requesterLawyer'] == null
          ? null
          : RequesterLawyer.fromJson(
              json['requesterLawyer'] as Map<String, dynamic>),
      rate: json['rate'],
      comment: json['comment'],
    );

Map<String, dynamic> _$ServiceRequestToJson(ServiceRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'priority': instance.priority,
      'description': instance.description,
      'file': instance.file,
      'price': instance.price,
      'created_at': instance.createdAt,
      'request_status': instance.requestStatus,
      'for_admin': instance.forAdmin,
      'replay_status': instance.replayStatus,
      'replay': instance.replay,
      'replay_file': instance.replayFile,
      'replay_time': instance.replayTime,
      'replay_date': instance.replayDate,
      'referral_status': instance.referralStatus,
      'requesterLawyer': instance.requesterLawyer,
      'rate': instance.rate,
      'comment': instance.comment,
    };

Priority _$PriorityFromJson(Map<String, dynamic> json) => Priority(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PriorityToJson(Priority instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

RequesterLawyer _$RequesterLawyerFromJson(Map<String, dynamic> json) =>
    RequesterLawyer(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'] as String?,
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      identityType: (json['identity_type'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      photo: json['photo'] as String?,
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      digitalGuideSubscriptionPaymentStatus:
          (json['digital_guide_subscription_payment_status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RequesterLawyerToJson(RequesterLawyer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'type': instance.type,
      'identity_type': instance.identityType,
      'logo': instance.logo,
      'photo': instance.photo,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'digital_guide_subscription_payment_status':
          instance.digitalGuideSubscriptionPaymentStatus,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      needCertificate: (json['need_certificate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
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

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      intro: json['intro'] as String?,
      details: json['details'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      ymtazLevelsPrices: (json['ymtaz_levels_prices'] as List<dynamic>?)
          ?.map((e) => YmtazLevelsPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'details': instance.details,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'ymtaz_levels_prices': instance.ymtazLevelsPrices,
    };

YmtazLevelsPrice _$YmtazLevelsPriceFromJson(Map<String, dynamic> json) =>
    YmtazLevelsPrice(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
    };
