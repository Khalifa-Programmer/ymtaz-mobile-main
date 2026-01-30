// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_offers_lawyer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentOffersLawyer _$AppointmentOffersLawyerFromJson(
        Map<String, dynamic> json) =>
    AppointmentOffersLawyer(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentOffersLawyerToJson(
        AppointmentOffersLawyer instance) =>
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
      cancelledByClient: (json['cancelled-by-client'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOffer: (json['pending-offer'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..pendingAcceptance = (json['pending-acceptance'] as List<dynamic>?)
        ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'cancelled-by-client': instance.cancelledByClient,
      'pending-offer': instance.pendingOffer,
      'pending-acceptance': instance.pendingAcceptance,
    };

CancelledByClient _$CancelledByClientFromJson(Map<String, dynamic> json) =>
    CancelledByClient(
      id: (json['id'] as num?)?.toInt(),
      reservationType: json['reservation_type'] == null
          ? null
          : ReservationType.fromJson(
              json['reservation_type'] as Map<String, dynamic>),
      importance: json['importance'] == null
          ? null
          : CityId.fromJson(json['importance'] as Map<String, dynamic>),
      accountId: json['account_id'] == null
          ? null
          : Id.fromJson(json['account_id'] as Map<String, dynamic>),
      lawyerId: json['lawyer_id'] == null
          ? null
          : Id.fromJson(json['lawyer_id'] as Map<String, dynamic>),
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
          : CityId.fromJson(json['city_id'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CancelledByClientToJson(CancelledByClient instance) =>
    <String, dynamic>{
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

Id _$IdFromJson(Map<String, dynamic> json) => Id(
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
          : CityId.fromJson(json['city'] as Map<String, dynamic>),
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
          : CityId.fromJson(json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : CityId.fromJson(json['general_specialty'] as Map<String, dynamic>),
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

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
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

CityId _$CityIdFromJson(Map<String, dynamic> json) => CityId(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityIdToJson(CityId instance) => <String, dynamic>{
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

RegionId _$RegionIdFromJson(Map<String, dynamic> json) => RegionId(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => CityId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegionIdToJson(RegionId instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cities': instance.cities,
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
          : CityId.fromJson(json['importance'] as Map<String, dynamic>),
      accountId: json['account_id'] == null
          ? null
          : AccountId.fromJson(json['account_id'] as Map<String, dynamic>),
      lawyerId: json['lawyer_id'] == null
          ? null
          : Id.fromJson(json['lawyer_id'] as Map<String, dynamic>),
      price: json['price'],
      description: json['description'] as String?,
      file: json['file'],
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
          : CityId.fromJson(json['city_id'] as Map<String, dynamic>),
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

AccountId _$AccountIdFromJson(Map<String, dynamic> json) => AccountId(
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
          : CityId.fromJson(json['city'] as Map<String, dynamic>),
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
          : CityId.fromJson(json['accurate_specialty'] as Map<String, dynamic>),
      generalSpecialty: json['general_specialty'] == null
          ? null
          : CityId.fromJson(json['general_specialty'] as Map<String, dynamic>),
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

Map<String, dynamic> _$AccountIdToJson(AccountId instance) => <String, dynamic>{
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
