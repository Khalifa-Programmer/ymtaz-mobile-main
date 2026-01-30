// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPackageModel _$MyPackageModelFromJson(Map<String, dynamic> json) =>
    MyPackageModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyPackageModelToJson(MyPackageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      package: json['package'] == null
          ? null
          : Package.fromJson(json['package'] as Map<String, dynamic>),
      remainingServices: (json['remaining_services'] as num?)?.toInt(),
      remainingAdvisoryServices:
          (json['remaining_advisory_services'] as num?)?.toInt(),
      remainingReservations: (json['remaining_reservations'] as num?)?.toInt(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'remaining_services': instance.remainingServices,
      'remaining_advisory_services': instance.remainingAdvisoryServices,
      'remaining_reservations': instance.remainingReservations,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      instructions: json['instructions'] as String?,
      durationType: (json['durationType'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      priceBeforeDiscount: (json['priceBeforeDiscount'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
      numberOfAdvisoryServices:
          (json['number_of_advisory_services'] as num?)?.toInt(),
      numberOfServices: (json['number_of_services'] as num?)?.toInt(),
      numberOfReservations: (json['number_of_reservations'] as num?)?.toInt(),
      subscribed: json['subscribed'] as bool?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      advisoryServicesTypes: (json['advisoryServicesTypes'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicesType.fromJson(e as Map<String, dynamic>))
          .toList(),
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'instructions': instance.instructions,
      'durationType': instance.durationType,
      'duration': instance.duration,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'number_of_advisory_services': instance.numberOfAdvisoryServices,
      'number_of_services': instance.numberOfServices,
      'number_of_reservations': instance.numberOfReservations,
      'subscribed': instance.subscribed,
      'services': instance.services,
      'advisoryServicesTypes': instance.advisoryServicesTypes,
      'reservations': instance.reservations,
      'permissions': instance.permissions,
    };

AdvisoryServicesType _$AdvisoryServicesTypeFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesType(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      advisoryServicePrices: (json['advisory_service_prices'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoryServicesTypeToJson(
        AdvisoryServicesType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'advisory_service_prices': instance.advisoryServicePrices,
    };

AdvisoryServicePrice _$AdvisoryServicePriceFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicePrice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      requestLevel: (json['request_level'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdvisoryServicePriceToJson(
        AdvisoryServicePrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_id': instance.advisoryServiceId,
      'request_level': instance.requestLevel,
      'price': instance.price,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      typesImportance: (json['typesImportance'] as List<dynamic>?)
          ?.map((e) => TypesImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'typesImportance': instance.typesImportance,
    };

TypesImportance _$TypesImportanceFromJson(Map<String, dynamic> json) =>
    TypesImportance(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      reservationImportanceId:
          (json['reservation_importance_id'] as num?)?.toInt(),
      reservationImportance: json['reservation_importance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['reservation_importance'] as Map<String, dynamic>),
      isYmtaz: (json['isYmtaz'] as num?)?.toInt(),
      lawyer: json['lawyer'] == null
          ? null
          : Lawyer.fromJson(json['lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TypesImportanceToJson(TypesImportance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'reservation_importance_id': instance.reservationImportanceId,
      'reservation_importance': instance.reservationImportance,
      'isYmtaz': instance.isYmtaz,
      'lawyer': instance.lawyer,
    };

Lawyer _$LawyerFromJson(Map<String, dynamic> json) => Lawyer(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCode: (json['phone_code'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      image: json['image'] as String?,
      nationality: json['nationality'] == null
          ? null
          : ReservationImportance.fromJson(
              json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : ReservationImportance.fromJson(
              json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : ReservationImportance.fromJson(
              json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : AccurateSpecialty.fromJson(json['city'] as Map<String, dynamic>),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      gender: json['gender'] as String?,
      token: json['token'],
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
      daysStreak: (json['daysStreak'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      xp: (json['xp'] as num?)?.toInt(),
      currentLevel: (json['currentLevel'] as num?)?.toInt(),
      currentRank: json['currentRank'] == null
          ? null
          : CurrentRank.fromJson(json['currentRank'] as Map<String, dynamic>),
      xpUntilNextLevel: (json['xpUntilNextLevel'] as num?)?.toInt(),
      referralCode: json['referralCode'] as String?,
      lastSeen: json['lastSeen'] as String?,
      emailConfirmation: (json['email_confirmation'] as num?)?.toInt(),
      phoneConfirmation: (json['phone_confirmation'] as num?)?.toInt(),
      profileComplete: (json['profile_complete'] as num?)?.toInt(),
      accountType: json['account_type'] as String?,
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'],
      fourthName: json['fourth_name'] as String?,
      about: json['about'] as String?,
      accurateSpecialty: json['accurate_specialty'] == null
          ? null
          : AccurateSpecialty.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : AccurateSpecialty.fromJson(
              json['general_specialty'] as Map<String, dynamic>),
      degree: json['degree'] == null
          ? null
          : Degree.fromJson(json['degree'] as Map<String, dynamic>),
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      birthDate: json['birth_date'] as String?,
      identityType: (json['identity_type'] as num?)?.toInt(),
      nationalId: json['national_id'] as String?,
      functionalCases: json['functional_cases'] == null
          ? null
          : AccurateSpecialty.fromJson(
              json['functional_cases'] as Map<String, dynamic>),
      companyName: json['company_name'] as String?,
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      idFile: json['id_file'] as String?,
      cv: json['cv'] as String?,
      degreeCertificate: json['degree_certificate'] as String?,
      companyLicencesNo: json['company_licences_no'],
      companyLicensesFile: json['company_licenses_file'],
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      workTimes: (json['work_times'] as List<dynamic>?)
          ?.map((e) => WorkTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map(
              (e) => ReservationImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map(
              (e) => ReservationImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasBadge: json['hasBadge'] as String?,
    );

Map<String, dynamic> _$LawyerToJson(Lawyer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'phone_code': instance.phoneCode,
      'type': instance.type,
      'image': instance.image,
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'gender': instance.gender,
      'token': instance.token,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'daysStreak': instance.daysStreak,
      'points': instance.points,
      'xp': instance.xp,
      'currentLevel': instance.currentLevel,
      'currentRank': instance.currentRank,
      'xpUntilNextLevel': instance.xpUntilNextLevel,
      'referralCode': instance.referralCode,
      'lastSeen': instance.lastSeen,
      'email_confirmation': instance.emailConfirmation,
      'phone_confirmation': instance.phoneConfirmation,
      'profile_complete': instance.profileComplete,
      'account_type': instance.accountType,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'third_name': instance.thirdName,
      'fourth_name': instance.fourthName,
      'about': instance.about,
      'accurate_specialty': instance.accurateSpecialty,
      'general_specialty': instance.generalSpecialty,
      'degree': instance.degree,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'birth_date': instance.birthDate,
      'identity_type': instance.identityType,
      'national_id': instance.nationalId,
      'functional_cases': instance.functionalCases,
      'company_name': instance.companyName,
      'is_favorite': instance.isFavorite,
      'special': instance.special,
      'logo': instance.logo,
      'id_file': instance.idFile,
      'cv': instance.cv,
      'degree_certificate': instance.degreeCertificate,
      'company_licences_no': instance.companyLicencesNo,
      'company_licenses_file': instance.companyLicensesFile,
      'sections': instance.sections,
      'work_times': instance.workTimes,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'languages': instance.languages,
      'permissions': instance.permissions,
      'hasBadge': instance.hasBadge,
    };

AccurateSpecialty _$AccurateSpecialtyFromJson(Map<String, dynamic> json) =>
    AccurateSpecialty(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$AccurateSpecialtyToJson(AccurateSpecialty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

ReservationImportance _$ReservationImportanceFromJson(
        Map<String, dynamic> json) =>
    ReservationImportance(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ReservationImportanceToJson(
        ReservationImportance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CurrentRank _$CurrentRankFromJson(Map<String, dynamic> json) => CurrentRank(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      borderColor: json['border_color'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CurrentRankToJson(CurrentRank instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'border_color': instance.borderColor,
      'image': instance.image,
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
      lawyerLicenseNo: json['lawyer_license_no'],
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

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) => WorkTime(
      service: json['service'] as String?,
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'service': instance.service,
      'days': instance.days,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      dayOfWeek: json['dayOfWeek'] as String?,
      timeSlots: (json['timeSlots'] as List<dynamic>?)
          ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'timeSlots': instance.timeSlots,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      intro: json['intro'] as String?,
      details: json['details'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
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
      'need_appointment': instance.needAppointment,
      'ymtaz_levels_prices': instance.ymtazLevelsPrices,
    };

YmtazLevelsPrice _$YmtazLevelsPriceFromJson(Map<String, dynamic> json) =>
    YmtazLevelsPrice(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : ReservationImportance.fromJson(
              json['level'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
      'isHidden': instance.isHidden,
    };

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
