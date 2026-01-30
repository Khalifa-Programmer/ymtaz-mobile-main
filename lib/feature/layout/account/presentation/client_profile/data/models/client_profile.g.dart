// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientProfile _$ClientProfileFromJson(Map<String, dynamic> json) =>
    ClientProfile(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientProfileToJson(ClientProfile instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'client': instance.client,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneCode: json['phone_code'] as String?,
      mobile: json['mobile'] as String?,
      type: (json['type'] as num?)?.toInt(),
      email: json['email'] as String?,
      image: json['image'] as String?,
      nationality: json['nationality'] == null
          ? null
          : CountryClient.fromJson(json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : CountryClient.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : CountryClient.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : CityClient.fromJson(json['city'] as Map<String, dynamic>),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      gender: json['gender '],
      token: json['token'],
      accepted: (json['accepted'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      confirmationType: json['confirmationType'] as String?,
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
    )
      ..createdAt = json['createdAt'] as String?
      ..daysStreak = (json['daysStreak'] as num?)?.toInt()
      ..points = (json['points'] as num?)?.toInt()
      ..xp = (json['xp'] as num?)?.toInt()
      ..currentLevel = (json['currentLevel'] as num?)?.toInt()
      ..xpUntilNextLevel = (json['xpUntilNextLevel'] as num?)?.toInt()
      ..currentRank = json['currentRank'] == null
          ? null
          : CurrentRank.fromJson(json['currentRank'] as Map<String, dynamic>)
      ..referralCode = json['referralCode'] as String?
      ..lastSeen = json['lastSeen'] as String?;

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_code': instance.phoneCode,
      'mobile': instance.mobile,
      'type': instance.type,
      'email': instance.email,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'nationality': instance.nationality,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'gender ': instance.gender,
      'token': instance.token,
      'accepted': instance.accepted,
      'active': instance.active,
      'confirmationType': instance.confirmationType,
      'daysStreak': instance.daysStreak,
      'points': instance.points,
      'xp': instance.xp,
      'currentLevel': instance.currentLevel,
      'xpUntilNextLevel': instance.xpUntilNextLevel,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'currentRank': instance.currentRank,
      'referralCode': instance.referralCode,
      'lastSeen': instance.lastSeen,
    };

CityClient _$CityClientFromJson(Map<String, dynamic> json) => CityClient(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityClientToJson(CityClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

CountryClient _$CountryClientFromJson(Map<String, dynamic> json) =>
    CountryClient(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryClientToJson(CountryClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
