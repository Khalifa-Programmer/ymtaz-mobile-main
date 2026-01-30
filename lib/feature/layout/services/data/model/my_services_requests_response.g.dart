// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_services_requests_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyServicesRequestsResponse _$MyServicesRequestsResponseFromJson(
        Map<String, dynamic> json) =>
    MyServicesRequestsResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyServicesRequestsResponseToJson(
        MyServicesRequestsResponse instance) =>
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
      declined: (json['declined'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      accepted: (json['accepted'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOffer: (json['pending-offer'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingAcceptance: (json['pending-acceptance'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'declined': instance.declined,
      'accepted': instance.accepted,
      'pending-offer': instance.pendingOffer,
      'pending-acceptance': instance.pendingAcceptance,
    };

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: (json['id'] as num?)?.toInt(),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Priority.fromJson(json['priority'] as Map<String, dynamic>),
      description: json['description'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => AcceptedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as String?,
      lawyer: json['lawyer'] == null
          ? null
          : Account.fromJson(json['lawyer'] as Map<String, dynamic>),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'service': instance.service,
      'priority': instance.priority,
      'description': instance.description,
      'files': instance.files,
      'price': instance.price,
      'lawyer': instance.lawyer,
      'status': instance.status,
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
          : Priority.fromJson(json['city'] as Map<String, dynamic>),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      gender: json['gender'] as String?,
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
      emailConfirmation: (json['email_confirmation'] as num?)?.toInt(),
      phoneConfirmation: (json['phone_confirmation'] as num?)?.toInt(),
      profileComplete: (json['profile_complete'] as num?)?.toInt(),
      accountType: json['account_type'] as String?,
      subscribed: json['subscribed'] as bool?,
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
      'email_confirmation': instance.emailConfirmation,
      'phone_confirmation': instance.phoneConfirmation,
      'profile_complete': instance.profileComplete,
      'account_type': instance.accountType,
      'subscribed': instance.subscribed,
    };

Priority _$PriorityFromJson(Map<String, dynamic> json) => Priority(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PriorityToJson(Priority instance) => <String, dynamic>{
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

AcceptedFile _$AcceptedFileFromJson(Map<String, dynamic> json) => AcceptedFile(
      file: json['file'] as String?,
      isVoice: (json['is_voice'] as num?)?.toInt(),
      isReply: (json['is_reply'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AcceptedFileToJson(AcceptedFile instance) =>
    <String, dynamic>{
      'file': instance.file,
      'is_voice': instance.isVoice,
      'is_reply': instance.isReply,
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
          : Country.fromJson(json['level'] as Map<String, dynamic>),
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
          : Country.fromJson(json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Country.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : Priority.fromJson(json['city'] as Map<String, dynamic>),
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
    )
      ..accurateSpecialty = json['accurate_specialty'] == null
          ? null
          : Priority.fromJson(
              json['accurate_specialty'] as Map<String, dynamic>)
      ..generalSpecialty = json['general_specialty'] == null
          ? null
          : Priority.fromJson(json['general_specialty'] as Map<String, dynamic>)
      ..degree = json['degree'] == null
          ? null
          : Degree.fromJson(json['degree'] as Map<String, dynamic>)
      ..day = json['day'] as String?
      ..month = json['month'] as String?
      ..year = json['year'] as String?
      ..birthDate = json['birth_date'] as String?
      ..identityType = (json['identity_type'] as num?)?.toInt();

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
    };
