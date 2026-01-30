// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_added.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastAdded _$LastAddedFromJson(Map<String, dynamic> json) => LastAdded(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LastAddedToJson(LastAdded instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      mostBought: json['mostBought'] == null
          ? null
          : MostBought.fromJson(json['mostBought'] as Map<String, dynamic>),
      latestCreated: json['latestCreated'] == null
          ? null
          : LatestCreated.fromJson(
              json['latestCreated'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'mostBought': instance.mostBought,
      'latestCreated': instance.latestCreated,
    };

LatestCreated _$LatestCreatedFromJson(Map<String, dynamic> json) =>
    LatestCreated(
      advisoryServices: (json['advisoryServices'] as List<dynamic>?)
          ?.map((e) =>
              LatestCreatedAdvisoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => LatestCreatedService.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestCreatedToJson(LatestCreated instance) =>
    <String, dynamic>{
      'advisoryServices': instance.advisoryServices,
      'services': instance.services,
      'appointments': instance.appointments,
    };

LatestCreatedAdvisoryService _$LatestCreatedAdvisoryServiceFromJson(
        Map<String, dynamic> json) =>
    LatestCreatedAdvisoryService(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      generalCategory: json['general_category'] == null
          ? null
          : PurpleGeneralCategory.fromJson(
              json['general_category'] as Map<String, dynamic>),
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => LevelElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestCreatedAdvisoryServiceToJson(
        LatestCreatedAdvisoryService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'general_category': instance.generalCategory,
      'levels': instance.levels,
    };

PurpleGeneralCategory _$PurpleGeneralCategoryFromJson(
        Map<String, dynamic> json) =>
    PurpleGeneralCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
      paymentCategoryType: json['payment_category_type'] == null
          ? null
          : PaymentCategoryType.fromJson(
              json['payment_category_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurpleGeneralCategoryToJson(
        PurpleGeneralCategory instance) =>
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

LevelElement _$LevelElementFromJson(Map<String, dynamic> json) => LevelElement(
      id: (json['id'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : AccurateSpecialtyClass.fromJson(
              json['level'] as Map<String, dynamic>),
      price: json['price'] as String?,
    );

Map<String, dynamic> _$LevelElementToJson(LevelElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'level': instance.level,
      'price': instance.price,
    };

AccurateSpecialtyClass _$AccurateSpecialtyClassFromJson(
        Map<String, dynamic> json) =>
    AccurateSpecialtyClass(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$AccurateSpecialtyClassToJson(
        AccurateSpecialtyClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      typesImportance: (json['typesImportance'] as List<dynamic>?)
          ?.map((e) => TypesImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
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
          : AccurateSpecialtyClass.fromJson(
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
          : AccurateSpecialtyClass.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : AccurateSpecialtyClass.fromJson(
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
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'experiences': instance.experiences,
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

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      id: (json['id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'title': instance.title,
      'company': instance.company,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
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

LatestCreatedService _$LatestCreatedServiceFromJson(
        Map<String, dynamic> json) =>
    LatestCreatedService(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      intro: json['intro'] as String?,
      details: json['details'],
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      ymtazLevelsPrices: (json['ymtaz_levels_prices'] as List<dynamic>?)
          ?.map((e) => YmtazLevelsPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestCreatedServiceToJson(
        LatestCreatedService instance) =>
    <String, dynamic>{
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
      duration: (json['duration'] as num?)?.toInt(),
      isHidden: (json['isHidden'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YmtazLevelsPriceToJson(YmtazLevelsPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'price': instance.price,
      'duration': instance.duration,
      'isHidden': instance.isHidden,
    };

MostBought _$MostBoughtFromJson(Map<String, dynamic> json) => MostBought(
      advisoryServices: (json['advisoryServices'] as List<dynamic>?)
          ?.map((e) =>
              MostBoughtAdvisoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => MostBoughtService.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MostBoughtToJson(MostBought instance) =>
    <String, dynamic>{
      'advisoryServices': instance.advisoryServices,
      'services': instance.services,
      'appointments': instance.appointments,
    };

MostBoughtAdvisoryService _$MostBoughtAdvisoryServiceFromJson(
        Map<String, dynamic> json) =>
    MostBoughtAdvisoryService(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      generalCategory: json['general_category'] == null
          ? null
          : FluffyGeneralCategory.fromJson(
              json['general_category'] as Map<String, dynamic>),
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => LevelElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MostBoughtAdvisoryServiceToJson(
        MostBoughtAdvisoryService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'general_category': instance.generalCategory,
      'levels': instance.levels,
    };

FluffyGeneralCategory _$FluffyGeneralCategoryFromJson(
        Map<String, dynamic> json) =>
    FluffyGeneralCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      paymentCategoryType: json['payment_category_type'] == null
          ? null
          : PaymentCategoryType.fromJson(
              json['payment_category_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FluffyGeneralCategoryToJson(
        FluffyGeneralCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'payment_category_type': instance.paymentCategoryType,
    };

MostBoughtService _$MostBoughtServiceFromJson(Map<String, dynamic> json) =>
    MostBoughtService(
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

Map<String, dynamic> _$MostBoughtServiceToJson(MostBoughtService instance) =>
    <String, dynamic>{
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
