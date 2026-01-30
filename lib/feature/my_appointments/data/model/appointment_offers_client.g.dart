// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_offers_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentOffersClient _$AppointmentOffersClientFromJson(
        Map<String, dynamic> json) =>
    AppointmentOffersClient(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentOffersClientToJson(
        AppointmentOffersClient instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      offers: json['offers'] == null
          ? null
          : Offers.fromJson(json['offers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'offers': instance.offers,
    };

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      accepted: (json['accepted'] as List<dynamic>?)
          ?.map((e) => Accepted.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingAcceptance: (json['pending-acceptance'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOffer: (json['pending-offer'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      cancelledByClient: (json['cancelled-by-client'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'accepted': instance.accepted,
      'pending-acceptance': instance.pendingAcceptance,
      'pending-offer': instance.pendingOffer,
      'cancelled-by-client': instance.cancelledByClient,
    };

Accepted _$AcceptedFromJson(Map<String, dynamic> json) => Accepted(
      id: (json['id'] as num?)?.toInt(),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      description: json['description'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      countryId: json['country_id'],
      regionId: (json['region_id'] as num?)?.toInt(),
      file: json['file'],
      price: json['price'] as String?,
      hours: (json['hours'] as num?)?.toInt(),
      reservationStarted: (json['reservation_started'] as num?)?.toInt(),
      reservationStartedTime: json['reservation_startedTime'] as String?,
      reservationCode: json['reservation_code'] as String?,
      lawyer: json['lawyer'] == null
          ? null
          : Lawyer.fromJson(json['lawyer'] as Map<String, dynamic>),
      reservationType: json['reservationType'] == null
          ? null
          : ReservationType.fromJson(
              json['reservationType'] as Map<String, dynamic>),
      reservationImportance: json['reservationImportance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['reservationImportance'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AcceptedToJson(Accepted instance) => <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'description': instance.description,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'date': instance.date?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'country_id': instance.countryId,
      'region_id': instance.regionId,
      'file': instance.file,
      'price': instance.price,
      'hours': instance.hours,
      'reservation_started': instance.reservationStarted,
      'reservation_startedTime': instance.reservationStartedTime,
      'reservation_code': instance.reservationCode,
      'lawyer': instance.lawyer,
      'reservationType': instance.reservationType,
      'reservationImportance': instance.reservationImportance,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCode: (json['phone_code'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      image: json['image'] as String?,
      nationality: json['nationality'] == null
          ? null
          : Country.fromJson(json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Country.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : ReservationImportance.fromJson(
              json['city'] as Map<String, dynamic>),
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
      subscribed: json['subscribed'] as bool?,
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'],
      fourthName: json['fourth_name'] as String?,
      about: json['about'] as String?,
      accurateSpecialty: json['accurate_specialty'] == null
          ? null
          : ReservationImportance.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : ReservationImportance.fromJson(
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
          : ReservationImportance.fromJson(
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
          ?.map((e) => AccountSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      workTimes: (json['work_times'] as List<dynamic>?)
          ?.map((e) => WorkTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      languages: json['languages'] as List<dynamic>?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasBadge: json['hasBadge'],
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
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
      'subscribed': instance.subscribed,
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

ReservationImportance _$ReservationImportanceFromJson(
        Map<String, dynamic> json) =>
    ReservationImportance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ReservationImportanceToJson(
        ReservationImportance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
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

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

AccountSection _$AccountSectionFromJson(Map<String, dynamic> json) =>
    AccountSection(
      id: (json['id'] as num?)?.toInt(),
      section: json['section'] == null
          ? null
          : SectionSection.fromJson(json['section'] as Map<String, dynamic>),
      lawyerLicenseNo: json['lawyer_license_no'] as String?,
      lawyerLicenseFile: json['lawyer_license_file'] as String?,
    );

Map<String, dynamic> _$AccountSectionToJson(AccountSection instance) =>
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

Lawyer _$LawyerFromJson(Map<String, dynamic> json) => Lawyer(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nationality: json['nationality'] == null
          ? null
          : Country.fromJson(json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Country.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : ReservationImportance.fromJson(
              json['city'] as Map<String, dynamic>),
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      currentLevel: (json['currentLevel'] as num?)?.toInt(),
      currentRank: json['currentRank'] == null
          ? null
          : CurrentRank.fromJson(json['currentRank'] as Map<String, dynamic>),
      lastSeen: json['lastSeen'] as String?,
      accountType: json['account_type'] as String?,
      subscribed: json['subscribed'] as bool?,
      about: json['about'] as String?,
      accurateSpecialty: json['accurate_specialty'] == null
          ? null
          : ReservationImportance.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : ReservationImportance.fromJson(
              json['general_specialty'] as Map<String, dynamic>),
      degree: json['degree'] == null
          ? null
          : Degree.fromJson(json['degree'] as Map<String, dynamic>),
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => LawyerSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasBadge: json['hasBadge'],
    );

Map<String, dynamic> _$LawyerToJson(Lawyer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'image': instance.image,
      'gender': instance.gender,
      'currentLevel': instance.currentLevel,
      'currentRank': instance.currentRank,
      'lastSeen': instance.lastSeen,
      'account_type': instance.accountType,
      'subscribed': instance.subscribed,
      'about': instance.about,
      'accurate_specialty': instance.accurateSpecialty,
      'general_specialty': instance.generalSpecialty,
      'degree': instance.degree,
      'is_favorite': instance.isFavorite,
      'special': instance.special,
      'logo': instance.logo,
      'sections': instance.sections,
      'permissions': instance.permissions,
      'hasBadge': instance.hasBadge,
    };

LawyerSection _$LawyerSectionFromJson(Map<String, dynamic> json) =>
    LawyerSection(
      id: (json['id'] as num?)?.toInt(),
      section: json['section'] == null
          ? null
          : SectionSection.fromJson(json['section'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawyerSectionToJson(LawyerSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section': instance.section,
    };

ReservationType _$ReservationTypeFromJson(Map<String, dynamic> json) =>
    ReservationType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReservationTypeToJson(ReservationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: (json['id'] as num?)?.toInt(),
      reservationType: json['reservation_type'] == null
          ? null
          : ReservationType.fromJson(
              json['reservation_type'] as Map<String, dynamic>),
      importance: json['importance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['importance'] as Map<String, dynamic>),
      accountId: json['account_id'] == null
          ? null
          : Lawyer.fromJson(json['account_id'] as Map<String, dynamic>),
      lawyerId: json['lawyer_id'] == null
          ? null
          : Lawyer.fromJson(json['lawyer_id'] as Map<String, dynamic>),
      price: json['price'],
      description: json['description'] as String?,
      file: json['file'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      hours: (json['hours'] as num?)?.toInt(),
      status: json['status'] as String?,
      regionId: json['region_id'] == null
          ? null
          : RegionId.fromJson(json['region_id'] as Map<String, dynamic>),
      cityId: json['city_id'] == null
          ? null
          : ReservationImportance.fromJson(
              json['city_id'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'reservation_type': instance.reservationType,
      'importance': instance.importance,
      'account_id': instance.accountId,
      'lawyer_id': instance.lawyerId,
      'price': instance.price,
      'description': instance.description,
      'file': instance.file,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'day': instance.day?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'hours': instance.hours,
      'status': instance.status,
      'region_id': instance.regionId,
      'city_id': instance.cityId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

RegionId _$RegionIdFromJson(Map<String, dynamic> json) => RegionId(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      cities: (json['cities'] as List<dynamic>?)
          ?.map(
              (e) => ReservationImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegionIdToJson(RegionId instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cities': instance.cities,
    };
