// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_contact_ymtaz_Response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyContactYmtazResponse _$MyContactYmtazResponseFromJson(
        Map<String, dynamic> json) =>
    MyContactYmtazResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyContactYmtazResponseToJson(
        MyContactYmtazResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      contactRequests: (json['contactRequests'] as List<dynamic>?)
          ?.map((e) => ContactRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'contactRequests': instance.contactRequests,
    };

ContactRequest _$ContactRequestFromJson(Map<String, dynamic> json) =>
    ContactRequest(
      id: (json['id'] as num?)?.toInt(),
      reserverType: json['reserverType'] as String?,
      serviceUserId: (json['service_user_id'] as num?)?.toInt(),
      lawyerId: json['lawyer_id'],
      subject: json['subject'] as String?,
      details: json['details'] as String?,
      type: (json['type'] as num?)?.toInt(),
      replySubject: json['reply_subject'],
      replyDescription: json['reply_description'],
      replyUserId: json['reply_user_id'],
      file: json['file'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      user: json['user'],
      lawyer: json['lawyer'],
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactRequestToJson(ContactRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reserverType': instance.reserverType,
      'service_user_id': instance.serviceUserId,
      'lawyer_id': instance.lawyerId,
      'subject': instance.subject,
      'details': instance.details,
      'type': instance.type,
      'reply_subject': instance.replySubject,
      'reply_description': instance.replyDescription,
      'reply_user_id': instance.replyUserId,
      'file': instance.file,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'user': instance.user,
      'lawyer': instance.lawyer,
      'client': instance.client,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: (json['id'] as num?)?.toInt(),
      countryId: (json['country_id'] as num?)?.toInt(),
      cityId: json['city_id'] as String?,
      username: json['username'],
      myname: json['myname'] as String?,
      image: json['image'],
      mobil: json['mobil'] as String?,
      nationalityId: json['nationality_id'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      email: json['email'] as String?,
      passCode: json['pass_code'],
      passReset: (json['pass_reset'] as num?)?.toInt(),
      acceptRules: json['accept_rules'],
      type: (json['type'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      activationType: (json['activation_type'] as num?)?.toInt(),
      activeOtp: json['active_otp'],
      deviceId: json['device_id'],
      deletedAt: json['deleted_at'],
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      regionId: json['region_id'] as String?,
      phoneCode: json['phone_code'] as String?,
      gender: json['gender'] as String?,
      accepted: (json['accepted'] as num?)?.toInt(),
      streamioId: json['streamio_id'] as String?,
      streamioToken: json['streamio_token'] as String?,
      confirmationType: json['confirmationType'],
      confirmationOtp: json['confirmationOtp'],
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'city_id': instance.cityId,
      'username': instance.username,
      'myname': instance.myname,
      'image': instance.image,
      'mobil': instance.mobil,
      'nationality_id': instance.nationalityId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'email': instance.email,
      'pass_code': instance.passCode,
      'pass_reset': instance.passReset,
      'accept_rules': instance.acceptRules,
      'type': instance.type,
      'active': instance.active,
      'activation_type': instance.activationType,
      'active_otp': instance.activeOtp,
      'device_id': instance.deviceId,
      'deleted_at': instance.deletedAt,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'region_id': instance.regionId,
      'phone_code': instance.phoneCode,
      'gender': instance.gender,
      'accepted': instance.accepted,
      'streamio_id': instance.streamioId,
      'streamio_token': instance.streamioToken,
      'confirmationType': instance.confirmationType,
      'confirmationOtp': instance.confirmationOtp,
    };
