// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_office_reservations_lawyer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentOfficeReservationsLawyer
    _$AppointmentOfficeReservationsLawyerFromJson(Map<String, dynamic> json) =>
        AppointmentOfficeReservationsLawyer(
          status: json['status'] as bool?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : DataAppointmetnsLawyer.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AppointmentOfficeReservationsLawyerToJson(
        AppointmentOfficeReservationsLawyer instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

DataAppointmetnsLawyer _$DataAppointmetnsLawyerFromJson(
        Map<String, dynamic> json) =>
    DataAppointmetnsLawyer(
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataAppointmetnsLawyerToJson(
        DataAppointmetnsLawyer instance) =>
    <String, dynamic>{
      'reservations': instance.reservations,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      clientId: (json['client_id'] as num?)?.toInt(),
      lawyerId: json['lawyer_id'],
      description: json['description'] as String?,
      longitude: (json['longitude'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      countryId: (json['country_id'] as num?)?.toInt(),
      regionId: (json['region_id'] as num?)?.toInt(),
      file: json['file'],
      hours: json['hours'] as String?,
      reservationEnded: (json['reservationEnded'] as num?)?.toInt(),
      reservationEndedTime: json['reservationEndedTime'],
      reservedFromLawyer: json['reservedFromLawyer'] == null
          ? null
          : ReservedFromLawyer.fromJson(
              json['reservedFromLawyer'] as Map<String, dynamic>),
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

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'lawyer_id': instance.lawyerId,
      'description': instance.description,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'date': instance.date?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'country_id': instance.countryId,
      'region_id': instance.regionId,
      'file': instance.file,
      'hours': instance.hours,
      'reservationEnded': instance.reservationEnded,
      'reservationEndedTime': instance.reservationEndedTime,
      'reservedFromLawyer': instance.reservedFromLawyer,
      'reservationType': instance.reservationType,
      'reservationImportance': instance.reservationImportance,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
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

ReservedFromLawyer _$ReservedFromLawyerFromJson(Map<String, dynamic> json) =>
    ReservedFromLawyer(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      thirdName: json['third_name'] as String?,
      fourthName: json['fourth_name'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCode: json['phone_code'] as String?,
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
      gender: json['gender'] as String?,
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
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
      type: (json['type'] as num?)?.toInt(),
      identityType: (json['identity_type'] as num?)?.toInt(),
      natId: json['nat_id'] as String?,
      functionalCases: json['functional_cases'] == null
          ? null
          : AccurateSpecialty.fromJson(
              json['functional_cases'] as Map<String, dynamic>),
      companyLisencesNo: json['company_lisences_no'] as String?,
      companyName: json['company_name'] as String?,
      officeRequestStatus: (json['office_request_status'] as num?)?.toInt(),
      officeRequestFrom: json['office_request_from'],
      officeRequestTo: json['office_request_to'],
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      idFile: json['id_file'] as String?,
      cv: json['cv'] as String?,
      degreeCertificate: json['degree_certificate'],
      photo: json['photo'] as String?,
      companyLisencesFile: json['company_lisences_file'],
      acceptRules: (json['accept_rules'] as num?)?.toInt(),
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      workTimes: json['work_times'] as List<dynamic>?,
      ratesCount: json['rates_count'],
      ratesAvg: json['rates_avg'],
      digitalGuideSubscription:
          (json['digital_guide_subscription'] as num?)?.toInt(),
      digitalGuideSubscriptionPaymentStatus:
          (json['digital_guide_subscription_payment_status'] as num?)?.toInt(),
      accepted: (json['accepted'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReservedFromLawyerToJson(ReservedFromLawyer instance) =>
    <String, dynamic>{
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
      'company_lisences_no': instance.companyLisencesNo,
      'company_name': instance.companyName,
      'office_request_status': instance.officeRequestStatus,
      'office_request_from': instance.officeRequestFrom,
      'office_request_to': instance.officeRequestTo,
      'is_favorite': instance.isFavorite,
      'special': instance.special,
      'logo': instance.logo,
      'id_file': instance.idFile,
      'cv': instance.cv,
      'degree_certificate': instance.degreeCertificate,
      'photo': instance.photo,
      'company_lisences_file': instance.companyLisencesFile,
      'accept_rules': instance.acceptRules,
      'sections': instance.sections,
      'work_times': instance.workTimes,
      'rates_count': instance.ratesCount,
      'rates_avg': instance.ratesAvg,
      'digital_guide_subscription': instance.digitalGuideSubscription,
      'digital_guide_subscription_payment_status':
          instance.digitalGuideSubscriptionPaymentStatus,
      'accepted': instance.accepted,
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
