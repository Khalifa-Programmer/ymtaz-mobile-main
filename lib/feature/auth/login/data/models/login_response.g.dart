// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
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
          : Country.fromJson(json['nationality'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Country.fromJson(json['region'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      gender: json['gender '] as String?,
      token: json['token'] as String?,
      accepted: (json['accepted'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      confirmationType: json['confirmationType'] as String?,
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_code': instance.phoneCode,
      'mobile': instance.mobile,
      'type': instance.type,
      'email': instance.email,
      'image': instance.image,
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
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
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
