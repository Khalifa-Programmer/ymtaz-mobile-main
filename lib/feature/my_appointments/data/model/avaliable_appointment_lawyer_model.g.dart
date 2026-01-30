// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliable_appointment_lawyer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliableAppointmentLawyerModel _$AvaliableAppointmentLawyerModelFromJson(
        Map<String, dynamic> json) =>
    AvaliableAppointmentLawyerModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvaliableAppointmentLawyerModelToJson(
        AvaliableAppointmentLawyerModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      reservationType: json['reservation_type'] == null
          ? null
          : ReservationType.fromJson(
              json['reservation_type'] as Map<String, dynamic>),
      reservationImportance: json['reservation_importance'] == null
          ? null
          : ReservationImportance.fromJson(
              json['reservation_importance'] as Map<String, dynamic>),
      isYmtaz: (json['isYmtaz'] as num?)?.toInt(),
      lawyer: json['lawyer'] == null
          ? null
          : Lawyer.fromJson(json['lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'reservation_type': instance.reservationType,
      'reservation_importance': instance.reservationImportance,
      'isYmtaz': instance.isYmtaz,
      'lawyer': instance.lawyer,
    };

Lawyer _$LawyerFromJson(Map<String, dynamic> json) => Lawyer(
      id: json['id'] as String?,
      name: json['name'] as String?,
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
          : AccurateSpecialty.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : AccurateSpecialty.fromJson(
              json['general_specialty'] as Map<String, dynamic>),
      degree: json['degree'] == null
          ? null
          : Degree.fromJson(json['degree'] as Map<String, dynamic>),
      isFavorite: (json['is_favorite'] as num?)?.toInt(),
      special: (json['special'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionElement.fromJson(e as Map<String, dynamic>))
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
    );

Map<String, dynamic> _$SectionElementToJson(SectionElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section': instance.section,
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

ReservationType _$ReservationTypeFromJson(Map<String, dynamic> json) =>
    ReservationType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] as String?,
      isHidden: (json['isHidden'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReservationTypeToJson(ReservationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'isHidden': instance.isHidden,
    };
