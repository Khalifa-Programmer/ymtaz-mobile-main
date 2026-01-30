// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_advisors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAdvisorsResponse _$MyAdvisorsResponseFromJson(Map<String, dynamic> json) =>
    MyAdvisorsResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyAdvisorsResponseToJson(MyAdvisorsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservations': instance.reservations,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      file: json['file'],
      paymentStatus: json['payment_status'] as String?,
      price: (json['price'] as num?)?.toInt(),
      replayStatus: (json['replay_status'] as num?)?.toInt(),
      replaySubject: json['replay_subject'],
      replayContent: json['replay_content'],
      replayFile: json['replay_file'],
      replayTime: json['replay_time'],
      replayDate: json['replay_date'],
      acceptDate: json['accept_date'],
      reservationStatus: json['reservation_status'] as String?,
      advisoryServicesId: json['advisory_services_id'] == null
          ? null
          : AdvisoryServicesId.fromJson(
              json['advisory_services_id'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : Importance.fromJson(json['type'] as Map<String, dynamic>),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
      appointment: json['appointment'],
      lawyer: json['lawyer'],
      rate: json['rate'],
      comment: json['comment'],
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'file': instance.file,
      'payment_status': instance.paymentStatus,
      'price': instance.price,
      'replay_status': instance.replayStatus,
      'replay_subject': instance.replaySubject,
      'replay_content': instance.replayContent,
      'replay_file': instance.replayFile,
      'replay_time': instance.replayTime,
      'replay_date': instance.replayDate,
      'accept_date': instance.acceptDate,
      'reservation_status': instance.reservationStatus,
      'advisory_services_id': instance.advisoryServicesId,
      'type': instance.type,
      'importance': instance.importance,
      'appointment': instance.appointment,
      'lawyer': instance.lawyer,
      'rate': instance.rate,
      'comment': instance.comment,
    };

AdvisoryServicesId _$AdvisoryServicesIdFromJson(Map<String, dynamic> json) =>
    AdvisoryServicesId(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      price: (json['price'] as num?)?.toInt(),
      phone: json['phone'],
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      image: json['image'],
      availableDates: json['available_dates'] as List<dynamic>?,
    );

Map<String, dynamic> _$AdvisoryServicesIdToJson(AdvisoryServicesId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructions': instance.instructions,
      'price': instance.price,
      'phone': instance.phone,
      'need_appointment': instance.needAppointment,
      'image': instance.image,
      'available_dates': instance.availableDates,
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
