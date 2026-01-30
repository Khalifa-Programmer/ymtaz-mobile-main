// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryRequestResponse _$AdvisoryRequestResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryRequestResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryRequestResponseToJson(
        AdvisoryRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservation: json['reservation'] == null
          ? null
          : Reservation.fromJson(json['reservation'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservation': instance.reservation,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      description: json['description'] as String?,
      files: json['files'] as List<dynamic>?,
      requestStatus: json['request_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      price: (json['price'] as num?)?.toInt(),
      acceptDate: json['accept_date'] as String?,
      reservationStatus: json['reservation_status'] as String?,
      advisoryServicesSub: json['advisory_services_sub'] == null
          ? null
          : AdvisoryServicesSub.fromJson(
              json['advisory_services_sub'] as Map<String, dynamic>),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      lawyer: json['lawyer'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
      callId: json['call_id'],
      appointmentDuration: json['appointment_duration'],
      replyStatus: (json['reply_status'] as num?)?.toInt(),
      replySubject: json['reply_subject'],
      replyContent: json['reply_content'],
      replyFiles: json['reply_files'] as List<dynamic>?,
      replyTime: json['reply_time'],
      replyDate: json['reply_date'],
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'description': instance.description,
      'files': instance.files,
      'request_status': instance.requestStatus,
      'payment_status': instance.paymentStatus,
      'price': instance.price,
      'accept_date': instance.acceptDate,
      'reservation_status': instance.reservationStatus,
      'advisory_services_sub': instance.advisoryServicesSub,
      'importance': instance.importance,
      'created_at': instance.createdAt,
      'lawyer': instance.lawyer,
      'from': instance.from,
      'to': instance.to,
      'date': instance.date,
      'call_id': instance.callId,
      'appointment_duration': instance.appointmentDuration,
      'reply_status': instance.replyStatus,
      'reply_subject': instance.replySubject,
      'reply_content': instance.replyContent,
      'reply_files': instance.replyFiles,
      'reply_time': instance.replyTime,
      'reply_date': instance.replyDate,
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
          : Importance.fromJson(json['city'] as Map<String, dynamic>),
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
          : Importance.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : Importance.fromJson(
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
          : Importance.fromJson(
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
      languages: json['languages'] as List<dynamic>?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasBadge: json['hasBadge'] as String?,
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

Importance _$ImportanceFromJson(Map<String, dynamic> json) => Importance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ImportanceToJson(Importance instance) =>
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

AdvisoryServicesSub _$AdvisoryServicesSubFromJson(Map<String, dynamic> json) =>
    AdvisoryServicesSub(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      generalCategory: json['general_category'] == null
          ? null
          : GeneralCategory.fromJson(
              json['general_category'] as Map<String, dynamic>),
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => Level.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisoryServicesSubToJson(
        AdvisoryServicesSub instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'general_category': instance.generalCategory,
      'levels': instance.levels,
    };

GeneralCategory _$GeneralCategoryFromJson(Map<String, dynamic> json) =>
    GeneralCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      paymentCategoryType: json['payment_category_type'] == null
          ? null
          : PaymentCategoryType.fromJson(
              json['payment_category_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralCategoryToJson(GeneralCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'payment_category_type': instance.paymentCategoryType,
    };

PaymentCategoryType _$PaymentCategoryTypeFromJson(Map<String, dynamic> json) =>
    PaymentCategoryType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      requiresAppointment: (json['requires_appointment'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentCategoryTypeToJson(
        PaymentCategoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'requires_appointment': instance.requiresAppointment,
    };

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : Importance.fromJson(json['level'] as Map<String, dynamic>),
      price: json['price'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'level': instance.level,
      'price': instance.price,
    };
